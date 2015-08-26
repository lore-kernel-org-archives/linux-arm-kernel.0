From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Wed, 26 Aug 2015 11:09:50 +0530
Subject: [PATCH v3] qcom: ipq40xx: Add basic board/dts support for
 IPQ40XX SoC
In-Reply-To: <20150825211405.GJ19120@codeaurora.org>
References: <20150824092813.GA15581@codeaurora.org>
 <20150824224928.GE14330@codeaurora.org>
 <20150825081042.GA14028@codeaurora.org>
 <20150825211405.GJ19120@codeaurora.org>
Message-ID: <20150826053950.GB25312@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 02:14:05PM -0700, Stephen Boyd wrote:
> On 08/25, Varadarajan Narayanan wrote:
> > On Mon, Aug 24, 2015 at 03:49:28PM -0700, Stephen Boyd wrote:
> > > On 08/24, Varadarajan Narayanan wrote:
> >
> > > > +	compatible = "qcom,ipq40xx-r3pc", "qcom,ipq40xx";
> > > > +
> > > > +	memory {
> > > > +		device_type = "memory";
> > > > +		reg = <0x80000000 0x20000000>; /* 512MB */
> > > > +	};
> > >
> > > Doesn't the bootloader fill the memory node for us? Why do we
> > > need this?
> > >
> > > > +
> > > > +	chosen {
> > > > +		bootargs = "root=/dev/ram rw init=/init console=ttyMSM0,115200n8 initrd=0x82000000,0x000E2246";
> > > > +	};
> > >
> > > Please don't add bootargs. Use stdout-path for the console part
> > > and everything else should be done by the bootloader or is the
> > > defaults.
> >
> > Since this is for the emulation platform, we don't have the bootloader.
>
> Why are we upstreaming an emulation platform?

Ok, will skip this.

-Varada

> I assume you have some sort of scripts or something to load the
> kernel image into the emulator, so those scripts could go and
> modify the dtb in place to populate the initrd and commandline.
> If you need pointers on that feel free to contact me directly.
>
> >
> > > > +			compatible = "arm,armv7-timer";
> > > > +			interrupts = <1 2 0xf08>,
> > > > +				     <1 3 0xf08>,
> > > > +				     <1 4 0xf08>,
> > > > +				     <1 1 0xf08>;
> > > > +			clock-frequency = <20833333>;
> > >
> > > Drop this clock-frequency part if you can. The hardware should
> > > properly report the frequency.
> >
> > Cannot drop this. This is the ref-clock frequency. For the
> > chip it is 48MHz, for emulation is ~20MHz. Similar to
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/qcom-msm8974.dtsi#n89
>
> And the hardware is not emulated properly to report the actual
> frequency that the timer is running at? That's sad.
>
> At the least, this should be in the board specific dtsi file
> instead of the SoC specific file, because it's a board quirk.
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
