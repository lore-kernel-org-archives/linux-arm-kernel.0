From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 3 Aug 2018 12:43:18 +0200
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <20180714212210.at4b2gcpopsznyxx@localhost>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
 <20180712154128.22705-6-thierry.reding@gmail.com>
 <20180714212210.at4b2gcpopsznyxx@localhost>
Message-ID: <20180803104318.GA28546@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2018 at 02:22:10PM -0700, Olof Johansson wrote:
> On Thu, Jul 12, 2018 at 05:41:28PM +0200, Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> > 
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-arm64-dt
> > 
> > for you to fetch changes up to 7780a03495e13cd2bef704bcbf8c727de9f65232:
> > 
> >   arm64: tegra: Add CPU nodes to Tegra194 device tree (2018-07-02 15:57:39 +0200)
> > 
> > Thanks,
> > Thierry
> > 
> > ----------------------------------------------------------------
> > arm64: tegra: Device tree changes for v4.19-rc1
> > 
> > These changes enable the GPIO controllers on Tegra194 SoCs, which in
> > turn allows the SD card detection and ethernet controllers to be enabled
> > as well. The Tegra194 device tree is also extended with the list of CPUs
> > and a PSCI node to inform the kernel about the presence of PSCI capable
> > firmware.
> 
> Merged, thanks. Are you planning on supporting 194 better than 186? That never
> really made it to a useful level upstream I think? :(

I think we have pretty decent upstream support for Tegra186 at this
point. It took a little time because Tegra186 was a little work than
many previous chips because the changes were less incremental than
before.

Generally our goal is to provide at least feature parity with prior
chips for each new chip. Usually we manage to incrementally add new
features, too.

Perhaps the reason why it seems that Tegra186 is not well supported
upstream is because a lot of things have moved into BPMP firmware,
which deals with a lot of the nitty gritty details that prior chips
needed a driver for.

That said, I may be missing something. Do you have any specific features
in mind that aren't working upstream on Tegra186?

Tegra194 uses the same firmware as Tegra186 (well, a binary compatible
interface to the firmware, I should say), so we've been able to
bootstrap it much quicker than prior chips. That said, there are a slew
of new features in Tegra194, not all of which are easy to upstream. But
we're still aiming for at least feature parity with prior chips and get
as much of the new hardware supported as we can.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180803/5cb38a47/attachment.sig>
