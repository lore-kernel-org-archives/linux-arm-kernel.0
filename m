From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Nov 2012 16:31:32 +0530
Subject: [PATCH v3 01/11] clk: davinci - add main PLL clock driver
In-Reply-To: <50912BCE.5000401@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-2-git-send-email-m-karicheri2@ti.com>
 <509119AE.6050505@ti.com> <50912BCE.5000401@ti.com>
Message-ID: <5092568C.5000805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 7:16 PM, Murali Karicheri wrote:
> On 10/31/2012 08:29 AM, Sekhar Nori wrote:

>>> +    /*
>>> +     * if fixed_multiplier is non zero, multiply pllm value by this
>>> +     * value.
>>> +     */
>>> +    if (pll_data->fixed_multiplier)
>>> +        mult =  pll_data->fixed_multiplier *
>>> +                (mult & pll_data->pllm_mask);
>>> +    else
>>> +        mult = (mult & pll_data->pllm_mask) + 1;
>> Hmm, this is interpreting the 'mult' register field differently in both
>> cases. In one case it is 'actual multiplier - 1' and in other case it is
>> the 'actual multiplier' itself. Can we be sure that the mult register
>> definition will change whenever there is a fixed multiplier in the PLL
>> block? I don't think any of the existing DaVinci devices have a fixed
>> multiplier. Is this on keystone?
> Read section 6.4.3 (PLL Mode) in DM365 documentation (SPRUFG5a.pdf) that
> states PLL multiplies the clock by 2x the value in the PLLM. In the old
> code this is handled by a if cpu_is_* macro that we can't use in the
> driver. So this is represented by a fixed_multiplier that can be set to
> 2 for DM365 and zero on other SoCs.

Thanks for the clarification.

Regards,
Sekhar
