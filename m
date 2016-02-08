From: carlo@caione.org (Carlo Caione)
Date: Mon, 8 Feb 2016 09:54:46 +0100
Subject: [PATCH] clk: meson: Fix meson_clk_register_clks() signature type
 mismatch
In-Reply-To: <CAOQ7t2YwHa7cJdqv4m8rPx50ZnFZJJzcU2AjtE=Q2AYEAf84hg@mail.gmail.com>
References: <1454879583-27036-1-git-send-email-afaerber@suse.de>
 <CAOQ7t2YwHa7cJdqv4m8rPx50ZnFZJJzcU2AjtE=Q2AYEAf84hg@mail.gmail.com>
Message-ID: <CAOQ7t2brTxmE-snjXxZG1ZrHNYCEugj6EwORBpVtaMHME_pewQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 9:34 AM, Carlo Caione <carlo@caione.org> wrote:
> On Sun, Feb 7, 2016 at 10:13 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> As preparation for arm64 based mesongxbb, which pulls in this code once
>> enabling ARCH_MESON, fix a size_t vs. unsigned int type mismatch.
>> The loop uses a local unsigned int variable, so adopt that type,
>> matching the header.
>>
>> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  drivers/clk/meson/clkc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/clkc.c b/drivers/clk/meson/clkc.c
>> index c83ae1367abc..d920d410b51d 100644
>> --- a/drivers/clk/meson/clkc.c
>> +++ b/drivers/clk/meson/clkc.c
>> @@ -198,7 +198,7 @@ meson_clk_register_fixed_rate(const struct clk_conf *clk_conf,
>>  }
>>
>>  void __init meson_clk_register_clks(const struct clk_conf *clk_confs,
>> -                                   size_t nr_confs,
>> +                                   unsigned int nr_confs,
>>                                     void __iomem *clk_base)
>>  {
>>         unsigned int i;
>
> Nit: I'd prefer to fix declaration in drivers/clk/meson/clkc.h with
> size_t since we are going to use it for array indexing.

On a second thought it's ok since we use i to cycle through clocks.

Acked-by: Carlo Caione <carlo@endlessm.com>

Cheers,

-- 
Carlo Caione
