From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 11:23:56 +0200
Subject: [PATCH v4 2/4] arm64: Remove the clock and PHY reference from the
 APM X-Gene SoC AHCI SATA Host controller dts node.
In-Reply-To: <1406616892-30273-3-git-send-email-stripathi@apm.com>
References: <1406616892-30273-1-git-send-email-stripathi@apm.com>
 <1406616892-30273-3-git-send-email-stripathi@apm.com>
Message-ID: <4479076.DG8ITD3De2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 12:24:50 Suman Tripathi wrote:
> This patch removes all clocks and PHY references from the APM X-Gene
> SoC AHCI SATA host controller and PHY DTS nodes. The clock and PHY
> are no longer needed as they are handled by the firmware. By removing
> only the reference is not enough as any un-used clock entry will get
> disabled by the clock framework.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> 

This will break booting on older firmware versions I guess, and
it does not confirm to the binding that lists the phy and clock
properties as "required".

It doesn't sound like a good idea to apply it.

	Arnd
