From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 22:46:49 +0000
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <AANLkTi=UBfBp-VOQ=n_a4sjA9v_dhcv-rXcXiE6zrf23@mail.gmail.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
	<1295908604.29639.62.camel@c-dwalke-linux.qualcomm.com>
	<8yaei81kjlc.fsf@huya.qualcomm.com>
	<AANLkTi=UBfBp-VOQ=n_a4sjA9v_dhcv-rXcXiE6zrf23@mail.gmail.com>
Message-ID: <20110126224649.GC7323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 02:12:59PM -0800, Dima Zavin wrote:
> To be honest I don't understand why you would want to do this at
> runtime. You cannot select multiple SoCs in the kernel build anyway,
> nor would you want to. Trying to have same kernel to boot on ARM v6
> and ARM v7 would already be freaky enough.

Wrong.  We already have that working with mainline plus some additional
patches.  OMAP people want it, and it's precisely the direction which
quite a number of people within the ARM community want to move.

Building an ARM kernel to cover multiple different CPU types is something
which has always been possible, although with SMP and a few other things
it's become a little harder.  Not impossible though, and not impossible
to do efficiently either.
