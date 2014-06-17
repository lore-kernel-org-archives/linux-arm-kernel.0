From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 14:13:15 +0200
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <539F691E.5030204@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
 <539F691E.5030204@wwwdotorg.org>
Message-ID: <20140617121313.GE18816@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > This symbol needs to be exported to power on rails without using
> > tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> > cannot be used in situations where the driver wants to handle clocking
> > by itself.
> 
> Thierry, are you OK with this change?

I would've preferred tegra_powergate_sequence_power_up() to be used
consistently in all drivers. I'm still not convinced that using the
platform AHCI driver this way is really the best option, since we're
bending over backwards to fit into what this driver dictates. There
shouldn't be a need for that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/621f2d7e/attachment.sig>
