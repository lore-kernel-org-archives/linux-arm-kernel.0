From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 18:06:08 +0000
Subject: [question] kernel build fails with O0 gcc optimization flag
In-Reply-To: <20151125171229.GA8415@yury-N73SV>
References: <20151125171229.GA8415@yury-N73SV>
Message-ID: <20151125180606.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 08:12:29PM +0300, Yury Norov wrote:
> Hi all.
> 
> I changed optimization from O2 to O0 in Makefile:
>         609 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>         610 KBUILD_CFLAGS   += -Os $(call cc-disable-warning,maybe-uninitialized,)
>         611 else
>         612 KBUILD_CFLAGS   += -O2 <-- here
>         613 endif

-O0 is not supported, sorry.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
