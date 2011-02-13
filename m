From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 12 Feb 2011 18:17:42 -0700 (MST)
Subject: [PATCH v2 0/7] clock/dpll autoidle support
In-Reply-To: <1297329400-5936-1-git-send-email-rnayak@ti.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1102121813440.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> OMAP has various clock nodes and dpll's
> which support hardware level autoidle.
> Enabling hardware level autoidle provides
> better power savings without much software
> intervention.
> 
> This series does the following to help enable
> hardware level autoidling using clock framework
> for some of these nodes on OMAP3 and OMAP4
> 
> -1- Adds support for providing function pointers
> for enabling/disabling autoidle in clkops
> -2- Populates these in clkops for all OMAP3/4 dplls
> -3- Enables all dpll autoidle late in boot on OMAP3 and OMAP4
> -4- Adds support for mx postdivider autoidle (present
> only on OMAP4) and enables it late in OMAP4 boot

I've reviewed and commented on all of these, asked a few questions, made a 
few changes, and queued the results for 2.6.39 in two branches of 
git://git.pwsan.com/linux-2.6:

clk_a_2.6.39 (for the autoidle-independent fixes)
clk_autoidle_a_2.6.39 (for the autoidle-specific code and data changes)

Both branches have been added to the 'integration-2.6.39' branch of 
git://git.pwsan.com/linux-integration, and are available as part of the 
tag "integration-2.6.39-20110212-004".


thanks,

- Paul
