From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Mar 2016 11:02:06 +0000
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
In-Reply-To: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <20160324095332.GS2566@sirena.org.uk>
 <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Message-ID: <20160324110206.GT2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 07:25:35PM +0900, Krzysztof Kozlowski wrote:
> On Thu, Mar 24, 2016 at 6:53 PM, Mark Brown <broonie@kernel.org> wrote:

> > Why does this regulator even have voltage constraints configured?  Is
> > there any intention that it should ever be varied at runtime?

> Good question. I was also wondering that, if tetting it by 5 mV lower
> causes failure, then the constraints are actually fixed at 3.755 V. I
> do not know the answer. Boards schematics do not specify the
> requirement here, datasheet for PMIC says default value of 3.4V. Heh,

For some reason people seem to frequently want to put the maximum
voltage range for the regulator into the constraints even though that is
almost certainly broken and generally nonsensical.

> maybe the regulator driver is missing proper starting value for 'vsel'
> (datasheet says values in register start from 0x40 -> 3 V). Something
> looks wrong here...

It's possible it's just broken and has never been tested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/b51e07ed/attachment.sig>
