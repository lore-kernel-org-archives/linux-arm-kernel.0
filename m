From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:04:33 -0600
Subject: [PATCH v5 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1401281677-32110-4-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <1401281677-32110-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <538784C1.6000504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.

> diff --git a/Documentation/ABI/testing/sysfs-driver-tegra-fuse b/Documentation/ABI/testing/sysfs-driver-tegra-fuse

> +Description:	read-only access to the efuses on Tegra20, Tegra30, Tegra114
> +		and Tegra124 SoC's from NVIDIA. The efuses contain write once
> +		data programmed at the factory. The data is layed out in 32bit
> +		words in LSB first formnat. The number of valid bits depends

s/formnat/format/

> +		on the word and the SoC. The mapping is as follows:
> +
> +		For Tegra20:
> +		Word 0 - 1    : bit 0
> +		Word 2        : unused
> +		Word 3        : bits 0 - 31
> +		Word 4        : bits 0 - 7

Do we really need these long tables that indicate which bits are used?
As I mentioned before, when I asked for documentation of the format of
these files, all I wanted was a brief not indicating that the data was
binary, and that each bit potentially represents a fuse... Either we
should leave it at that, or actually document what each bit represents,
which would hopefully be a pointless duplication of the TRM.
