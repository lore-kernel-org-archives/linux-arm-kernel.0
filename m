From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 12:08:53 +0800
Subject: [PATCH v2 08/14] clk: hs: add clock support
In-Reply-To: <201303121900.19441.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-9-git-send-email-haojian.zhuang@linaro.org>
 <201303121900.19441.arnd@arndb.de>
Message-ID: <CAD6h2NS0b+DJ6VKGiXGSbGf0tUzBoDso6L20rmCuJ8askRurjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 03:00, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Haojian Zhuang wrote:
>> +void __init hs_init_clocks(void)
>> +{
>> +       struct device_node *node;
>> +
>> +       /* map pmctrl registers */
>> +       node = of_find_compatible_node(NULL, NULL, "hisilicon,pmctrl");
>> +       hs_clk.pmctrl = of_iomap(node, 0);
>> +       WARN_ON(!hs_clk.pmctrl);
>> +
>> +       node = of_find_compatible_node(NULL, NULL, "hisilicon,sctrl");
>> +       hs_clk.sctrl = of_iomap(node, 0);
>> +
>> +       of_clk_init(hs_clk_match);
>> +}
>
> You should be able to just use CLK_OF_DECLARE() with each member of
> hs_clk_match[] now and call of_clk_init(NULL) from platform code.
>
> This requires moving the of_iomap() calls somewhere else, but it
> could be a function that gets called by whichever setup function
> gets run first.
>
>         Arnd

Yes, it's better. I'll update it.

Regards
Haojian
