From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 22 Apr 2013 23:33:44 +0800
Subject: Pinmuxing with devicetree (beaglebone)
In-Reply-To: <201304211143.50961.tim@krieglstein.org>
References: <201304211143.50961.tim@krieglstein.org>
Message-ID: <CAN1soZzz=GRMrmj3rtBkxE74e0JZ4xewR=yVMUeMvp=6Yp34nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 5:43 PM, Tim Sander <tim@krieglstein.org> wrote:
> Hi
>
> I am currently trying to get pinmuxing working on a beaglebone board with an
> offtree driver. This is for a custom handbuild hardware so i guess there is no
> point in bringing this mainline.
>
> While this is havyly patched 3.8.4 version running over here i think the
> pinmux infrastructure is the new standard way. At least there is a
> pinctrl/44e10800.pinmux directory in debugfs?
>
> My last aproach was using the devicetree but beeing new to this devicetree
> stuff i just got stuck:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/231204
>
> Now i tried use the way it is described in Documentation/pinctrl.txt but still
> there are the includes missing: #include <linux/pinctrl/consumer.h>.
>
> Also while there is a /sys/kernel/debug/pinctrl/44e10800.pinmux in debugfs i
> found that not so intuitive as the omap_mux which disappeared. Also i didn't
> find any documentation for this debugfs stuff.
>
> So what is the recommended way to get this stupid pinmuxing going. In pre
> devicetree days one would just pick the mux.h include of the platform and
> initialized the muxers which was pretty straight forward. Now with device tree
> its much more complicated. No proper syntax checking as with the c definitions
> and no documentation how to get this magic stuff working :-(.
>
> The whole stuff is build by a ptxdist (a embedded buildsystem) and can be
> found over here:
> https://gitorious.org/ptxdist-beaglebone/ptxdist-beaglebone
>
"pins" node could dump the register configuration if it's pinctrl-single driver.

You can dump this to check whether the right pinmux is set.

I checked your patch in the link.  It seems that you only write the pinmux
configuration without using them.

Don't forget to append this in your DTS file.
     pinctrl-names = "default";
       pinctrl-0 = <&wind_pins>;

There're two documents worth to read for enabling pins for
pinctrl-single driver.
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

Regards
Haojian

> Best regards
> Tim
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
