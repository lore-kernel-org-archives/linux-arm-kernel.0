From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 3 Jan 2012 10:03:01 -0800
Subject: [PATCH] arm/tegra: Support Tegra30 in decompressor UART setup
In-Reply-To: <1324587719-32731-1-git-send-email-swarren@nvidia.com>
References: <1324587719-32731-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F10E9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Thursday, December 22, 2011 2:02 PM:
> On Tegra20, the UART clock runs at 216MHz, whereas on Tegra30 it runs at
> 408MHz. Modify arch_decomp_setup() to detect Tegra20-vs-Tegra30 at run-
> time, and program the correct divisor.
> 
> This makes uncompressor messages work correctly on Tegra30. This also
> fixes early printk, assuming zImage is used and this setup code runs.

I'll be posting a V2 for this patch soon; I'll rework it to use Tegra's
CHIPID register instead of a random GIC register, which should make the
code a little more future-proof.

-- 
nvpublic
