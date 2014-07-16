From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 16 Jul 2014 12:42:46 -0700
Subject: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <CAKohpokLzMbzr4kdL6wCL7MZgnVe0CQhbJHKL5wWeETH1YwEOg@mail.gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <53C68C54.3010900@gmail.com>
 <CAKohpokLzMbzr4kdL6wCL7MZgnVe0CQhbJHKL5wWeETH1YwEOg@mail.gmail.com>
Message-ID: <53C6D5B6.808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 08:28 AM, Viresh Kumar wrote:
> On 16 July 2014 19:59, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
>> stop_cpu() only needs to be called during __cpufreq_remove_dev_prepare() no
>> where else.
>
> Oh, thanks for reminding us..
>
> Look at this Saravana:
> 367dc4a cpufreq: Add stop CPU callback to cpufreq_driver interface
>

I'll only get called at the same time as it is called today. 
__cpufreq_remove_dev_prepare is now renamed to __cpufreq_remove_dev. And 
this function is called from there.

The only time stop does get called is when __cpufreq_remove_dev is 
called on the last CPU of a policy. So, functionally it's identical.

Btw, I already added logs to all cpufreq driver ops and checked the 
calls come in the same order with and without my changes.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
