From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 14:46:18 +0100
Subject: [RFC PATCH 04/11] omap4: SDP: Pass regulator_init_data from DT
In-Reply-To: <1316085727-15023-5-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
Message-ID: <20110915134618.GK7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:52:00PM +0530, Rajendra Nayak wrote:

> +Required properties:
> +- compatible: Must be "regulator","ti,twl-reg";

I'd expect listings for the specific chips too.

> +	xyz-regulator: regulator at 0 {
> +		compatible = "regulator","ti,twl-reg";
> +		ti,reg-id = <37>; /* TWL6030_REG_VAUX1_6030 */

These magic numbers are *very* Linux specific, we should have a better
way of specifying regulators - I'd off the top of my head expect that
the compatible property would identify the regulator.
