From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 17:37:12 +0100
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
 <561E63C9.3040702@mentor.com>
 <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
Message-ID: <20151015163712.GD32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 07:52:38AM +0200, H. Nikolaus Schaller wrote:
> ERROR: space prohibited before that close parenthesis ')'
> #46: FILE: arch/arm/vdso/vdsomunge.c:64:
> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))

I have a pet hatred of too many parens.  I also have a hatred of idiotic
casts.  What about changing the above to one of:

		(((x) & 0xff00) >> 8)
		(((x) >> 8) & 0xff)

> 
> ERROR: space prohibited before that close parenthesis ')'
> #53: FILE: arch/arm/vdso/vdsomunge.c:71:
> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))

and one of:

		(((x) & 0xff000000) >> 24)
		(((x) >> 24) & 0xff)

?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
