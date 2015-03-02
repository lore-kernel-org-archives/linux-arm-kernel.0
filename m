From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Mar 2015 18:24:24 +0000
Subject: [PATCH v3 0/3] Scorpion PMU support
In-Reply-To: <1425082295-10941-1-git-send-email-sboyd@codeaurora.org>
References: <1425082295-10941-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150302182424.GE7919@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 28, 2015 at 12:11:32AM +0000, Stephen Boyd wrote:
> These patches add support for the Scorpion PMU found on devices
> such as msm8660, qsd8x50, etc. The first patch is some groundwork
> to make functions more "generic". Even then we end up copying quite
> a bit of code from the Krait part into the Scorpion part with only
> subtle tweaks because two things happen:
> 
>  1. We gain another "region" register, L2LPM
>  2. The way to access the region registers are with different cp15 instructions
> 
> I'm not sure how to make this better, suggestions are welcome. The second
> patch is an optimization for an implementation defined register. The 
> final patch is the one that actually adds support for Scorpion.
> 
> Changes from v2:
>  * New patch 2
>  * Macros instead of an inline function for patch 1

Thanks, Stephen. I'll queue this for 4.1.

Will
