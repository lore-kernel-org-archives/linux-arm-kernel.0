From: broonie@kernel.org (Mark Brown)
Date: Sat, 5 May 2018 10:25:13 +0900
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
 <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
 <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
Message-ID: <20180505012513.GJ13402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 07:49:57PM +0100, Robin Murphy wrote:

> I guess there's also the possibility that a single driver may want multiple
> behaviours, if e.g. if SoC variants A and B have some identical peripherals
> but slightly different pinctrl/IOMMU/etc. hardware such that A has workable
> default behaviour and can be treated as optional, whereas B absolutely must
> be controlled by the kernel for the consumers to function properly, and they
> *should* defer forever otherwise. I think that would pretty much demand some
> sort of explicitly-curated white/blacklist setup at the subsystem or driver
> level.

Different board variants, and possibly even different bootloaders might
also be an issue here - a vendor bootloader might do pinmuxing that an
upstream bootloader doesn't for example.  In some cases the pinmuxing
even depends on the boot method with things only getting configured if
the bootloader wanted to use them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/a0a54ead/attachment.sig>
