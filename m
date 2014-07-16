From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Jul 2014 20:58:15 +0530
Subject: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <53C68C54.3010900@gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <53C68C54.3010900@gmail.com>
Message-ID: <CAKohpokLzMbzr4kdL6wCL7MZgnVe0CQhbJHKL5wWeETH1YwEOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2014 19:59, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> stop_cpu() only needs to be called during __cpufreq_remove_dev_prepare() no
> where else.

Oh, thanks for reminding us..

Look at this Saravana:
367dc4a cpufreq: Add stop CPU callback to cpufreq_driver interface
