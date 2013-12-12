From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Dec 2013 11:06:18 -0800
Subject: [PATCH 5/8] mfd: Move pm8xxx-irq.c contents into only driver
 that uses it
In-Reply-To: <20131211093552.GG16780@lee--X1>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-6-git-send-email-sboyd@codeaurora.org>
 <20131211093552.GG16780@lee--X1>
Message-ID: <52AA092A.3040605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/13 01:35, Lee Jones wrote:
> On Tue, 10 Dec 2013, Stephen Boyd wrote:
>
>> The pm8xxx-irq.c code is practically mandatory given that the
>> pm8921-core driver will WARN about it missing and the Kconfig
>> marks it as default y when a PM8xxx chips is enabled. The only
>> reason the file was split out was because we planned to support
>> other pm8xxx chips with different pm8xxx-core.c files. Now that
>> we have DT on ARM this isn't necessary because we should be able
>> to support all the ssbi based PM8xxx chips in one driver and one
>> file with no data bloat. Let's move this code into the only
>> driver that uses it right now (pm8921) so that it's always compiled when
>> needed. In the future we can rename pm8921-core.c to something
>> more generic.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/mfd/Kconfig       |  10 --
>>  drivers/mfd/pm8921-core.c | 349 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mfd/pm8xxx-irq.c  | 371 ----------------------------------------------
> If you're going to take this approach (which I'm fine with unless
> there are likely to be anymore incarnations of pm8xxx chips?), I think
> you should also clean-up the header in this patch.
>
>   include/linux/mfd/pm8xxx/irq.h
>

Thanks. I'll remove the header and resend.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
