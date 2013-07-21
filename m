From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 21 Jul 2013 16:38:43 +0100
Subject: [PATCH v2] xen/arm: disable cpuidle and cpufreq when linux is
 running as dom0
In-Reply-To: <alpine.DEB.2.02.1307211508520.4893@kaball.uk.xensource.com>
References: <1374233220-13770-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307211508520.4893@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1307211638260.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Jul 2013, Stefano Stabellini wrote:
> On Fri, 19 Jul 2013, Julien Grall wrote:
> > When linux is running as dom0, Xen doesn't show the physical cpu but a
> > virtual CPU.
> > On some ARM SOC (for instance the exynos 5250), linux registers callbacks
> > for cpuidle and cpufreq. When these callbacks are called, they will modify
> > directly the physical cpu not the virtual one. It can impact the whole board
> > instead of only dom0.
> > 
> > Signed-off-by: Julien Grall <julien.grall@linaro.org>
> > 
> 
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

I added the patch to my queue
