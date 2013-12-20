From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 11:20:25 +0100
Subject: [PATCH 05/10] ARM: tegra: Enable eDP for Venice2
In-Reply-To: <52B367C7.9010301@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-6-git-send-email-treding@nvidia.com>
 <52B367C7.9010301@wwwdotorg.org>
Message-ID: <20131220102024.GI27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 02:40:23PM -0700, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:
> > Venice2 has a 12.9" (2560x1700) panel connected to the eDP output of the
> > Tegra124. The panel has an EDID to describe the video timings but needs
> > a few extra nodes to get the backlight to come up.
> 
> I started with next-20131219, merged your latest drm/for-next branch,
> and this doesn't seem to work.
> 
> With Laxman's regulator patch applied and your 1/10 dropped since it's a
> duplicate, the LCD backlight doesn't light up. I extracted the following
> from this patch to fix Laxman's regulator definitions:
> 
>                         gpio = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_LOW>;
> +                       enable-active-high;
>                 };
> 
> and the backlight does light up, but that's all.
> 
> With Laxman's regulator patch reverted and your patch 1/10 applied to
> replace it, I see the backlight working without having to manually fix
> up the device tree. However, that's still all; nothing is actually
> displayed.

Nothing's displayed because the driver isn't actually there yet. It's
still stuck in internal review for some reason.

I should've probably been explicit about that.

> Again, can you please rebase this whole series on the latest Tegra
> for-3.14/dt and sort out the issues? Thanks.

Grmpf... yes, I suppose I'll go do that then. That's exactly the reason
why I said the other day that we shouldn't be adding regulators
willy-nilly without any means of actually testing.

We've seen this happen on Dalmore before, and it's now happening with
Venice2. The same applies to pinmux. If we keep having to correct the
DTS files because it was all applied at once "to avoid churn" we're not
actually gaining anything.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/25f9c68b/attachment-0001.sig>
