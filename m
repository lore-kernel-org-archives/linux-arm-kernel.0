From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 03 Jan 2016 11:19:26 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151231221407.GF16023@sirena.org.uk>
References: <568088B4.6090207@ti.com> <1451342963.14631.13.camel@collins>
 <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk> <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk> <1451599146.9673.2.camel@collins>
 <20151231221407.GF16023@sirena.org.uk>
Message-ID: <1451816366.3428.4.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 31 d?cembre 2015 ? 22:14 +0000, Mark Brown a ?crit :
> On Thu, Dec 31, 2015 at 10:59:06PM +0100, Paul Kocialkowski wrote:
> 
> > I understand, thanks for pointing this out. Well, for my use case, there
> > is no use in disabling the chip at any point as it powers the external
> > mmc.
> 
> Presumably someone might decide not to use the MMC in some case (perhaps
> only mounting it when explicitly needed in order to save power for
> example, or the MMC subsystem might figure out a way to power down an
> idle MMC block device).

Makes sense, I'll keep that in mind.

> > Would you agree to have the enable pin handled directly (and by that, I
> > mean enabled once, when requested, as I first suggested in the patchset)
> > in the driver then?
> 
> That's probably fine, or do it via runtime PM (the framework is fairly
> simple to use, I'll probably go add support in the core for it in the
> next day or two as this seems like a sensible use case).  I can't
> remember if this device is a MFD or not and I'm just on my way out the
> door.

Runtime PM seems like a good fit (though I hadn't heard about it before:
you can guess I'm fairly new to kernel development), please let me know
whether you end up implementing it so I can try to handle the GPIO this
way.

Thanks!

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160103/025b5c72/attachment.sig>
