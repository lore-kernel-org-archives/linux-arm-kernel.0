From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 May 2014 14:37:42 -0400 (EDT)
Subject: [PATCH v4 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAL1qeaHrP+i4EhOQKkSX7xFNyiyBiBfpsV3B0EHCFcrNzc6KLQ@mail.gmail.com>
References: <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <1399044359-15784-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
 <CAL1qeaHrP+i4EhOQKkSX7xFNyiyBiBfpsV3B0EHCFcrNzc6KLQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405021435420.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 May 2014, Andrew Bresticker wrote:

> >> +     /*
> >> +      * TODO: Turn off the clusters when all cores in the cluster
> >> +      * are down to achieve significant power savings.
> >> +      */
> >
> > This comment should actually be located right after the
> > "if (exynos_cluster_unused(cluster))" above.  That is where the cluster
> > control should be applied, assuming it'll be effective only when WFI is
> > executed.
> 
> Correct me if I'm wrong Samsung folks, but I thought it was not
> possible to apply cluster power control from a CPU within the cluster
> being powered down, i.e. a CPU in the other cluster must be the one to
> apply the cluster power control to power down the outbound cluster.

Is this true even for deep idle C-states?


Nicolas
