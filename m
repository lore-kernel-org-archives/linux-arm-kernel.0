From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 18:07:39 +0100
Subject: [PATCH 2/2] mmc: sdhci: Defer probe if regulator_get fails
In-Reply-To: <5086C5F5.4070801@wwwdotorg.org>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com>
 <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com>
 <1350979047.20572.6.camel@tellur> <5086C5F5.4070801@wwwdotorg.org>
Message-ID: <20121023170723.GD4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:29:41AM -0600, Stephen Warren wrote:
> On 10/23/2012 01:57 AM, Lucas Stach wrote:

> > Does this work with boards where we don't have any MMC supplies? Or are
> > we just deferring the probe indefinitely there?

> > For boards that power MMC unconditionally, are we supposed to add dummy
> > regulators to make them work with this patchset?

> I believe that dummy (fixed) regulators are supposed to be provided in
> all cases where the platform doesn't actually have one. The fact that
> everything worked OK without them before this patch was most likely a
> mistake/accident.

That's the general idea; clearly there *are* supplies here, they're just
not software controlled supplies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/e239279e/attachment.sig>
