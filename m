From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 21 Mar 2013 08:01:03 +0000
Subject: [PATCH v2 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <87wqt2qlts.fsf@dell.be.48ers.dk>
References: <1363761714-15034-1-git-send-email-avinashphilip@ti.com>
 <1363761714-15034-4-git-send-email-avinashphilip@ti.com>
 <51499DB4.9080907@ti.com> <87wqt2qlts.fsf@dell.be.48ers.dk>
Message-ID: <518397C60809E147AF5323E0420B992E3EA9C651@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 18:17:59, Peter Korsgaard wrote:
> >>>>> "Sekhar" == Sekhar Nori <nsekhar@ti.com> writes:
> 
>  Sekhar> On 3/20/2013 12:11 PM, Philip Avinash wrote:
>  >> Add da850 EHRPWM & ECAP DT node.
>  >> Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
>  >> clock.
>  >> 
>  >> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
>  >> ---
>  >> Changes since v1:
>  >> - Reusing ti,am33xx<ecap/ehrpwm> as compatible field as both IP's are
>  >> same with am33xx platform and da850 has no platform specific
>  >> dependency.
> 
>  Sekhar> Which is fine, but I think the binding documentation still needs to be
>  Sekhar> updated to document the ti,da850-ehrpwm binding. Looping Peter (it is
>  Sekhar> always a good idea to CC folks who reviewed your patch last time
>  Sekhar> around). Also, please Cc the DT folks and devicetree-discuss list too
>  Sekhar> for their opinion.
> 
> Yes, thanks for CC'ing me. I also think da850-* should be
> documented. See Documentation/devicetree/bindings/gpio/8xxx_gpio.txt for
> an similar (old) example.

Peter,

In this binding file also, only initial compatible field is updated. Later on many
compatible were added in driver. But not update back to binding doc.

<Documentation/devicetree/bindings/gpio/8xxx_gpio.txt>
---
	followed by "fsl,mpc8349-gpio" for 83xx, "fsl,mpc8572-gpio" for 85xx and
	"fsl,mpc8610-gpio" for 86xx.
---
<drivers/gpio/gpio-mpc8xxx.c>
---
static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
        { .compatible = "fsl,mpc8349-gpio", },
        { .compatible = "fsl,mpc8572-gpio", },
        { .compatible = "fsl,mpc8610-gpio", },
        { .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
        { .compatible = "fsl,pq3-gpio",     },
        { .compatible = "fsl,qoriq-gpio",   },
        {}
};
---

Grant/Rob,
With respect peters explanation (below), what is your opinion on adding information to 
binding doc for da850 support?

Peter --> if the hardware block is identical the dts should simply list:
Peter --> compatible = "ti,da850-ecap", "ti,am33xx-ecap"
Peter --> And the driver only bind to ti,am33xx-ecap (unless there ever needs to
Peter --> be a da850 specific workaround.

Or
Should I update both binding doc & the driver to use new compatible option "ti,da830-ecap"
(as da830 platform has initial IP support)?
Even with this, platforms da830, da850 and am33xx can reuse "ti,da830-ecap" compatible field.

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
