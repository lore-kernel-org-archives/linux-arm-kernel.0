From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Mar 2016 17:53:01 +0100
Subject: [PATCH 2/2] ARM: delete "*Image is ready" log
In-Reply-To: <1459442582-23121-2-git-send-email-yamada.masahiro@socionext.com>
References: <1459442582-23121-1-git-send-email-yamada.masahiro@socionext.com>
 <1459442582-23121-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160331165301.GM19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 01:43:02AM +0900, Masahiro Yamada wrote:
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") fixed bad image generation in case of
> parallel building, but as a side effect, Kbuild now descends into
> arch/arm/boot/ again and again, duplicating the same log messages.
> This is clumsy.
> 
> In the example below (incremental build),
>   "Kernel: arch/arm/boot/Image is ready" is displayed three times.
>   "Kernel: arch/arm/boot/zImage is ready" is displayed twice.

I disagree.  Image and zImage are the final targets that users are
interested in, we should tell people that they've been successfully
created.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
