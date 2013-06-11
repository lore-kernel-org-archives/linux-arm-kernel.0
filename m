From: jagarwal@nvidia.com (Jay Agarwal)
Date: Tue, 11 Jun 2013 10:22:59 +0530
Subject: [PATCH V3 3/4] ARM: dts: tegra: Correct PCIe entry
In-Reply-To: <20130610195511.GC25859@mithrandir>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <1370372252-4332-3-git-send-email-jagarwal@nvidia.com>
 <20130610195511.GC25859@mithrandir>
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BEEF@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Wed, Jun 05, 2013 at 12:27:31AM +0530, Jay Agarwal wrote:
> [...]
> > @@ -29,7 +29,7 @@
> >  		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000
> /* port 0 configuration space */
> >  			  0x82000000 0 0x00001000 0x00001000 0 0x00001000
> /* port 1 configuration space */
> >  			  0x82000000 0 0x00004000 0x00004000 0 0x00001000
> /* port 2 configuration space */
> > -			  0x81000000 0 0          0x02000000 0 0x00010000   /*
> downstream I/O */
> > +			  0x81000000 0 0          0x02000000 0 0x00100000   /*
> downstream I/O */
> >  			  0x82000000 0 0x20000000 0x20000000 0 0x10000000
> /* non-prefetchable memory */
> >  			  0xc2000000 0 0x30000000 0x30000000 0 0x10000000>;
> /*
> > prefetchable memory */
> 
> That increases the I/O region size from 64 KiB to 1 MiB. Why is that
> necessary? I/O operations can only address 64 KiB, so I don't think adding
> more makes any sense.
> 
Okay, you can keep it 64KiB then, I did it to match with downstream. 
Please let me know if you want me to upload new patch for this or you will take care while integrating.
