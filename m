From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Dec 2013 22:06:30 +0100
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <1386880245-10192-3-git-send-email-dinguyen@altera.com>
 <201312142233.27143.arnd@arndb.de> <52AD1185.6090501@linaro.org>
 <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
Message-ID: <52AF6B56.1020209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/16/2013 09:55 PM, Emilio L?pez wrote:
> Hi Mike et al,
>
> El 15/12/13 01:51, Mike Turquette escribi?:
>> clk_set_phase has been proposed before and now may be the time to add
>> it. There are two things that need to be addressed:
>>
>> 1) what are the values for the phase? This needs to work for others that
>> must set clk phase, so we need to consider all those requirements before
>> making a new function declaration in clk.h
>>
>> 2) is setting a clock's phase something done dynamically? Put another
>> way, does the same clock has it's phase set multiple times while the
>> system is running? For static configuration that only happens during
>> initialization we do not need a new API. The clock driver can handle it
>> privately. For dynamic operations though we likely need a new API.
>
> We on sunxi also need this for our (not yet merged) MMC driver; we currently have it implemented as an exported
>
> void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output)
>
> that takes the MMC clock (and only the MMC clock) and does the setup (it's basically configuring two values, "sample" and "output", into the clock register). I really don't know what does this do/why is it required/when is it used; I'm cc'ing Hans and David who can hopefully explain that part.

I'm afraid I cannot explain that part, the MMC controller in the sunxi SoCs
is undocumented, so what we're doing there comes straight from the android
kernel code. I do understand most of the bits of the sunxi-mci driver, but
this bit is black magic to me.

Regards,

Hans
