From: carlo@caione.org (Carlo Caione)
Date: Thu, 9 Jun 2016 17:23:47 +0200
Subject: [PATCH v3 2/2] arm64: dts: Fix broken architected timer
 interrupt trigger
In-Reply-To: <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160609152347.GA9477@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/16 18:56, Marc Zyngier wrote:
> The ARM architected timer specification mandates that the interrupt
> associated with each timer is level triggered (which corresponds to
> the "counter >= comparator" condition).
> 
> A number of DTs are being remarkably creative, declaring the interrupt
> to be edge triggered. A quick look at the TRM for the corresponding ARM
> CPUs clearly shows that this is wrong, and I've corrected those.
> For non-ARM designs (and in the absence of a publicly available TRM),
> I've made them active low as well, which can't be completely wrong
> as the GIC cannot disinguish between level low and level high.
> 
> The respective maintainers are of course welcome to prove me wrong.
> 
> While I was at it, I took the liberty to fix a couple of related issue,
> such as some spurious affinity bits on ThunderX, and their complete
> absence on ls1043a (both of which seem to be related to copy-pasting
> from other DTs).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

For meson-gxbb.dtsi:

Acked-by: Carlo Caione <carlo@endlessm.com>

-- 
Carlo Caione
