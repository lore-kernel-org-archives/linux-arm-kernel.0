From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 06 Oct 2012 23:22:18 -0600
Subject: [PATCH 0/6] ARM: Add support for Broadcom BCM476x SoCs
In-Reply-To: <20121007015300.828366635@gmail.com>
References: <20121007015300.828366635@gmail.com>
Message-ID: <5071118A.6040508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> Howdy,
> 
>   this patchset adds (minimal) support for the Broadcom BCM476x ARM based
> SoCs to the kernel, not to be confused with the already supported MIPS
> based BCM47xx SoC and other BCM47xx WiFi and GPS produced by Broadcom.
> 
> This BCM476x is a DT-only multi-platform ARM platform and, at this spin,

Nice. I was planning on converting bcm2835 to multi-platform in 3.8; I
assume it'll be pretty simple.

...
> Additional support is being worked on.... and usb (DWC OTG) only
> attemped reusing s3c-hsotg.

Hmmm. I believe the bcm2835 uses DWC OTG. I wonder if the same driver
will work there; USB in particular is a major pain point on the bcm2835...

...
> It's based on a random pre v3.7-rc1 commit (eb0ad9c) with mainlined
> multi-platform support and Stephen's patch to add DEBUG_LL to it.

There are two chunks of code related to that; uncompress.h and
debug-macro.S. Rob/Arnd's multi-platform patches already allowed
debug-macro.S to exist after multi-platform conversion, and my patches
were about adding back support for uncompress.h. Given that the only
reason I cared about uncompress was that Tegra's uncompress.h and
debug-macro.s were closely coupled, and Nicolas Pitre indicated he
thought that was a hack, I've re-written the Tegra code so they aren't
coupled any more (this will be included in 3.8) and so I care much less
about uncompress.h now. Unless anyone really pipes up and says they'd
still like me to pursue uncompress.h in multi-platform, I'm inclined to
drop it.

> Special thanks go to Stephen Warren who, with the recently mainlined
> BCM2835, showed how to do things cleanly since the beginning and
> involuntarily spurred me to act.

Thanks! Do note that much of the code I upstreamed was originally
written by others, although I did make quite a few changes during
upstream submission.
