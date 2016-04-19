From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Apr 2016 18:15:12 +0100
Subject: [PATCH] drivers: firmware: psci: add __init mark to
 psci_dt_cpu_init_idle
In-Reply-To: <57164CC6.1010201@arm.com>
References: <1458657329-2484-1-git-send-email-jszhang@marvell.com>
 <20160419150555.GB15458@red-moon> <57164CC6.1010201@arm.com>
Message-ID: <20160419171511.GA2939@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 04:20:38PM +0100, Sudeep Holla wrote:
> 
> 
> On 19/04/16 16:05, Lorenzo Pieralisi wrote:
> >Hi Jisheng,
> >
> >On Tue, Mar 22, 2016 at 10:35:29PM +0800, Jisheng Zhang wrote:
> >>psci_dt_cpu_init_idle() and psci_cpu_init_idle() are not needed after
> >>booting, so mark them as __init.
> >>
> 
> On the other hand, when I was trying to reuse arm_cpuidle_init to
> support ACPI LPIs, I found that we may need to remove __init tag on it
> as it gets called by hotplug notifiers in ACPI context.
> 
> I am not objecting this change, just mentioning with the hope to get
> solution to the above issue.

Yep, good point, it is not strictly necessary to merge it either
and I would avoid churning out changes given that we know we will
require to remove those __init tags anyway, so patch dropped.

Lorenzo
