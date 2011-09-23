From: khilman@ti.com (Kevin Hilman)
Date: Fri, 23 Sep 2011 07:02:17 -0700
Subject: [PATCH 01/10] cpufreq: OMAP: cleanup for multi-SoC support,
	move into drivers/cpufreq
In-Reply-To: <9bc8649a2e151bec117424b678bb09f8@mail.gmail.com> (Vishwanath
	Sripathy's message of "Fri, 23 Sep 2011 14:51:51 +0530")
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-2-git-send-email-khilman@ti.com>
	<9bc8649a2e151bec117424b678bb09f8@mail.gmail.com>
Message-ID: <87d3erl5li.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> +#ifdef CONFIG_CPU_FREQ_DEBUG
>> +	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
>> freqs.new);
>> +#endif
>> +
>> +	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>
> Do you plan to post follow up patches to scale voltage along with Clock?

Yes.

This series is just a move of existing code + minor cleanups.

The next step is to finalize/merge Tero's regulator driver and use
that to scale voltage along with frequency here.

Now that the voltage domain cleanups are merged, I hope to have
regulator series + voltage scaling changes in this driver ready next week.

Kevin
