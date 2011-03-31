From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Mar 2011 09:10:17 +0900
Subject: [PATCH 2/2] msm: board-8960: Add support for pm8921-regulator
In-Reply-To: <1301523466-6054-1-git-send-email-collinsd@codeaurora.org>
References: <1301523361-5982-1-git-send-email-collinsd@codeaurora.org>
	<1301523466-6054-1-git-send-email-collinsd@codeaurora.org>
Message-ID: <20110331001016.GB21487@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 03:17:46PM -0700, David Collins wrote:

> +VREG_CONSUMERS(L1) = {
> +	REGULATOR_SUPPLY("8921_l1",		NULL),
> +};

All these supplies named after the regulator name should be removed.
Supplies define the mapping from the regulators on the board to the
supplies on the devices on the board, if any driver is requesting a
specific regulator name then there's an abstraction issue which means
that these should be redundant.

In general if you've got a supply that doesn't have a dev_name
associated with it something is wrong.
