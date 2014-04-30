From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 30 Apr 2014 14:24:12 -0500
Subject: [PATCH] clk: socfpga: fix clock driver for 3.15
In-Reply-To: <20140430191902.5718.91761@quantum>
References: <1397481336-5592-1-git-send-email-dinguyen@altera.com>
 <20140424152133.GA23032@amd.pavel.ucw.cz>
 <1398379669.14881.2.camel@linux-builds1> <20140430191902.5718.91761@quantum>
Message-ID: <53614DDC.30901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 4/30/14 2:19 PM, Mike Turquette wrote:
> Quoting Dinh Nguyen (2014-04-24 15:47:49)
>> Hi Mike,
>>
>> On Thu, 2014-04-24 at 17:21 +0200, ZY - pavel wrote:
>>> Hi!
>>>
>>>> commit [1771b10d6 clk: respect the clock dependencies in of_clk_init]
>>>> exposed a flaw in the socfpga clock driver and prevents the platform
>>>> from booting on 3.15-rc1.
>>>>
>>>> Because the "altr,clk-mgr" is not really a clock, it should not be using
>>>> CLK_OF_DECLARE, instead we should be mapping the clk-mgr's base address
>>>> one of the functional clock init function. Use the socfpga_pll_init function
>>>> to map the clk_mgr_base_addr as this clock should always be initialized first.
>>>>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>> Works for me, thanks!
>>>                                                                       Pavel
>>>
>>> Tested-by: Pavel Machek <pavel@denx.de>
>>>
>> I'm hoping you can queued this up for one of the 3.15-rc.
> I took this in a few days ago but forgot to reply. It's in clk-fixes for
> the next batch.

Thanks!

Dinh
>
> Regards,
> Mike
>
>> Thanks,
>> Dinh
>>
>>
