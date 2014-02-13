From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 09:36:06 -0700
Subject: [PATCH] ARM: tegra: don't timeout if CPU is powergated
In-Reply-To: <20140213084907.GA11795@ulmo.nvidia.com>
References: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
 <52FBC97D.8040809@wwwdotorg.org> <4050206.sG2EzXyfMN@fb07-iapwap2>
 <20140213084907.GA11795@ulmo.nvidia.com>
Message-ID: <52FCF476.4010908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 01:49 AM, Thierry Reding wrote:
> On Thu, Feb 13, 2014 at 09:28:52AM +0100, Marc Dietrich wrote:
>> Am Mittwoch, 12. Februar 2014, 12:20:29 schrieb Stephen Warren:
>>> On 02/10/2014 05:44 PM, Stefan Agner wrote:
>>>> When booting secondary CPU(s) which are not yet powergated, a wrong
>>>> check lead to a timeout after 100 jiffies. With this patch, we only
>>>> delay powergating if CPUs are still not powered yet.
>>>
>>> I've applied this to Tegra's for-3.15/soc branch.
>>
>> also for 3.14 and maybe lower versioned kernels? Since this seems to fix a bug 
>> where some core doesn't come up.
> 
> Yeah, this bug has been there for pretty much forever it seems. Commit
> 86e51a2ee471 "ARM: tegra: support for secondary cores on Tegra30" added
> tegra30_boot_secondary() (named tegra30_power_up_cpu() back then, which
> was renamed to tegra30_boot_secondary() in commit 0d1f79b033bb "ARM:
> tegra: refactor tegra{20,30}_boot_secondary". The latter was introduced
> in v3.10, so I guess backporting it to stable releases all the way back
> to v3.10 would be good.
> 
> Backporting to earlier versions (86e51a2ee471 went into v3.4) will be a
> lot more difficult since some of the APIs were renamed since then.

I'm actually uninclined to backport this; I've never once seen an issue
because of this problem, and nobody has reported it in older kernels.
