From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 7 Jun 2017 16:43:08 +0200
Subject: [PATCH 4/9] net: mvmdio: move the read valid check into its own
 function
In-Reply-To: <71f0a99b-4736-a405-1d06-9c05f80aa327@cogentembedded.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-5-antoine.tenart@free-electrons.com>
 <71f0a99b-4736-a405-1d06-9c05f80aa327@cogentembedded.com>
Message-ID: <20170607144308.GB4173@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 07, 2017 at 01:00:21PM +0300, Sergei Shtylyov wrote:
> On 6/7/2017 11:38 AM, Antoine Tenart wrote:
> > 
> > -	val = readl(dev->regs);
> > -	if (!(val & MVMDIO_SMI_READ_VALID)) {
> > +	if (orion_mdio_smi_is_read_valid(dev)) {
> >  		dev_err(bus->parent, "SMI bus read not valid\n");
> 
>    I think you reversed the valuid/invalid sense in the new function's name.

Good catch, I'll fix this.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/61219f52/attachment.sig>
