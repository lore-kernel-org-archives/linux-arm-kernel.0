From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:42:19 -0700
Subject: [GIT PULL] clk: tegra: Changes for v4.7-rc1
In-Reply-To: <20160509051946.GA18753@ulmo.ba.sec>
References: <1461945596-24090-1-git-send-email-thierry.reding@gmail.com>
 <20160503000248.GB3492@codeaurora.org>
 <20160509051946.GA18753@ulmo.ba.sec>
Message-ID: <20160509224219.GY3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09, Thierry Reding wrote:
>
> I'm not aware of any API that would fit in this case. Power domains
> would be misleading because power management isn't involved. One other
> alternative that I had thought about is to make it a "virtual" reset,
> but that is equally misleading because nothing is really being reset
> here.
> 
> Yet another option might be to make it a "virtual" clock, though it'd
> have to be somewhat hacky because we need two steps (one to enable HW
> control and another to start the HW sequencer). That could be
> implemented using ->prepare() and ->enable(), respectively, but it's
> really not a clock either.
> 
> I welcome any ideas on how to turn this into something generic, though.
> 

I suggested power domains because it looks like SoC glue code
that we need to do when the device is powered on and off? Unless
I totally misread how it was used. And I suppose I should have
said generic power domains (genpd) instead of power domains,
because I agree it's not actual power management, just some SoC
runtime PM stuff it seems. But who knows, I probably misread it
all.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
