From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 21 Apr 2012 02:42:26 +0300
Subject: [PATCH] arm: omap: fix trivial warnings for dspbridge
In-Reply-To: <20120420233412.GD24205@n2100.arm.linux.org.uk>
References: <1334959458-2873-1-git-send-email-felipe.contreras@gmail.com>
 <20120420233412.GD24205@n2100.arm.linux.org.uk>
Message-ID: <CAMP44s25TuTrZ3C9SKjO73EtU9MT9EexKFA3p-=M_m2LGvxKbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 2:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> --- a/arch/arm/mach-omap2/dsp.c
>> +++ b/arch/arm/mach-omap2/dsp.c
>> @@ -57,8 +57,9 @@ static int __init omap_dsp_init(void)
>>
>> ? ? ? if (pdata->phys_mempool_base) {
>> ? ? ? ? ? ? ? pdata->phys_mempool_size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
>> - ? ? ? ? ? ? pr_info("%s: %x bytes @ %x\n", __func__,
>> - ? ? ? ? ? ? ? ? ? ? pdata->phys_mempool_size, pdata->phys_mempool_base);
>> + ? ? ? ? ? ? pr_info("%s: %llu bytes @ %llu\n", __func__,
>
> No, don't change a unprefixed hex number to a decimal number. ?Keep
> the same formatting, just fix the warning. ?Changing the base of the
> displayed number when there's no hex prefix to it is just plain idiotic
> and creates confusion. ?Think: is the number 12345678 output by one of
> these a hex number or a decimal number?
>
> Besides, base addresses _should_ be hex numbers. ?I'd agree that sizes
> should probably be decimal, but as none of these locations you're fixing
> had 0x prefixes, I'd strongly advise to leave them as-is - esp. for a
> patch allegedly just fixing warnings.

Right, I was too fast copying what Documentation/printk-formats.txt
suggested (%llu). So s/%llu/%llx/? I prefer to keep the size also as
hex, as it's usually how it's configured.

Cheers.

-- 
Felipe Contreras
