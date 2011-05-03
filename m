From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 May 2011 17:08:45 +0100
Subject: [PATCH v2 2/2] msm: board-8960: Add support for pm8921-regulator
In-Reply-To: <1304118667-19322-1-git-send-email-collinsd@codeaurora.org>
References: <1304118421-18764-1-git-send-email-collinsd@codeaurora.org>
	<1304118667-19322-1-git-send-email-collinsd@codeaurora.org>
Message-ID: <20110503160845.GA1762@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 04:11:07PM -0700, David Collins wrote:

> +PM8921_VREG_CONSUMERS(L1) = {
> +	REGULATOR_SUPPLY("8921_l1",		"reg-debug-consumer"),
> +};

Uh, no.  There's no such thing in mainline and having such a thing
enabled in production builds is crazy.  If such a thing *did* exist it
should still be doing the same thing everything else does and requesting
a fixed supply name.
