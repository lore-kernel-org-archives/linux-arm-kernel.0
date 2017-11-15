From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 15 Nov 2017 17:59:41 +0800
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <5A0B1597.3030809@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
 <20171113161445.xfqyuntza76ckdmq@hawk.localdomain> <5A0B1597.3030809@arm.com>
Message-ID: <e73be829-7a05-a354-43f3-538f7a393306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> (While VSESR_EL2 is 64bit[0], the value gets written into the ESR, which is
> 32bit, so I doubt the top 32bits can be used, currently they are all reserved.)

In fact the valid bits for vsesr_el2 is 25bit, which will set to ESR.ISS, bits [24:0].
ESR.IL and ESR.EC are not set by vsesr_el2.

> 
> I'll go dig into how x86 uses this...
> 
> 
> Thanks!
> 
> James
> 
> 
> [0]
> https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
> 
> .
> 
