From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Feb 2011 15:07:38 +0530
Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
	OMAP2xxx
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Message-ID: <b83b1717e83fc907a1caf589cc53badf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
[mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf
> Of Paul Walmsley
> Sent: Wednesday, February 16, 2011 12:23 PM
> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
OMAP2xxx
>
> Hello,
>
> This patch series adds clock framework-controlled autoidle support for
> the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
> direct register writes in the PM code to enable clock autoidle have been
> removed.
>
> This series also ensures that all clock autoidle is disabled during
> boot and only re-enabled if CONFIG_PM is enabled.

This does not seem to be the case. Maybe something like the
below patch is what is missing..

---
