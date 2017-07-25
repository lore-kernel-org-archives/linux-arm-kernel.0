From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Jul 2017 16:30:16 +0200
Subject: [PATCH 1/4] arm: multi_v7: Add AXP20X_POWER
In-Reply-To: <CAGb2v65TMPh8iVAzM=8bakqh15r01AumAUJdpqm8hWh+kxWKjg@mail.gmail.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
 <CAGb2v65TMPh8iVAzM=8bakqh15r01AumAUJdpqm8hWh+kxWKjg@mail.gmail.com>
Message-ID: <20170725143016.4std25kzz64gx7or@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 04:14:17PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The multi_v7 defconfig is missing the AXP209 USB power supply driver,
> > resulting in non-working USB controllers because the USB PHY will always
> > return EPROBE_DEFER.
> >
> > Make sure it's selected.
> 
> This seems weird. You only change it from a module to built-in.
> AFAIK, the module does have proper module aliases, and the mfd
> core does give out proper uevents for modaliases.
> 
> Is the module not getting loaded? Or is it loaded too late?

Nevermind, after reading this back, the commit log is wrong, like you
suggested. The only odd thing is that everything else in order to have
USB working without modules is there but the PHY.

But I guess it's fine.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/07cba3fc/attachment.sig>
