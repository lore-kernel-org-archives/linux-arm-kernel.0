From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 24 Feb 2014 17:14:52 +0000
Subject: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <20140224142658.GD4436@piout.net>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de> <20140224142658.GD4436@piout.net>
Message-ID: <a79091da-a072-4f76-83ce-a956ef9c37a2@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On February 24, 2014 2:26:58 PM GMT+00:00, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>Hi Juergen,
>
>On 24/02/2014 at 14:16:24 +0100, Juergen Beisert wrote :
>> Hi Alexandre,
>> 
>> > While I don't have much experience with the TS part of the code but
>I
>> > can investigate if you don't have any idea.
>> 
>> can you please test the following patch?
>> After releasing the touchscreen the internal state machine was left
>in a
>> wrong state.
>> 
>
>This seems to solve the issue. You can send the patch with my
>Tested-by.
>
>It is probably worth trying to get it in 3.14.
Definitely. There is time.
>
>Thanks !
>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>b/drivers/staging/iio/adc/mxs-lradc.c
>> index e2dd783..558a76c 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
>mxs_lradc *lradc, bool valid)
>>         }
>> 
>>         /* if it is released, wait for the next touch via IRQ */
>> +       lradc->cur_plate = LRADC_TOUCH;
>>         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ,
>LRADC_CTRL1);
>>         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>LRADC_CTRL1);
>>  }
>> 
>> Regards,
>> Juergen
>> 
>> -- 
>> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ?
>? ? ? |
>> Linux Solutions for Science and Industry ? ? ?| Phone:
>+49-5121-206917-5128 |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany ? ?| Fax: ?
>+49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? ? ?|
>http://www.pengutronix.de/ ?|

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
