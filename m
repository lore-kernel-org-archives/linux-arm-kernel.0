From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 26 Sep 2012 03:02:58 +0100
Subject: PXA PWM possible regression after 3.5: backlight remains off
 after resume
In-Reply-To: <87ehlpzy50.fsf@free.fr>
References: <505F28B8.1030701@yahoo.com>
 <20120923172232.GA1293@avionic-0098.mockup.avionic-design.de>
 <505F5151.5070506@yahoo.com> <87ehlpzy50.fsf@free.fr>
Message-ID: <50626252.3050405@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/12 20:43, Robert Jarzmik wrote:
> Paul Parsons <lost.distance@yahoo.com> writes:
>
>> The same failure is also present in 3.6-rc1.
>>
>> Just to be clear, are you saying that drivers/pwm/pwm-pxa.c should
>> include suspend/resume handlers like in drivers/pwm/pwm-samsung.c ?
>>
>> Agreed that it is possible that recent changes exposed a latent bug
>> somewhere, and that turning the backlight on after resume should never
>> have worked.
>
> Hi Paul,
>
> I checked on the mioa701 board (see [1]).
> On my board, the backlight if fully driven by PXA PWM0, and the suspend/resume
> is working perfectly.
>
> So I don't thing anything is needed for suspend/resume wrt PWM (empirically).

You're right. I belatedly reached the same conclusion after I noticed
that only the pwm-samsung driver included any suspend/resume handlers:
the other drivers can't all be broken!

Fortunately I have just identified the problem: the PXA27X PWM device
numbering scheme has changed, breaking the hx4700 platform and probably
other PXA27X platforms which use PWM1 or PWM2.

Regards,
Paul
