From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 14 Jul 2017 11:54:53 -0500
Subject: [PATCH] spmi: pmic-arb: Always allocate ppid_to_apid table
In-Reply-To: <20170627021746.22445-1-sboyd@codeaurora.org>
References: <20170627021746.22445-1-sboyd@codeaurora.org>
Message-ID: <20170714165453.GA25773@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 07:17:46PM -0700, Stephen Boyd wrote:
> After commit 7f1d4e58dabb ("spmi: pmic-arb: optimize table
> lookups") we always need the ppid_to_apid table regardless of the
> version of pmic arbiter we have. Otherwise, we will try to deref
> the array when we don't allocate it on v2 hardware like the
> msm8974 SoCs.
> 
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Cc: Kiran Gunda <kgunda@codeaurora.org>
> Fixes: 7f1d4e58dabb ("spmi: pmic-arb: optimize table lookups")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Greg,

Can you pick this up?  This is an urgent fix for Qualcomm 8x74 platforms.

Thanks!

Andy
