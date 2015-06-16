From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 16 Jun 2015 11:37:27 -0400
Subject: [PATCH v2] drivers/cpufreq: Convert non-modular s5pv210-cpufreq.c
 to use builtin_platform_driver
In-Reply-To: <2052041.toNogcAkWs@vostro.rjw.lan>
References: <20150512070444.GE32300@linux>
 <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
 <2052041.toNogcAkWs@vostro.rjw.lan>
Message-ID: <558042B7.5090409@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-06-15 07:50 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 03, 2015 05:12:46 PM Paul Gortmaker wrote:
>> This file depends on a Kconfig option which is a bool, so
>> we use the appropriate registration function, which avoids us
>> relying on an implicit inclusion of <module.h> which we are
>> doing currently.
>>
>> While this currently works, we really don't want to be including
>> the module.h header in non-modular code, which we'd be forced
>> to do, pending some upcoming code relocation from init.h into
>> module.h.  So we fix it now by using the non-modular equivalent.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: linux-pm at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I'm assuming that this will go in via the Samsung tree.

Per other patch, I'll have to keep a copy in my branch to
avoid introducing bisect compile fails into the git history.

Thanks,
Paul.


> 
> 
