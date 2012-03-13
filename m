From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 13 Mar 2012 19:37:16 +0800
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <87mx9ej8fp.fsf@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
 <87mx9ej8fp.fsf@ti.com>
Message-ID: <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 24, 2012 at 7:38 AM, Kevin Hilman <khilman@ti.com> wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>
>> OMAP device has 32k-sync timer which is currently used as a
>> clocksource in the kernel (omap2plus_defconfig).
>> The current implementation uses compile time selection between
>> gp-timer and 32k-sync timer, which breaks multi-omap build for
>> the devices like AM33xx, where 32k-sync timer is not available.
>>
>> So use hwmod database lookup mechanism, through which at run-time
>> we can identify availability of 32k-sync timer on the device,
>> else fall back to gp-timer.
>
> With the runtime detection & fallback, I suggest also removing the
> Kconfig choice between the two as well.

IMO, under some situations, gp timer clocksource has high precision
and is very useful, so hope the Kconfig choice can be kept, or using
kernel parameter way,  and the patch need to be changed to support the
selection.


thanks,
-- 
Ming Lei
