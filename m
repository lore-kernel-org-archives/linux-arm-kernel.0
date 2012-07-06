From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 6 Jul 2012 20:05:59 +0530
Subject: [PATCH v3 0/6] Port Tegra to generic clk framework
In-Reply-To: <4FF5E1C3.6070309@wwwdotorg.org>
References: <1341482120-3317-1-git-send-email-pgaikwad@nvidia.com>
 <4FF5E1C3.6070309@wwwdotorg.org>
Message-ID: <4FF6F7CF.9000405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012 12:19 AM, Stephen Warren wrote:
> On 07/05/2012 03:55 AM, Prashant Gaikwad wrote:
>> This patch set ports Tegra clock code to generic clock framework.
<snip>
> (The one slight difference between the 2 branches I tested is that AC100
> and Trimslice booted using DT passed in next-20120705 but failed only in
> Tegra's for-next. Otherwise, all results were identical)
>
> I'll try to investigate what the issues are since I imagine you don't
> have access to these boards. But, I probably won't be able to fix this
> until I return from vacation.

Stephen,

Can you please try removing "late_initcall(clk_disable_unused);" from 
drivers/clk/clk.c?
It will keep unused clocks enabled. If it works then there should not be 
any regression in this patch series but need to enable some board 
specific clock.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
