From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Jul 2013 17:10:01 -0600
Subject: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
In-Reply-To: <20130701.112446.119298599375396428.hdoyu@nvidia.com>
References: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com><20130626105216.GL27083@manwe>
 <20130701.112446.119298599375396428.hdoyu@nvidia.com>
Message-ID: <51D20C49.2020802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 02:24 AM, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 12:52:17 +0200:
>> On Wed, Jun 26, 2013 at 12:28:09PM +0300, Hiroshi Doyu wrote:
>>> This is a bitmap that indicates which HardWare Accelerators(HWA) are
>>> supported on Tegra114 SoC.
...
>> It seems like an nvidia,tegra114-smmu.txt file is missing from the
>> Documentation/devicetree/bindings/iommu directory.
> 
> All difference between T30 and T114 is now provided from DT. They have
> all same entries but only those values are different.
> 
> Do we still need a copy of nvidia,tegra30-smmu.txt for t114 or is just
> tweaking nvidia,tegra30-smmu.txt for t114 enough?

If the two HW are identical (at least as far as bindings), the existing
nvidia,tegra30-smmu.txt should be enough. We probably should at least
update it to list the additional supported compatible value though,
especially if the driver interprets the two compatible values in a
different way (e.g. there are HW differences, but they don't affect the
binding definition).
