From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 26 Aug 2015 13:10:03 +0200
Subject: [PATCH 1/1] ARM: imx35: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1439277502-16917-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1439277502-16917-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <4874555.Wi6XRVID6f@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 August 2015 09:18:22, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx35_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksources/timer-imx-gpt.c).
> This arranges the initialization code similar to clk-imx27.c

Any feedback on this?

Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein at systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
