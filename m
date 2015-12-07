From: imr@rtschenk.de (Rojhalat Ibrahim)
Date: Mon, 07 Dec 2015 10:01:39 +0100
Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as
 input
In-Reply-To: <56633FFA.5080708@zonque.org>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <21976926.6E4NCDDElu@pcimr> <56633FFA.5080708@zonque.org>
Message-ID: <1470515.ydY47qFlGL@pcimr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 December 2015 20:50:18 Daniel Mack wrote:
> On 12/03/2015 02:01 PM, Rojhalat Ibrahim wrote:
> > On Wednesday 02 December 2015 19:59:20 Uwe Kleine-K?nig wrote:
> 
> >> I have a real rotary encoder with 4 input lines and so 16
> >> distinguishable positions. It would be described as:
> >>
> >> 	compatible = "rotary-encoder";
> >> 	gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
> >> 	rotary-encoder,steps = <16>;
> >> 	rotary-encoder,steps-per-period = <16>;
> >>
> >> with the binding implemented in my patches.
> >>
> >> The wikipedia article about rotary encoders[1] uses a device with 3
> >> input lines to explain gray encoding. So I didn't consider "my" device
> >> as exotic up to now.
> >>
> > 
> > So you have an absolute encoder. From the state of the four input lines you
> > can determine the absolute position value. There is no need to count steps.
> > At least that's the original purpose of your device.
> > 
> > Of course it might be conceivable to use that kind of absolute encoder in an
> > incremental way and count the steps throughout multiple revolutions.
> > But why would you do that? The resolution of 16 steps per revolution is not
> > very good (incremental encoders often have hundreds or thousands of steps per
> > revolution). And the whole point of an absolute encoder is that you are able
> > to determine the current position at any time just by looking at the inputs
> > without having to count steps.
> 
> Yes, you're right, that's actually a very different kind of device which
> should be supported with a different mode or something, so that the
> output of the driver reflects the absolute state of the encoder. This
> even simplifies things in the driver: The entire state logic would be
> bypassed in this mode, and the current state of the GPIO lines would be
> used directly to get the absolute value. Makes sense?
> 

Definitely makes sense to me.

Thanks.
   Rojhalat


> 
> Thanks,
> Daniel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
