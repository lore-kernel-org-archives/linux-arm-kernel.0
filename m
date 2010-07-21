From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Wed, 21 Jul 2010 11:04:52 -0700 (PDT)
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU,
	CPU and device memory management
In-Reply-To: <20100721072837.GB6009@n2100.arm.linux.org.uk>
References: <20100714220536.GE18138@n2100.arm.linux.org.uk>
	<20100715012958.GB2239@codeaurora.org>
	<20100715085535.GC26212@n2100.arm.linux.org.uk>
	<AANLkTinVZeaZxt_lWKhjKa0dqhu3_j3BRNySO-2LvMdw@mail.gmail.com>
	<20100716075856.GC16124@n2100.arm.linux.org.uk>
	<4C449183.20000@codeaurora.org>
	<20100719184002.GA21608@n2100.arm.linux.org.uk>
	<bb667e285fd8be82ea8cc9cc25cf335b.squirrel@www.codeaurora.org>
	<20100720222952.GD10553@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C61C5FCA@dbde02.ent.ti.com>
	<20100721072837.GB6009@n2100.arm.linux.org.uk>
Message-ID: <f63baf765051c19b85938ea73d6c6b2a.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> *************************************************************************
>> > This is difficult to achieve without remapping kernel memory using L2
>> > page tables, so we can unmap pages on 4K page granularity.  That's
>> > going to increase TLB overhead and result in lower system performance
>> > as there'll be a greater number of MMU misses.
> *************************************************************************

Given how the buffers in question can be on the orders of tens of MB (and
I don't think they will ever be less than 1MB), would we be able to get
the desired effect by unmapping and then remapping on a 1MB granularity
(ie, L1 sections)? It seems to me like this should be sufficient, and
would not require using L2 mappings. Thoughts?

Thanks
Steve

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
