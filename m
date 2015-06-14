From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 14 Jun 2015 19:17:00 +0300
Subject: [PATCH v5 06/17] video: backlight: add new locomo backlight driver
In-Reply-To: <20150614151331.GE7557@n2100.arm.linux.org.uk>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-7-git-send-email-dbaryshkov@gmail.com>
 <20150614151331.GE7557@n2100.arm.linux.org.uk>
Message-ID: <CALT56yOC7ec_QCk7kQHwJN=7Z1fF3XAP=RR4ZahO6Qg3L8PjJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-06-14 18:13 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jun 08, 2015 at 11:56:37PM +0300, Dmitry Eremin-Solenikov wrote:
>> Add new simple backlight driver - it cares only about PWM/frontlight
>> part of LoCoMo, it does not touch TFT settings and does not export TFT
>> power control.
>
> Is there a reason not to model the PWM as a PWM device, and use pwm_bl.c ?
> pwm_bl.c can be used in non-DT setups too.

I thought about it too. The problem is the FLVR pin, which adds another
(extra) brighness level after the PWM is configured to 100% duty cycle.

Whether to use PWM subsystem or not for handling this PWM is an open question.
I decided not to use it (at least for now), because that would bring complexity
with no directly added value.

-- 
With best wishes
Dmitry
