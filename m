From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 14 Dec 2014 23:23:48 +0100
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <20141214213655.GA11285@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
Message-ID: <7573578.UE8ufgjWuX@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 14, 2014 09:36:55 PM Russell King - ARM Linux wrote:
> Here's a nice Christmas present one of my iMX6 machines gave me tonight.
> I haven't begun to look into it.
> 
> ======================================================
> [ INFO: possible circular locking dependency detected ]
> 3.18.0+ #1453 Not tainted
> -------------------------------------------------------
> rc.local/770 is trying to acquire lock:
>  (cooling_cpufreq_lock){+.+.+.}, at: [<c04abfc4>] cpufreq_thermal_notifier+0x34/0xfc
> 
> but task is already holding lock:
>  ((cpufreq_policy_notifier_list).rwsem){++++.+}, at: [<c0042f04>]  __blocking_notifier_call_chain+0x34/0x68
> 
> which lock already depends on the new lock.

Well, that's for Viresh.

Also adding Eduardo as he's been working with Viresh on the cooling stuff recently.

Rafael
