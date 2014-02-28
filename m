From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Feb 2014 10:37:08 -0800
Subject: [PATCH v4 7/9] devicetree: bindings: Document PM8921/8058 keypads
In-Reply-To: <20140228135527.GF7308@joshc.qualcomm.com>
References: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
 <1393552520-9068-8-git-send-email-sboyd@codeaurora.org>
 <20140228135527.GF7308@joshc.qualcomm.com>
Message-ID: <20140228183708.GF2487@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28, Josh Cartwright wrote:
> On Thu, Feb 27, 2014 at 05:55:18PM -0800, Stephen Boyd wrote:
> 
> - linux,wakeup?
> - linux,no-auto-repeat?

Added.

> 
> > +
> > +EXAMPLE
> > +
> > +	keypad {
> > +		compatible = "qcom,pm8921-keypad";
> > +		interrupt-parent = <&pmicintc>;
> > +		interrupts = <74 1>, <75 1>;
> > +		linux,keymap = <
> > +			MATRIX_KEY(0, 0, KEY_VOLUMEUP)
> > +			MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
> > +			MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
> > +			MATRIX_KEY(0, 3, KEY_CAMERA)
> > +			>;
> > +		keypad,num-rows = <1>;
> > +		keypad,num-columns = <5>;
> > +		debounce = <15>;
> > +		scan-delay = <32>;
> > +		row-hold = <91500>;
> > +	};
> 
> It odd to me that these newly created bindings don't have 'reg'
> properties, even though the device clearly has a register region.
> 
> I suppose it makes sense from a "port over from platform data to DT"
> perspective, as these drivers have just assumed the location of their
> registers to be fixed; however I suspect things will need to be changed
> if/when we hope to share these drivers with pm8841/pm8941 and beyond...
> 

Agreed. I would love it if the platform OF code would create
IORESOURCE_REG resources for any reg properties that aren't
translatable to CPU addresses. That way we don't have to pick out
the reg property from DT with special OF code (like you've done
in rtc-pm8xxx). I'll throw the reg property into the binding so
that in the future we can support the register moving around
(although at the moment the driver will ignore it).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
