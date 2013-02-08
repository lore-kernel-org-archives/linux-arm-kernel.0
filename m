From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 21:04:09 +0530
Subject: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
In-Reply-To: <20130208152607.GJ23979@arwen.pp.htv.fi>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
 <20130208152607.GJ23979@arwen.pp.htv.fi>
Message-ID: <51151AF1.20202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 08:56 PM, Felipe Balbi wrote:
> On Fri, Feb 08, 2013 at 08:41:46PM +0530, Santosh Shilimkar wrote:
>> Current CPU PM code code make use of common cpu_suspend() path for all the
>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>> only when we put CPU power domain to off state where the CPU context is lost.
>>
>> Update the code accordingly so that the expensive cpu_suspend() path
>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> some numbers showing the benefit would be cool...
>
The numbers depends on CPU clock you are running generally. The main
issue is, for the shallow power states where we were not loosing
CPU context or Caches, we were doing all the book keeping. States
like INA are of 6-8 uS and above overhead is quite significant
their.

Regards
Santosh
