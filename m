From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 19:14:53 +0200
Subject: [PATCH] ARM: VDSO: depend on CPU_V7
In-Reply-To: <552FE447.6020001@mentor.com>
References: <1428529265-26772-1-git-send-email-nathan_lynch@mentor.com>
 <20150416161049.GB12732@n2100.arm.linux.org.uk> <552FE447.6020001@mentor.com>
Message-ID: <2997269.UTdCCDvBHc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 11:33:11 Nathan Lynch wrote:
> 
> if I do 'make arch/arm/vdso/' but otherwise the build system doesn't
> seem to enter that directory here.
> 
> Still looking into it though.
> 

Ah, my mistake. I typed 'make arch/arm/vdso' and expected the files
to all be left out, but instead the way the Makefile is written, it
does not enter the directory at all when VDSO is turned off.

I tried it again now, building the kernel normally and that works, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arn
