From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 23 Sep 2012 19:13:37 +0100
Subject: PXA PWM possible regression after 3.5: backlight remains off
 after resume
In-Reply-To: <20120923172232.GA1293@avionic-0098.mockup.avionic-design.de>
References: <505F28B8.1030701@yahoo.com>
 <20120923172232.GA1293@avionic-0098.mockup.avionic-design.de>
Message-ID: <505F5151.5070506@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On 23/09/12 18:22, Thierry Reding wrote:
> On Sun, Sep 23, 2012 at 04:20:24PM +0100, Paul Parsons wrote:
>> There is a possible PXA PWM regression between 3.5 and 3.6-rc6: if I
>> suspend and then resume an iPAQ hx4700, the backlight remains off.
>>
>> In 3.5 the backlight would turn on after the resume.
>>
>> I presumed this is a PWM issue because the PXA PWM driver was reworked
>> and moved trees between 3.5 and 3.6-rc6. And there was mention of
>> broken PWM drivers about a month ago, for example:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115717.html
>>
>> Does my backlight breakage sound familiar to anybody? Is there
>> anything obvious I can try before debugging it further?
>
> Looking at the code from before the move to the PWM subsystem I have a
> hard time understanding how this could have worked for supend/resume in
> the first place. The driver has never supported the supend and resume
> callbacks. Maybe it is also a problem related to some other change.
> Clocking would be a likely candidate. But again I wonder how this ever
> worked properly without the suspend and resume callbacks.
>
> Can you pinpoint more exactly when this failed to break. PXA PWM was
> already included in 3.6-rc1 so if it is related then it should have
> happened at that time already.

The same failure is also present in 3.6-rc1.

Just to be clear, are you saying that drivers/pwm/pwm-pxa.c should
include suspend/resume handlers like in drivers/pwm/pwm-samsung.c ?

Agreed that it is possible that recent changes exposed a latent bug
somewhere, and that turning the backlight on after resume should never
have worked.
