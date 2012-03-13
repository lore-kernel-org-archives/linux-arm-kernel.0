From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Mar 2012 12:16:17 +0530
Subject: [PATCH v4 2/2] ARM: Exynos: Add device tree support for interrupt
 combiner
In-Reply-To: <20120313035246.6BC8A3E07E4@localhost>
References: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
 <1329798806-32482-3-git-send-email-thomas.abraham@linaro.org>
 <20120313035246.6BC8A3E07E4@localhost>
Message-ID: <CAJuYYwQGbhtxNg0G=QMooMfH8Mkf8KwSzLk61OkpwL4ZuR1fDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2012 09:22, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, 21 Feb 2012 10:03:26 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Add device tree based instantiation of the interrupt combiner controller.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> @@ -406,13 +432,33 @@ void __init combiner_init(void __iomem *combiner_base, struct device_node *np)
>>
>> ? ? ? for (i = 0; i < MAX_COMBINER_NR; i++) {
>> ? ? ? ? ? ? ? combiner_init_one(i, combiner_base + (i >> 2) * 0x10);
>> - ? ? ? ? ? ? combiner_cascade_irq(i, IRQ_SPI(i));
>> +#ifdef CONFIG_OF
>> + ? ? ? ? ? ? irq = np ? irq_of_parse_and_map(np, i) : IRQ_SPI(i);
>> +#else
>> + ? ? ? ? ? ? irq = IRQ_SPI(i);
>> +#endif
>
> Hmmm, the #ifdef is rather ugly. ?I'd rather have an empty
> irq_of_parse_and_map() that always returns 0.
>
> The patch series is fine, and you can add my acked-by, but please send
> a follow-up patch to clean it up.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>

Thanks. I will send a follow-up to clean it.

Regards,
Thomas.
