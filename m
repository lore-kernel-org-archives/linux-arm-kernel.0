From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 12:53:03 +0100
Subject: [PATCH 10/10] ARM: tegra: Enable USB on Venice2
In-Reply-To: <52B36720.8080205@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-11-git-send-email-treding@nvidia.com>
 <52B36720.8080205@wwwdotorg.org>
Message-ID: <20131220115302.GN27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 02:37:36PM -0700, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:
> > USB1 and USB3 are routed to two external connectors, while USB2 is used
> > for the integrated webcam.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Note: connecting a USB mouse to USB3 works properly and lsusb also detects
> > the integrated webcam, though I haven't tested whether the camera actually
> > works.
> > 
> > USB1 doesn't seem to work, but I suspect that might just be because it's
> > used for recovery mode and we can't switch it around at runtime yet.
> 
> The two regulators you added don't actually hook up to any GPIOs for
> control of VBUS, so perhaps this isn't surprising. The regulators added
> for VBUS control by Laxman's patch (which I already applied) *do* have
> some gpio properties. However, testing indicates:
> 
> * With Laxman's patch applied, and your patch 1/10 not applied since
> it's a duplicate, this patch doesn't work, i.e. I see no USB devices.
> 
> * With Laxman's patch reverted and your patch 1/10 replacing it, I do
> see USB devices, and they work. However, then we're not actually
> controlling VBUS, so USB1 doesn't work.
> 
> Can you please rebase this whole series on the latest Tegra for-3.14/dt
> and sort out the issues? Thanks.

I've looked into this a bit, but I don't see why it isn't working. The
PN4 and PN5 are the correct GPIOs for USB1 and USB3 VBUS, but hooking
them up indeed breaks things. For some reason adding those even causes
the camera on USB2 to not work properly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/5f19b4d9/attachment.sig>
