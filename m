From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 17 Jun 2014 17:01:46 +0300
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <20140617121313.GE18816@ulmo>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
 <539F691E.5030204@wwwdotorg.org> <20140617121313.GE18816@ulmo>
Message-ID: <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 02:13:15PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
> > On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > > This symbol needs to be exported to power on rails without using
> > > tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> > > cannot be used in situations where the driver wants to handle clocking
> > > by itself.
> > 
> > Thierry, are you OK with this change?
> 
> I would've preferred tegra_powergate_sequence_power_up() to be used

I don't think the current tegra_powergate_sequence_power_up() API is very well
defined though. I don't think the clocks and resets required by the sequence
should be provided by the driver. For one, there can be several clocks and
resets that need to be controlled for a single domain.

Cheers,

Peter.
