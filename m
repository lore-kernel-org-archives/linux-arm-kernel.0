From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 6 Jul 2012 09:27:06 +0530
Subject: [PATCH v3 0/6] Port Tegra to generic clk framework
In-Reply-To: <4FF5E1C3.6070309@wwwdotorg.org>
References: <1341482120-3317-1-git-send-email-pgaikwad@nvidia.com>
 <4FF5E1C3.6070309@wwwdotorg.org>
Message-ID: <4FF66212.6080507@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012 12:19 AM, Stephen Warren wrote:
> On 07/05/2012 03:55 AM, Prashant Gaikwad wrote:
>> This patch set ports Tegra clock code to generic clock framework.
> Unfortunately, this series causes some regressions, so I can't apply it
> now. Given that, it won't make 3.6 since I won't be around to apply it.

Ok.

> I tested both Tegra's for-next, and next-20120705, both plus this
> series, next-20120705 plus the fix for the common clock code
> __clk_set_parent() issue.
>
> The following all appeared to work OK:
>
> Cardhu DT
> Ventana DT
> Seaboard DT
> Springbank DT
> Harmony DT
> Harmony non-DT
>
> However, the following failed, all(?) in ways that prevented the system
> getting to the login prompt:
>
> Whistler DT
> AC100 DT
> AC100 non-DT
> Trimslice DT
> Trimslice non-DT
>
> (The one slight difference between the 2 branches I tested is that AC100
> and Trimslice booted using DT passed in next-20120705 but failed only in
> Tegra's for-next. Otherwise, all results were identical)
>
> I'll try to investigate what the issues are since I imagine you don't
> have access to these boards. But, I probably won't be able to fix this
> until I return from vacation.

I am not sure how DT/non-DT should make difference to this series.
I don't have access to those boards but if you can share the failure log 
I can try to pinpoint the fix.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
