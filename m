From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Feb 2014 15:59:27 -0300
Subject: PMIC driver prevents gpio-leds to work
In-Reply-To: <1392749026.163265479@f312.i.mail.ru>
References: <CAOMZO5D0fa0yzwQbNLG_=oJ_8_WBBqWBF=D9QzSwLwC0jh+deQ@mail.gmail.com>
 <1392749026.163265479@f312.i.mail.ru>
Message-ID: <CAOMZO5DWkxv8q+1+LsOYPPLqxXCAW2q9LRXyn-zV-SSSW10AwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 3:43 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> ???????, 18 ??????? 2014, 15:20 -03:00 ?? Fabio Estevam <festevam@gmail.com>:
>> Hi,
>>
>> I am running into the following issue on imx6sl-evk.dts:
>>
>> - I can only get the user GPIO LED to work if I unselect the PFUZE100
>> PMIC driver
>>
>> - This happens on linux-next as well as in the internal FSL kernel based on 3.10
>>
>> With CONFIG_REGULATOR_PFUZE100=y then the LED blinks only once and
>> stops instead of blinking at the heartbeat rate.
>>
>> Changing to CONFIG_REGULATOR_PFUZE100=n then the LED blinks normally.
>>
>> I am not sure how the PMIC driver could interact and make the
>> gpio-leds driver to fail.
>>
>> Any suggestions?
>
> Perhaps, one of regulators turn off the power for a pin-group where LED is connected.

That did the trick, thanks.

I thought that 'regulator-always-on' was enough, but I also need
'regulator-boot-on' as well.

Will submit the patch later today.

Thanks,

Fabio Estevam
