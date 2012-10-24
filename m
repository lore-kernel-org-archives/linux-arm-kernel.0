From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 17:31:31 +0200
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <20121024172050.412ff1bf@skate>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024150614.GD11837@lunn.ch> <20121024172050.412ff1bf@skate>
Message-ID: <20121024153131.GG11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 05:20:50PM +0200, Thomas Petazzoni wrote:
> Andrew,
> 
> On Wed, 24 Oct 2012 17:06:14 +0200, Andrew Lunn wrote:
> 
> > There are two variants of this box, ax3/2 and ax3/4. The ax3/4 can
> > have more RAM and has a mini pci express slot. Do you expect both
> > boards to be supported with one dts file?
> 
> I have the ax3/4 version apparently.
> 
> So, we can have the following possible schemes:
> 
>  + openblocks-ax3.dtsi
>    + openblocks-ax3-2.dts
>    + openblocks-ax3-4.dts
> 
> But I am not sure if using a .dtsi to factorize things common between
> multiple boards is OK. Or we can do:
> 
>  + openblocks-ax3-2.dts
>    + openblocks-ax3-4.dts
> 
> With openblocks-ax3-4.dts being the simple addition of PCIe slot + more
> RAM. That said, I don't have the ax3/2 board anyway, so should we plan
> for something that nobody can test at the moment, or wait for someone
> to get a ax3/2 board, and therefore be able to do the testing? I think
> I prefer to submit dts files that are know to work and have been tested
> on hardware that we have.

Hi Thomas

I agree with the last point. So maybe have a openblocks-ax3-4.dts and
set the compatibility string to plathome,openblocks-ax3-4. 

When somebody gets a ax3/2, they can refactor the common DT into a
dtsi file without causing any compatibility issues.

     Andrew
