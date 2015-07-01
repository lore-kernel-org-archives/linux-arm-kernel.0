From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Jun 2015 18:19:03 -0700
Subject: [PATCH] arm: perf: Set affinity for PPI based PMUs
In-Reply-To: <20150630085225.GA25828@arm.com>
References: <1435615126-16492-1-git-send-email-sboyd@codeaurora.org>
 <20150630085225.GA25828@arm.com>
Message-ID: <55934007.7000906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 01:52 AM, Will Deacon wrote:
> Looks good to me as a fix, but I'm currently working on extending the
> interrupt-affinity property to work with both SPIs and PPIs so that we
> can use it to identify PMU affinity on multi-cluster systems.
>
>   https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=perf/updates&id=633fa0b629d86e58d68aff295f92031877dd0294
>
> Any chance you could take that for a spin on your platform, please?
>

The patch you point to works fine on Krait based platforms when the
interrupt-affinity property isn't present in DT. We (luckily?) don't
have any multi-cluster Krait designs so we don't need to add the
interrupt-affinity property in those DTs. Feel free to add a

Tested-by: Stephen Boyd <sboyd@codeaurora.org> # Krait PMU

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
