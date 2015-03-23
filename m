From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Mar 2015 09:49:16 -0700
Subject: [PATCH v2 00/13] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150323164916.GA15676@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, Mar 20, 2015 at 08:11:09PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my patch-set to add support for the musb variant found on
> Allwinner sunxi SoCs.
> 
> Changes since the original posting:
> -Removed the sunxi specific phy functions, instead the id / vbus gpio polling
>  has been moved to the phy-sun4i-usb driver and their status is exported
>  through extcon for the sunxi-musb glue
> -Stop using syscon, instead Maxime Ripard's sunxi SRAM controller driver is now
>  used
> 
> This should address all review remarks against v1 of this patch-set, so
> hopefully we can start merging this upstream.
> 
> The "musb: Add support for the Allwinner sunxi musb" commit relies on
> Maxime's SRAM controller patches, so those need to get merged first,
> but the phy-sun4i-usb and musb preparation patches can be merged already
> (assuming there are no objections).
> 
> And then once the SRAM controller patches are in next we can also merge
> the "musb: Add support for the Allwinner sunxi musb" commit and the dts
> changes.

All the DT bits look fine to me. I'll wait for Felipe and Kishon
comments before merging those.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/b8c61ec3/attachment-0001.sig>
