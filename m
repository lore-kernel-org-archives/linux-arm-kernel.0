From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Nov 2013 19:47:59 +0100
Subject: [GIT PULL] clockevents/clocksource: 3.12 fixes
In-Reply-To: <20131112183553.GQ14892@pengutronix.de>
References: <528234B9.7080402@linaro.org>
 <20131112183553.GQ14892@pengutronix.de>
Message-ID: <528277DF.4020403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 07:35 PM, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Tue, Nov 12, 2013 at 03:01:29PM +0100, Daniel Lezcano wrote:
>>
>> Hi Ingo and Thomas,
>>
>> this pull request has the following contain:
>>
>>   * Laurent Pinchard fixed a missing a clk_put in case the
>> registering of the sh_mtu[2] drivers fails.
>>
>>   * Uwe Kleine-K?nig reuse clockevents_config_and_register for the
>> at91rm9200_time timer as it was depending on the patch (commit
>> a4578ea (clockevents: Sanitize ticks to nsec conversion).
>>
>> I don't know why Thomas's patch "clockevents: Sanitize ticks to nsec
>> conversion" appears in the request log because it is not part of the
>> patches interval I specified for git request pull. The diffstat does
>> not show the files which should have been changed by the patch. In
>> any case I kept the changelog untouched since it is what gives me
>> git and maybe someone can tell me why it appears.
> Look at:
>
> 	git log --oneline --graph --boundary 97b9410..42ab380
>
> Then you see that there is Thomas' patch twice. Once the version he
> committed and sent to Linus (97b9410) and once the version that you get
> as part of my pull request (a4578ea). To fix this (assuming you don't
> care much about a stable tree), simply do:
>
> 	git rebase 97b9410 42ab380
>
> and let the result pull.

Ah, yeah, I was suspecting something like that. Thanks a lot for the 
clarification.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
