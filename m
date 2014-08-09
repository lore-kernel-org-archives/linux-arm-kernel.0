From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 9 Aug 2014 22:00:34 +0200
Subject: [PATCH v6 2/2] arm64: Remove the clock and PHY reference from the
 APM X-Gene SoC AHCI SATA Host controller dts node.
In-Reply-To: <1407514466-25312-3-git-send-email-stripathi@apm.com>
References: <1407514466-25312-1-git-send-email-stripathi@apm.com>
 <1407514466-25312-3-git-send-email-stripathi@apm.com>
Message-ID: <201408092200.34651.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 August 2014, Suman Tripathi wrote:
> This patch removes all clocks and PHY references from the APM X-Gene
> SoC AHCI SATA host controller and PHY DTS nodes. The clock and PHY
> are no longer needed as they are handled by the firmware. By removing
> only the reference is not enough as any un-used clock entry will get
> disabled by the clock framework. This patch also updates the APM X-Gene
> SOC AHCI SATA Host controller clock and PHY bindings as optional
> properties.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  .../devicetree/bindings/ata/apm-xgene.txt          | 10 +--
>  arch/arm64/boot/dts/apm-storm.dtsi                 | 93 ----------------------
>  2 files changed, 5 insertions(+), 98 deletions(-)
> 

What is the upgrade path here? It sounds like this will still break new kernels
running on old firmware if you also upgrade the dtb file. You write in the
introductory email that this will work with old firmware as well, but I don't
understand how.

How about modifying the dtb at boot time by the firmware according to the
requirements of the firmware itself?

	Arnd
