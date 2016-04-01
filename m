From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 1 Apr 2016 17:32:39 +0800
Subject: [PATCH v7 12/17] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <56FE3E85.60403@huawei.com>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-13-git-send-email-shannon.zhao@linaro.org>
 <20160329161837.GH6745@arm.com> <20160329163147.GB27223@leverpostej>
 <56FB7E00.7030400@huawei.com>
 <alpine.DEB.2.02.1603311155450.11739@kaball.uk.xensource.com>
 <CAKv+Gu-wPq_FzO3sm7bhSFuu7EVxHWB_v6HOn1GqNbdaE-iBoQ@mail.gmail.com>
 <20160331124216.GE26532@leverpostej> <56FE3E85.60403@huawei.com>
Message-ID: <56FE4037.5060305@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/1 17:25, Shannon Zhao wrote:
> If it really needs is_xen_node(), I will not factor
> fdt_find_hyper_node() in patch 11 since it uses flat DT while here it's
> going to use unflatten DT.
Sorry, I'm wrong. They both use flat DT. But it's no need to factor
fdt_find_hyper_node() since is_xen_node is very simple like below I think.

of_flat_dt_is_compatible(node, "xen,xen");

And maybe it cloud directly use above check in dt_scan_depth1_nodes.

Thanks,
-- 
Shannon
