From: k@japko.eu (Krzysztof Adamski)
Date: Thu, 11 Feb 2016 14:20:54 +0100
Subject: [linux-sunxi] Re: [PATCH v2 5/5] pinctrl: sunxi: Use pin number
 when calling sunxi_pmx_set
In-Reply-To: <CACRpkdbc0SfKiCGwUGA2fAPPsUhGv=qGV607Lht6ByYKKgTHjA@mail.gmail.com>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-6-git-send-email-k@japko.eu>
 <CACRpkdbc0SfKiCGwUGA2fAPPsUhGv=qGV607Lht6ByYKKgTHjA@mail.gmail.com>
Message-ID: <20160211132054.GC19622@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 02:17:41PM +0100, Linus Walleij wrote:
>On Tue, Feb 2, 2016 at 10:21 PM, Krzysztof Adamski <k@japko.eu> wrote:
>
>> sunxi_pmx_set accepts pin number and then calculates offset by
>> subtracting pin_base from it. sunxi_pinctrl_gpio_get, on the other hand,
>> gets offset so we have to convert it to pin number so we won't get
>> negative value in sunxi_pmx_set.
>>
>> This was only used on A10 so far, where there is only one GPIO chip with
>> pin_base set to 0 so it didn't matter. However H3 also requires this
>> workaround but have two pinmux sections, triggering problem for PL port.
>>
>> Signed-off-by: Krzysztof Adamski <k@japko.eu>
>
>Waiting for Maxime to review this. I guess this patch can be merged
>independently of the other patches?

Yes it can but it won't have any effect, as stated in the commit 
message, since other SoCs either don't use this flag or have only one 
port so theri pin_base=0.

Best regards,
Krzysztof Adamski
