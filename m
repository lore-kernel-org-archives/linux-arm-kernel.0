From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 21 Nov 2014 21:29:58 +0900
Subject: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for
 vqmmc
In-Reply-To: <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
 <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
 <5464152E.7040209@rock-chips.com>
 <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
Message-ID: <546F3046.30209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 09:06 PM, Ulf Hansson wrote:
> [...]
> 
>> Sure
>> If the first card is sd2.0 since startup, dw_mci_switch_voltage will not be called,
> 
> That can't be right. mmc_power_up() should trigger
> dw_mci_switch_voltage() to be invoked.

Since dw_mci_switch_voltage() is invoked, voltage is changed from 1.8v to 2.7v (minimum value 2.7-3.6v), isn't?

> 
>> and card can be identified. But if UHS card is pulgged in first, the vqmmc will be down to 1.8v.
>>
>> when sd2.0 card is pulgged in, mmc core will call dw_mci_switch_voltage to change vqmmc to 3.3v
>> (MMC_SINGLE_VOTAGE_330). So vqmmc will be set 2.7v, if we request 2.7-3.6v.
>>
>> But vmmc is always 3.3v,becuase it be set min_volt = max_volt = 3.3v in dt tables.

vmmc is fixed voltage?

>>
>> So the result:
>> vmmc = 3.3v and vqmmc = 2.7v, and sd2.0 card is failed to identify in my test.
> 
> Hmm. I wonder why it works the first time? Could it be that your
> regulator have voltage ramp up time that isn't properly considered?

if oscilloscope can use, can we know more exactly?

Best Regards,
Jaehoon Chung
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
