From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 17:06:04 +0200
Subject: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <53C8F6E6.6020901@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
 <53C8C9BD.3070709@nvidia.com> <53C8F6E6.6020901@redhat.com>
Message-ID: <20140718150603.GA7196@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 12:28:54PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07/18/2014 09:16 AM, Mikko Perttunen wrote:
> > So here's v5: this time, as suggested, I handle the sata clock myself and let ahci_platform handle it too, leading it to be prepared+enabled twice. This works fine, and allows us to remove the DT ordering requirement.
> > 
> > I also have in the works a patchset that adds the name-based ahci_platform_get_resources function, but that is not quite ready yet, even if it is quite far along. Also, I am going on vacation and returning on 28.7., so if this v5 is acceptable maybe it could be merged for 3.17 and I could work on the new get_resources scheme after I get back from vacation?
> 
> Yes that works for me v3 of all the patches with no newer version +
> v5 of patch 1 and 7 are pretty clean and can go into 3.17 from my pov,
> Tejun can you pick these up for 3.17 please?

Tejun,

I think the following patches can go through your tree without causing
breakage through unresolved dependencies:

	[PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
	[PATCH v3 6/8] ata: ahci_platform: Increase AHCI_MAX_CLKS to 4
	[PATCH v5 7/8] ata: Add support for the Tegra124 SATA controller

Peter, you should probably pick up

	[PATCH v3 4/8] clk: tegra: Enable hardware control of SATA PLL
	[PATCH v3 5/8] clk: tegra: Add SATA clocks to Tegra124 initialization table

and send them off to Mike for 3.17 if there's still time.

Stephen, the rest of the patches would probably best go through the
Tegra tree so that we can handle the dependencies there. I've already
sent out pull requests for 3.17 today, but maybe Arnd and Olof can be
convinced to take one more.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/d894eea2/attachment.sig>
