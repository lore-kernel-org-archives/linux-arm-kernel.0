From: rafael@kernel.org (Rafael J. Wysocki)
Date: Mon, 15 Feb 2016 21:38:25 +0100
Subject: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
In-Reply-To: <56C23088.8050400@roeck-us.net>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <20160215190116.GX19432@atomide.com>
 <56C229A5.8020901@roeck-us.net>
 <20160215195839.GA19432@atomide.com>
 <56C23088.8050400@roeck-us.net>
Message-ID: <CAJZ5v0hqVCXE0kDfr_4zLz_-c-4KJo8bJg8xVVc1Qd66eA+iHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 9:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/15/2016 11:58 AM, Tony Lindgren wrote:
>>
>> * Guenter Roeck <linux@roeck-us.net> [160215 11:41]:
>>>
>>> On 02/15/2016 11:01 AM, Tony Lindgren wrote:
>>>>
>>>>
>>>> https://kernelci.org/boot/all/job/next/kernel/next-20160215/
>>>>
>>>> The SMP ones seem to fail with some regulator issues?
>>>>
>>>
>>> There is another problem, introduced with 6a0712f6f199e ("PM / OPP: Add
>>> dev_pm_opp_set_rate()"). The kernelci boot log for
>>> next-20160212:omap3-overo-tobi
>>> and others experience that problem.
>>>
>>> Essentially, the code now assumes that a CPU clock always has a voltage
>>> regulator attached to it, which is not correct. I sent out a patch to fix
>>> that problem a minute ago.
>>
>>
>> Yes that fixed it thanks.
>>
>
> Confirmed. With this patch plus mine, all arm qemu tests are again passing
> for me.

OK, I'll add it to the governor changes branch.

Thanks,
Rafael
