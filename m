From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Feb 2014 12:21:07 -0500
Subject: [PATCH] mvebu : pcie: dt: potential issue in range parsing
In-Reply-To: <20140205164710.082f689e@skate>
References: <1389349431-7997-1-git-send-email-jjhiblot@traphandler.com>
 <20140205164710.082f689e@skate>
Message-ID: <20140205172107.GU8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+ Bjorn, linux-pci

Bjorn,

It looks like this didn't get Cc'd to linux-pci.  Here's a link:

  http://www.spinics.net/lists/arm-kernel/msg299721.html

On Wed, Feb 05, 2014 at 04:47:10PM +0100, Thomas Petazzoni wrote:
> Dear Jean-Jacques Hiblot,
> 
> On Fri, 10 Jan 2014 11:23:51 +0100, Jean-Jacques Hiblot wrote:
> > The second parameter of of_read_number is not the index, but a size.
> > As it happens, in this case it may work just fine because of the the conversion
> > to u32 and the favorable endianness on this architecture.
> > 
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index c269e43..877e8ce 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -768,7 +768,7 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
> >  
> >  	for (i = 0; i < nranges; i++) {
> >  		u32 flags = of_read_number(range, 1);
> > -		u32 slot = of_read_number(range, 2);
> > +		u32 slot = of_read_number(range + 1, 1);
> >  		u64 cpuaddr = of_read_number(range + na, pna);
> >  		unsigned long rtype;
> >  
> 
> Sorry for the long delay, and thanks for the fix!
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> (on Armada 370, with PCIe cards plugged in)


Fixes: 11be65472a427 ("PCI: mvebu: Adapt to the new device tree layout")
Cc: <stable@vger.kernel.org> # v3.12+
Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
