From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 15:53:04 +0100
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E2053543C@FRAEML521-MBX.china.huawei.com>
References: <20170401.112603.1991545644693496714.davem@davemloft.net>
 <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C52@AcuExch.aculab.com>
 <DB5PR05MB138288172B04713EB0C1DB55D3190@DB5PR05MB1382.eurprd05.prod.outlook.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E205352FC@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E2053543C@FRAEML521-MBX.china.huawei.com>
Message-ID: <20170424145304.GK12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 02:46:19PM +0000, Gabriele Paoloni wrote:
> > From: Amir Ancel [mailto:amira at mellanox.com]
> > Sent: 18 April 2017 21:18
> > To: David Laight; Gabriele Paoloni; davem at davemloft.net
> > Cc: Catalin Marinas; Will Deacon; Mark Rutland; Robin Murphy;
> > jeffrey.t.kirsher at intel.com; alexander.duyck at gmail.com; linux-arm-
> > kernel at lists.infradead.org; netdev at vger.kernel.org; Dingtianhong;
> > Linuxarm
> > Subject: Re: Re: [PATCH net-next 1/4] ixgbe: sparc: rename the
> > ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
> > 
> > Hi,
> > mlx5 driver is planned to have RO support this year.
> > I believe drivers should be able to query whether the arch support it
> 
> I guess that here when you say query you mean having a config symbol
> that is set accordingly to the host architecture, right?
> 
> As already said I have looked around a bit and other drivers do not seem
> to enable/disable RO for their EP on the basis of the host architecture.
> So why should mlx5 do it according to the host?
> 
> Also my understating is that some architectures (like ARM64 for example)
> can have different PCI host controller implementations depending on the
> vendor...therefore maybe it is not appropriate there to have a Kconfig
> symbol selected by the architecture...  

Indeed. We're not able to determine whether or not RO is supported at
compile time, so we'd have to detect this dynamically if we want to support
it for arm64 with a single kernel Image. That means either passing something
through firmware, having the PCI host controller opt-in or something coarse
like a command-line option.

Will
