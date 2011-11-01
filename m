From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Nov 2011 12:40:13 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031221513.GB10576@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<20111031143744.GE29349@mudshark.cambridge.arm.com>
	<20111031221513.GB10576@n2100.arm.linux.org.uk>
Message-ID: <20111101124013.GA15232@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 10:15:13PM +0000, Russell King - ARM Linux wrote:
> I've spent the rest of today trying to get it to do another trivial task -
> adding setup_reboot(mode) to the start of the arch_reset() functions, and
> failed to get it to place the call after local variable declarations.

That sounds difficult. What pattern did you use to skip the declarations?

> I really don't like the way I seem to have to create a rule for each
> possible perturbation of arch_reset (as a function pointer, as a
> function, with local variables, without local variables.)

I was wondering if there was a way to avoid it, but I can't figure it out.

> So far, my experiments with it have just resulted in frustration with
> virtually zero productivity (just one commit to be precise).

I guess the tool is good in cases where you're performing a mindless rename,
but as you pointed out, grep and sed are good for that as well.

Will
