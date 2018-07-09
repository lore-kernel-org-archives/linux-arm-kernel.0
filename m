From: martin@lucina.net (Martin Lucina)
Date: Mon, 9 Jul 2018 16:49:46 +0200
Subject: [linux-sunxi] Re: [PATCH 05/10] arm64: dts: allwinner: a64:
 Olinuxino: enable USB
In-Reply-To: <ff9389d1-c476-d5cf-8c4a-e0eae84e3642@arm.com>
References: <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
 <548f2eb5-b457-8fcd-c043-b897a447d96c@arm.com>
 <52713A44-E2BB-4388-A98F-D49AA3B6EAC3@aosc.io>
 <4b4d1662-4266-593c-79a9-39eea8fb668c@arm.com>
 <373C4D2E-E2CF-4AE9-9AC4-69AD4AF95AF4@aosc.io>
 <5b9a0818-b28e-76de-17b9-721c0950b64b@arm.com>
 <20180709101509.pg2p5kompy35hc3k@nodbug.lucina.net>
 <1d2c3a9f-ec57-ebd2-a8d1-fcd7a84e0e91@arm.com>
 <20180709115426.6r42bxqcypxvikep@nodbug.lucina.net>
 <ff9389d1-c476-d5cf-8c4a-e0eae84e3642@arm.com>
Message-ID: <20180709144946.qgiucndzd5rvjrpn@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, 09.07.2018 at?14:43, Andre Przywara wrote:
> >> Can you please try using the .dts I attached?
> > 
> > The .dts you attached does not compile, you've added a "&simplefb_hdmi"
> > node, did you mean something else?
> 
> Ah, right, sorry about that. That was against sunxi/dt64-for-4.19 (as
> the whole series was). So the base .dtsi is different.
> Attaching the .dtb this time ...

Ah, where exactly is that tree? I'm still testing with Linus' v4.18-rc2,
which is probably wrong. Booting with that dtb gives me the same result re
USB.

> Do you have fixed regulator support in your kernel?
> CONFIG_REGULATOR_FIXED_VOLTAGE=y or fixed.ko as a module.

Yes.

> > ...if I remove that node, then I get:
> > 
> > [    0.289065] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
> > ...
> > [    1.554921] sun4i-usb-phy 1c19400.phy: Couldn't get regulator usb0_vbus... Deferring probe
> > ...
> > [    1.659943] sun4i-usb-phy 1c19400.phy: Couldn't get regulator usb0_vbus... Deferring probe
> > 
> > and no USB.
> > 
> > (guessing) Did you mean to add a &usb1_vbus?
> 
> Well, this regulator name should indeed read usb1_vbus now. But this is
> mostly about the name. Changed this anyway in the attached .dtb.
> 
> But this failure in getting the GPIO looks suspicious. Do you have uart1
> enabled, by any chance? As its CTS pin is on PG9.

Not that I know of, and looking at the schematic there's no way I can get
at that pin to test?

Martin
