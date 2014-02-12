From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 12:20:29 -0700
Subject: [PATCH] ARM: tegra: don't timeout if CPU is powergated
In-Reply-To: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
References: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
Message-ID: <52FBC97D.8040809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 05:44 PM, Stefan Agner wrote:
> When booting secondary CPU(s) which are not yet powergated, a wrong
> check lead to a timeout after 100 jiffies. With this patch, we only
> delay powergating if CPUs are still not powered yet.

I've applied this to Tegra's for-3.15/soc branch.
