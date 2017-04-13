From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 13 Apr 2017 09:10:32 +0000
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
References: <20170401.112603.1991545644693496714.davem@davemloft.net>
 <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David

> -----Original Message-----
> Subject: Re: [PATCH net-next 1/4] ixgbe: sparc: rename the
> ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
> Date: Sat, 1 Apr 2017 11:26:03 -0700
> From: David Miller <davem@davemloft.net>
> To: dingtianhong at huawei.com
> CC: catalin.marinas at arm.com, will.deacon at arm.com, mark.rutland at arm.com,
> robin.murphy at arm.com, jeffrey.t.kirsher at intel.com,
> alexander.duyck at gmail.com, linux-arm-kernel at lists.infradead.org,
> netdev at vger.kernel.org
> 
> From: Ding Tianhong <dingtianhong@huawei.com>
> Date: Sat, 1 Apr 2017 15:25:51 +0800
> 
> > Till now only the Intel ixgbe could support enable
> > Relaxed ordering in the drivers for special architecture,
> > but the ARCH_WANT_RELAX_ORDER is looks like a general name
> > for all arch, so rename to a specific name for intel
> > card looks more appropriate.
> >
> > Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> 
> This is not a driver specific facility.
> 
> Any driver can test this symbol and act accordingly.
> 
> Just because IXGBE is the first and only user, doesn't mean
> the facility is driver specific.


Please correct me if I am wrong but my understanding is that the standard
way to enable/disable relaxed ordering is to set/clear bit 4 of the Device
Control Register (PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed
ordering */).
Now I have looked up for all drivers either enabling or disabling relaxed
ordering and none of them seems to need a symbol to decide whether to
enable it or not.
Also it seems to me enabling/disabling relaxed ordering is never bound to the
host architecture.

So why this should be (or it is expected to be) a generic symbol?
Wouldn't it be more correct to have this as a driver specific symbol now and
move it to a generic one later once we have other drivers requiring it?
  
Many thanks
Gab

> 
> Thank you.
> 
> .
> 
