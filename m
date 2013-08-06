From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 6 Aug 2013 10:32:29 +0100
Subject: [RFC PATCH v2 0/3] ARM: TC2 big.LITTLE CPU idle driver
In-Reply-To: <5200A1FD.6050709@linaro.org>
References: <1375709982-27148-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5200A1FD.6050709@linaro.org>
Message-ID: <20130806093229.GB18810@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 08:13:01AM +0100, Daniel Lezcano wrote:
> On 08/05/2013 03:39 PM, Lorenzo Pieralisi wrote:
> > This patch is v2 of a previous posting:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186352.html
> > 
> > v2 changes:
> > 
> > - removed duplicated idle statistics and irq enabling
> > - use MPIDR masks to compute cluster and cpu ids
> 
> Hi Lorenzo,
> 
> I don't think this patch is still in RFC but ready for merging if nobody
> complains :)

Yes, you are right, I should have dropped RFC by now. Just one last
doubt I have and it is not really related to this patch but to the MCPM API.
I think that:

void mcpm_cpu_suspend()
void mcpm_cpu_power_down()

should fail gracefully with a return value instead of hitting a BUG_ON if the
platform_ops pointer is not initialized (ie likely to be a missing SCC node in
DT for TC2).

It is just a heads-up, thoughts appreciated, I really really do not want to
make this driver dependent on the vexpress SCC compatible string (or better on
the presence of an SCC DT node in the dts file), the compatible string we
are using should be correct.

Thanks,
Lorenzo
