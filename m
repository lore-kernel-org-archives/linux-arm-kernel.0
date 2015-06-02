From: majun258@huawei.com (majun (F))
Date: Tue, 2 Jun 2015 19:34:25 +0800
Subject: [PATCH 3/4]: Change arm-gic-its to support the Mbigen interrupt
In-Reply-To: <556C2226.70502@arm.com>
References: <55692C32.2050209@huawei.com> <556C2226.70502@arm.com>
Message-ID: <556D94C1.6060300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:
	Thanks for your review.

Accroding to my initial scheme, mbigen and pci devices uses the
same parent domain--MSI domain.

But accroding to your opinion, it seems use the ITS domain as parent domain
of Mbigne is a better way. Am i right ?

Thanks
Ma Jun


? 2015/6/1 17:13, Marc Zyngier ??:
> Like I said in patch #1, you need to come up with a different approach.
> Use the LPI layer of the ITS as the parent for your MBI, stop messing
> with the PCI stuff, stop poking the ITS internals.
> 
> Thanks,
> 
> 	M.
