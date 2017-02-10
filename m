From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 10 Feb 2017 11:12:47 +0100
Subject: [PATCH net-next 6/8] net: ethernet: annapurna: add wol helpers
 to the Alpine driver
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB027C6C3@AcuExch.aculab.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-7-antoine.tenart@free-electrons.com>
 <08b62752-8bb2-4633-c44f-74eb585e7e52@cogentembedded.com>
 <063D6719AE5E284EB5DD2968C1650D6DB027C6C3@AcuExch.aculab.com>
Message-ID: <20170210101247.pxie2wtkbgh4th7f@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Feb 06, 2017 at 11:35:49AM +0000, David Laight wrote:
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On Behalf Of Sergei Shtylyov
> > Sent: 03 February 2017 18:22
> > On 02/03/2017 09:12 PM, Antoine Tenart wrote:
> > 
> > > +	if ((adapter) && (adapter->phy_exist) && (adapter->mdio_bus)) {
> > 
> >     Now that's somewhat stupid looking... does the whole driver use this "style"?
> 
> Not only that, in one of the two functions it is followed by:
> 
> +	device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);
> 
> Which assumes that 'adapter' is not NULL.
> Some verifiers will detect that as a possible NULL pointer dereference.
> 
> Pointers should only be checked for NULL if there are valid reasons
> why they can be NULL in that code path.
> Getting there with a NULL pointer dues to some race condition isn't one of them.

Totally agree, for the NULL checks and for the useless parenthesis. I'll
try to catch other examples of this in the driver.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/dc32ea36/attachment.sig>
