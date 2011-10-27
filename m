From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 27 Oct 2011 13:18:07 -0700
Subject: [PATCH 5/6] arm/tegra: pinmux tables and definitions for tegra30
In-Reply-To: <1319561644-6160-6-git-send-email-pdeschrijver@nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49C4@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> Define the pinmuxing and pindrive tables for tegra30. The pinmux table defines
> the available functions for each pinmux group. The pindrive table defines the
> default pullup or pulldowns for each group.

This is almost fine.

You added some new fields to struct tegra_pingroup_desc. This should be
noted in the change description, pointing out that there are new HW
features on Tegra30, but that the driver hasn't been updated to support
them. You probably want to actually add those new fields in a separate
patch before-hand, so you can modify pinmux-tegra20-tables.c to set all
those reg fields to -1, so if/when the driver does support the fields,
Tegra20 will indicate it doesn't support those parameters.

-- 
nvpublic
