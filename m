From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jul 2017 14:08:47 +0100
Subject: [PATCH v3 1/6] Documentation: perf: hisi: Documentation for
 HiSilicon SoC PMU driver
In-Reply-To: <c5c552e2-94e2-9390-9cda-2573844b926d@hisilicon.com>
References: <1500364799-90518-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500364799-90518-2-git-send-email-zhangshaokun@hisilicon.com>
 <20170719171748.00005866@huawei.com>
 <c5c552e2-94e2-9390-9cda-2573844b926d@hisilicon.com>
Message-ID: <20170720130847.GB16356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 08:54:36PM +0800, Zhangshaokun wrote:
> On 2017/7/19 17:17, Jonathan Cameron wrote:
> >> +Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has two HHAs
> >> +(0 - 1) and four DDRCs (0 - 3), respectively.
> >> +
> >> +HiSilicon SoC uncore PMU driver
> >> +---------------------------------------
> >> +Each device PMU has separate registers for event counting, control and
> >> +interrupt, and the PMU driver shall register perf PMU drivers like L3C,
> >> +HHA and DDRC etc. The available events and configuration options shall
> >> +be described in the sysfs, see /sys/devices/hisi_*.  
> > Is there not a subsystem directory that would make more sense to
> > refer to than the full device list?
> > 
> 
> For uncore devices, it is more reasonable to list in /sys/devices/***.

The usual place for these things is /sys/bus/event_source/devices/<pmu name>.

The events are described as files under the events directory (one file per
event, which describes the encoding) and you can describe other things such
as formatting and/or capabilities under other directories too.

Take a look at some other PMU drivers to get an idea of how it works.

Will
