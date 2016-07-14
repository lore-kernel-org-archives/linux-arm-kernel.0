From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 14 Jul 2016 17:22:38 +0200
Subject: [PATCH] usb: ehci-platform: use helper variables in probe function
In-Reply-To: <Pine.LNX.4.44L0.1607141008500.32397-100000@netrider.rowland.org>
References: <1468398548-5050-1-git-send-email-zajec5@gmail.com>
 <Pine.LNX.4.44L0.1607141008500.32397-100000@netrider.rowland.org>
Message-ID: <CACna6rzdhCjHvTJSC-TCag7eCMPso-tGRRu3ajhs5jc7A6r2gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2016 at 16:11, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 13 Jul 2016, Rafa? Mi?ecki wrote:
>
>> Probing function was using &dev->dev and dev->dev.of_node over 20 times
>> so I believe it made sense to use helper variables for both of them.
>> To avoid some uncommon variable name for struct device I first replaced
>> existing dev variable with pdev.
>>
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>
> Okay except for...
>
>> -             priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
>> -                             "phys", "#phy-cells");
>> +             priv->num_phys = of_count_phandle_with_args(np, "phys",
>> +                                                         "#phy-cells");
>
> Please indent continuation lines two tab stops beyond the original
> line, to match the style in the rest of the source file.

I'm afraid this file doesn't have any consistent coding style for line breaks.

1) dma_coerce_mask_and_coherent
One extra tab after line break.

2) devm_kcalloc
Two extra tabs and 4 spaces. No real alignment noticed.

3) devm_of_phy_get_by_index
Two extra tabs

4) devm_reset_control_get_shared_by_index
Three extra tabs

With these pointed, do you still think I should use two extra tabs? If
so, I'll send V2 as you suggested. Just let me know.

-- 
Rafa?
