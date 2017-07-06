From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Jul 2017 09:18:25 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
In-Reply-To: <20170705171607.GG4902@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 5 Jul 2017 18:16:07 +0100")
References: <20170705161333.9315-1-gregory.clement@free-electrons.com>
 <20170705171607.GG4902@n2100.armlinux.org.uk>
Message-ID: <874luqf2ym.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mer., juil. 05 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Wed, Jul 05, 2017 at 06:13:33PM +0200, Gregory CLEMENT wrote:
>> Enable the PCIe interface on the MACCHIATOBin board. It is located on
>> CON12 and is 4 lanes capable.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Why do you folk at free-electrons like doing half a job all the friggin
> time?
>
> You know I have complete patches for mcbin, but you pointedly won't look
> at them at all - except when you have a problem and want to test my tree.
> And even then, you ignore my work (despite testing that it works), and
> you still recreate my patches.
>
> This is really frustrating and insane behaviour on your part.

Sorry for this, I wrongly assumed that if you had the PCIe part you
would have already submitted it. Also I didn't expect there was a gpio
dependency with PCIe because until now I never saw the reset-gpio for
PCIe with the controller I use.

>
> Here's what I have:
>
> +&cpm_pcie0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&cpm_pcie_pins>;
> +       num-lanes = <4>;
> +       reset-gpio = <&cpm_gpio1 20 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
>
> +       cpm_pcie_pins: pcie-pins {
> +               marvell,pins = "mpp52";
> +               marvell,function = "gpio";
> +       };
>
> Since you have merged GPIO and pinmux support for the v4.13 window,
> there's absolutely no reason not to include the GPIO bits.  In fact,
> there's no reason not to consider using my bloody patches.
>
> Except your stupid idiotic NiH problem that you seem to have.
>
> I know that your behaviour in regard of this has been discussed within
> Marvell, and people are getting unhappy with free electron's attitude
> over this.  You need to change, and start working _with_ people instead
> of constantly screwing people over.
>
> So, NAK on your patch.
>
> Once v4.13-rc1 is out, I'll update my patch series for the screw-over
> free-electrons has already done, and post some patches.  I can't do it
> sooner, your work is scattered all over the place which makes it

Actually everything is available in the linux-next branch since one or
two weeks. So you can rebase and send your series right now.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
