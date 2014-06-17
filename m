From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 23:51:20 +0200
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
 <539F691E.5030204@wwwdotorg.org> <20140617121313.GE18816@ulmo>
 <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140617215119.GC24743@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 05:01:46PM +0300, Peter De Schrijver wrote:
> On Tue, Jun 17, 2014 at 02:13:15PM +0200, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
> > > On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > > > This symbol needs to be exported to power on rails without using
> > > > tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> > > > cannot be used in situations where the driver wants to handle clocking
> > > > by itself.
> > > 
> > > Thierry, are you OK with this change?
> > 
> > I would've preferred tegra_powergate_sequence_power_up() to be used
> 
> I don't think the current tegra_powergate_sequence_power_up() API is very well
> defined though. I don't think the clocks and resets required by the sequence
> should be provided by the driver. For one, there can be several clocks and
> resets that need to be controlled for a single domain.

Do you have any suggestions for what the API should look like? Even if
we plan to move to some different API, I think there's some advantage in
using it consistently if for no other reason than to make it easier to
replace occurrences later on.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/80ed063c/attachment.sig>
