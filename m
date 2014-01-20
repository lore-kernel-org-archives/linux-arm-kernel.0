From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 22:16:53 +0100
Subject: [PATCH 5/5] clk: versatile: respect parent rate in ICST clock
In-Reply-To: <20140120211207.GI15937@n2100.arm.linux.org.uk>
References: <1390251332-6411-1-git-send-email-linus.walleij@linaro.org>
 <20140120211207.GI15937@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ1F_SvGcerMDfmhSgnLVzLXBJnQ9iftSG6yW2mMhOOKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:12 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> -static const struct icst_params impd1_vco2_params = {
>> +static struct icst_params impd1_vco2_params = {
>>       .ref            = 24000000,     /* 24 MHz */
>>       .vco_max        = ICST525_VCO_MAX_3V,
>>       .vco_min        = ICST525_VCO_MIN,
>
> Right, so we end up writing directly into these _shared_ _statically_
> _allocated_ structures.

Argh yeah that's right.

I'll think of something better, like allocating the params on-the-fly
for DT instead.

Yours,
Linus Walleij
