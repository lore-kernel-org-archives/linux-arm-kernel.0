From: marek.belisko@streamunlimited.com (Marek Belisko)
Date: Thu, 16 May 2013 09:53:26 +0200
Subject: [PATCH v2 1/2] clk: si5351: Fix clkout rate computation.
In-Reply-To: <20130514191650.10068.92925@quantum>
References: <1367560403-21685-1-git-send-email-marek.belisko@streamunlimited.com>
 <20130514191650.10068.92925@quantum>
Message-ID: <51949076.9040008@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 09:16 PM, Mike Turquette wrote:
> Quoting Marek Belisko (2013-05-02 22:53:22)
>> Rate was incorrectly computed because we read from wrong divider register.
>>
>> Signed-off-by: Marek Belisko <marek.belisko@streamunlimited.com>
>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> Do either of these patches need to go into clk-fixes?  If so please be
> explicit about it in the changelog, the section under the three dashes.
Yes I believe they should go to clk-fixes (probably also to linux-stable).
>
> Regards,
> Mike
>
>> ---
>>   drivers/clk/clk-si5351.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
>> index 8927284..cf39e53 100644
>> --- a/drivers/clk/clk-si5351.c
>> +++ b/drivers/clk/clk-si5351.c
>> @@ -932,7 +932,7 @@ static unsigned long si5351_clkout_recalc_rate(struct clk_hw *hw,
>>          unsigned char reg;
>>          unsigned char rdiv;
>>
>> -       if (hwdata->num > 5)
>> +       if (hwdata->num <= 5)
>>                  reg = si5351_msynth_params_address(hwdata->num) + 2;
>>          else
>>                  reg = SI5351_CLK6_7_OUTPUT_DIVIDER;
>> --
>> 1.7.9.5
>

Regards,

Marek
-- 
Marek Belisko

Software Developer
StreamUnlimited Engineering GmbH
Gutheil Schodergasse 8-12
A-1100 Vienna, Austria

Office: +421 267200087

e-mail: marek.belisko at streamunlimited.com
http://www.streamunlimited.com

Meet us at:

IFA - Berlin, 6-11 September
CEDIA - Denver, 25-28 September
