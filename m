From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 10 May 2016 04:18:27 +0200
Subject: [PATCH 4/7] [media] ir-rx51: add DT support to driver
In-Reply-To: <CAL_JsqJPZS1ne_xAuBFtCc5L1HKFJf0LDUJ7CRSFXhc3adkTfA@mail.gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509200657.GA3379@rob-hp-laptop> <5730F8BA.5000402@gmail.com>
 <CAL_JsqJPZS1ne_xAuBFtCc5L1HKFJf0LDUJ7CRSFXhc3adkTfA@mail.gmail.com>
Message-ID: <20160510021826.GE1129@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 09, 2016 at 04:07:35PM -0500, Rob Herring wrote:
> There's already a pwm-led binding that can be used. Though there
> may be missing consumer IR to LED subsystem support in the kernel.
> You could list both compatibles, use the rx51 IR driver now, and
> then move to pwm-led driver in the future.

Well from a purely HW point of view it's a PWM connected led. The
usage is completely different though. Usually PWM is used to control
the LED's brightness via the duty cycle (basic concept: enabling led
only 50% of time reduces brightness to 50%).

In the IR led's case the aim is generating a specific serial pattern
instead. For this task it uses a dmtimer in PWM mode and a second
one to reconfigure the pwm timer.

I don't know about a good name, but rx51 should be replaced with
n900 in the compatible string. So maybe "nokia,n900-infrared-diode".

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/b754425b/attachment.sig>
