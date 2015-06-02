From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jun 2015 09:45:28 -0500
Subject: [PATCH v4 0/2] Remaining sunxi musb patches
In-Reply-To: <556D57BD.90502@redhat.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <79fc4306-a621-43b8-b347-e42a27beb134@googlegroups.com>
 <20150601183447.GF26081@saruman.tx.rr.com>
 <556D57BD.90502@redhat.com>
Message-ID: <20150602144528.GA9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 02, 2015 at 09:14:05AM +0200, Hans de Goede wrote:
> >>>Here is an updated version of the remaining (not yet merged in Felipe's
> >>>tree)
> >>>sunxi musb patches.
> >>>
> >>>The "phy-sun4i-usb: Add full support for usb0 phy / OTG" patch has been
> >>>updated with a small bug-fix and is ready for merging.
> >>>
> >>>The "musb: Add support for the Allwinner sunxi musb" patch has been
> >>>updated
> >>>to use the latest version of Maxime's sunxi sram controller driver. This
> >>>one has a compile-time dependency on Maxime's sunxi sram controller
> >>>driver,
> >>>so it cannot be merged until that is merged.
> >>>
> >>
> >>
> >>Arnd has just merged the updated sram controller into the next branch
> >>of the soc-drivers repo, so both these patches are now ready to merge.
> >
> >all right, so for v4.3 merge window there will be no issues in queues
> >the two remaining patches. Thanks
> 
> So I take it that it is too late to get these 2 into 4.2 ? I've a bunch
> of (small) follow up patches coming up to enable support for the musb
> controller on new boards, merging those would be easier if these were
> already merged. And there also is a largish set of sunxi dts patches
> actually enabling the musb code which is sorta waiting for merging
> these 2 (waiting for the dt binding to be stable).

DTS should not have to wait. If we know what the compatible should look
like, you can send your DTS upstream no problem. There will just be a
few devices which will not trigger a driver probe, but that's just fine.

> If this is not going to make 4.2, can you and Kishon at least review
> them and let me know of they will get merged for 4.3 as is (baring
> any merge issues) ?

Sure, that I can do, no issues.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/e443db59/attachment.sig>
