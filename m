From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jun 2014 00:43:35 +0200
Subject: [RFC PATCH 3/4] drm/tegra: Request memory bandwidth for the
 display controller
In-Reply-To: <539F4E53.6080205@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
 <539F4E53.6080205@wwwdotorg.org>
Message-ID: <20140617224334.GC25309@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 02:06:43PM -0600, Stephen Warren wrote:
> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> > Request it based solely on the current mode's refresh rate. More
> > accurate requirements can be requested in future patches.
> 
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> 
> > +	bandwidth = mode->clock * window.bits_per_pixel / 8;
> > +	err = tegra124_emc_reserve_bandwidth(TEGRA_EMC_CONSUMER_DISP1, bandwidth);
> 
> DISP1 shouldn't be hard-coded here; the code should use DISP1 or DISP2
> based on head or DC identity. We certainly have some boards capable of
> dual-head operation.

On a general note, I think perhaps a better way to represent this in an
API, and perhaps this would help with making the API more generic, too,
would be to make drivers request some sort of handle in .probe() and use
that handle subsequently when making requests. That's somewhat analogous
to the PM QoS' struct pm_qos_request.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/38042c1e/attachment.sig>
