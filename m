From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 14:31:36 +0200
Subject: [PATCH v4 05/14] clk: Add generic driver for Maxim PMIC clocks
In-Reply-To: <CAKew6eWt-0c4gxGX7C7KtRrxR=9h9BSUmN3a2aWQtuT40cva1w@mail.gmail.com>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>	<1403723019-6212-6-git-send-email-javier.martinez@collabora.co.uk>
 <CAKew6eWt-0c4gxGX7C7KtRrxR=9h9BSUmN3a2aWQtuT40cva1w@mail.gmail.com>
Message-ID: <53AC12A8.6040201@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yadwinder,

Thanks a lot for your feedback.

On 06/26/2014 01:51 PM, Yadwinder Singh Brar wrote:
> Hi Javier,
> 
> Sorry for jumping in late, but just one concern mentioned inline.
> 
> [ .. ]
> 
>> +
>> +static unsigned long max_gen_recalc_rate(struct clk_hw *hw,
>> +                                        unsigned long parent_rate)
>> +{
>> +       return 32768;
>> +}
> 
> Isn't more safer(correct), if it check and return 0 when clk is
> disabled(unprepared) ?
> 

Makes sense to me. I'll add a if (__clk_is_enabled(hw->clk)) check in the next
version.

> Regards,
> Yadwinder
> 

Best regards,
Javier
