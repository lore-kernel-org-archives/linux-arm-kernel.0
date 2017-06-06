From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 6 Jun 2017 15:51:48 +0200
Subject: [PATCH] net: mvpp2: do not bypass the mvpp22_port_mii_set function
In-Reply-To: <20170606154535.3e87bafb@free-electrons.com>
References: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
 <20170606154535.3e87bafb@free-electrons.com>
Message-ID: <20170606135148.GA22618@kwain.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Tue, Jun 06, 2017 at 03:45:35PM +0200, Thomas Petazzoni wrote:
> On Tue,  6 Jun 2017 15:36:15 +0200, Antoine Tenart wrote:
> > The mvpp22_port_mii_set() function was added by 2697582144dd, but the
> > function directly returns without doing anything. This return was used
> > when debugging and wasn't removed before sending the patch. Fix this.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> Please add:
> 
> Fixes: 2697582144dd ("net: mvpp2: handle misc PPv2.1/PPv2.2 differences")
> 
> with this:
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

OK, will do.

> I am wondering if we shouldn't Cc: stable as well. I don't think we
> have seen issues on our side because U-Boot does the necessary
> initialization, but people using other bootloaders might have issues.

Yes, that might be safer to cc stable. I'll do this as well.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/c5161206/attachment.sig>
