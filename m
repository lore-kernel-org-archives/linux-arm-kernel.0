From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Feb 2010 11:32:49 +0000
Subject: [RFC PATCH v2 1/2] ARM: VFP: add support to sync the VFP state
	of the current thread
In-Reply-To: <20100206112048.GD1923@n2100.arm.linux.org.uk>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
	<20100206103230.GC1923@n2100.arm.linux.org.uk>
	<20100206112048.GD1923@n2100.arm.linux.org.uk>
Message-ID: <20100206113249.GA17198@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2010 at 11:20:48AM +0000, Russell King - ARM Linux wrote:
> +		/*
> +		 * Save the last VFP state on this CPU.
> +		 */
> +		fmxr(FPEXC, fpexc | FPEXC_EN);
> +		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
> +		fmxr(FPEXC, fpexc);

Erm, slight correction here:

+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
