From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 12 Mar 2015 18:18:49 +0200
Subject: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
In-Reply-To: <20150312124501.GA632@ulmo>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
 <20150312124501.GA632@ulmo>
Message-ID: <20150312161849.GF6072@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 01:45:02PM +0100, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Mar 12, 2015 at 08:15:18PM +0800, Vince Hsu wrote:
> > We switch to generic power domain now. So remove the legacy functions.
> > 
> > Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
> >  include/soc/tegra/pmc.h | 22 ----------------
> >  2 files changed, 90 deletions(-)
> 
> I don't think we can do this. What if somebody updates their kernel but
> not the DTB? In that case they'll end up with drivers that don't enable
> power partitions but at the same time the powergate driver won't enable
> them either because it is missing the corresponding nodes in the DTB.
> 
> What we'll have to do is probably keep the code that enables the power
> partitions and make it conditional on the power domains somehow. Is
> there a way to determine at runtime whether a device has been attached
> to a power domain?

Or use DT overlays to 'load' a hardcoded overlay for the specific SoC?

Cheers,

Peter.
