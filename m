From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 May 2013 16:07:46 +0800
Subject: [PATCH v2] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
In-Reply-To: <20130528075808.GA19496@core.coreip.homeip.net>
References: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
 <20130528075808.GA19496@core.coreip.homeip.net>
Message-ID: <CAGsJ_4zY0+O6fP2bKLy__U_+-ZsWQXwZ8JXYMpRmtVe6zihfDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Barry,
>
> On Tue, May 28, 2013 at 10:47:38AM +0800, Barry Song wrote:
>> +     /*
>> +      * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
>> +      * to queue a SUSPEND APM event
>> +      */
>> +     input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
>> +     input_sync(pwrcdrv->input);
>> +
>> +     /*
>> +      * Todo: report KEY_POWER event for Android platforms, Android PowerManager
>> +      * will handle the suspend and powerdown/hibernation
>> +      */
>> +
> ...
>
>> +
>> +     pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
>> +     set_bit(KEY_POWER, pwrcdrv->input->keybit);
>
> Why are we setting up KEY_POWER if we do not send this event?

For Android products, we send KEY_POWER to let Android PM trigger
SUSPEND. that is left to be done.

>
> Thanks.
>
> --
> Dmitry

-barry
