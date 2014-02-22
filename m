From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Feb 2014 10:26:17 +0000
Subject: [PATCH RFC v1 1/3] ARM: Add irq disabled version of soft_restart.
In-Reply-To: <1392774729-3235-2-git-send-email-sebastian.capella@linaro.org>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140222102616.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 05:52:07PM -0800, Sebastian Capella wrote:
> From: Russ Dill <Russ.Dill@ti.com>
> 
> This adds the ability to run soft_restart with local_irq/fiq_disable
> already called. This is helpful for the hibernation code paths.

I'd rather keep this simple.  There's no problem with calling soft_restart
with interrupts already disabled.  local_irq_disable()/local_fiq_disable()
there should be harmless.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
