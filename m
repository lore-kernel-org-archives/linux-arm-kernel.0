From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 13 Mar 2013 10:42:08 -0700
Subject: [PATCH v2] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
In-Reply-To: <513DBB60.3010406@ti.com> (Santosh Shilimkar's message of "Mon,
 11 Mar 2013 16:39:20 +0530")
References: <1360745724-30058-1-git-send-email-santosh.shilimkar@ti.com>
 <513DBB60.3010406@ti.com>
Message-ID: <874ngfrybz.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
> On Wednesday 13 February 2013 02:25 PM, Santosh Shilimkar wrote:
>> Current CPU PM code code make use of common cpu_suspend() path for all the
>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>> only when we put CPU power domain to off state where the CPU context is lost.
>> 
>> Update the code accordingly so that the expensive cpu_suspend() path
>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>> 
>> The patch has been tested on OMAP4430 and OMAP5430(with few out of tree patches)
>> devices for suspend and CPUidle.
>> 
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> Update changelog to include testing details as suggested
>> by Kevin Hilman.
>> 
> Ping.
> It can get into rc's but since it is not strict regression,
> and if it has to wait for 3.10 then I can add this one
> along with rest of the PM patches posted towards 3.10
>
> Either way, let me know.

I have this updated one queued for v3.10 in my PM cleanup branch
(for_3.10/cleanup/pm)

Kevin
