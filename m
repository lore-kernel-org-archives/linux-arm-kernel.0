From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 23 Feb 2012 21:44:40 +0100
Subject: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of reset
In-Reply-To: <CAMQu2gzrGnWOUYacg4jvVqgjrNeHfaTJre6O5rNarQSjAuOzLg@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-6-git-send-email-t-kristo@ti.com>
 <CAMQu2gzrGnWOUYacg4jvVqgjrNeHfaTJre6O5rNarQSjAuOzLg@mail.gmail.com>
Message-ID: <4F46A538.80008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2012 2:56 PM, Shilimkar, Santosh wrote:
> $Subject
> s/dsp/DSP
> s/tesla/TESLA

Even better... remove tesla :-)

This is an internal codename that at some point should be removed from 
the clkdm name. I just did not have the time to do that for OMAP4, but 
it will not exist anymore on OMAP5.

Nit: The subject should be:
"ARM: OMAP4: hwmod data: Do not get DSP out of reset at boot time"

Regards,
Benoit

>
> On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo<t-kristo@ti.com>  wrote:
>> From: Rajendra Nayak<rnayak@ti.com>
>>
>> With no driver handling DSP/TESLA, if brought out of reset, it stays
>> active and does not assert standby.
>>
> Which lead to IVHA PD not transitiong and hence gating CHIP retention.
> You may want to add these bits as well.
>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>> ---
>
> Patch is fine though script needs to be updated I guess
>
> Regards
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
