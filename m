From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 2 May 2014 11:23:51 -0700
Subject: [PATCH v4 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
References: <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <1399044359-15784-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
Message-ID: <CAL1qeaHrP+i4EhOQKkSX7xFNyiyBiBfpsV3B0EHCFcrNzc6KLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +     /*
>> +      * TODO: Turn off the clusters when all cores in the cluster
>> +      * are down to achieve significant power savings.
>> +      */
>
> This comment should actually be located right after the
> "if (exynos_cluster_unused(cluster))" above.  That is where the cluster
> control should be applied, assuming it'll be effective only when WFI is
> executed.

Correct me if I'm wrong Samsung folks, but I thought it was not
possible to apply cluster power control from a CPU within the cluster
being powered down, i.e. a CPU in the other cluster must be the one to
apply the cluster power control to power down the outbound cluster.

-Andrew
