From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 05:49:57 -0700
Subject: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <20150624151931.87252315d0e61ddfd55c4724@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-9-git-send-email-kishon@ti.com>
 <20150624145017.9b70a1fba477d8b99ce85702@ti.com>
 <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
 <20150624120938.GG4156@atomide.com>
 <20150624151931.87252315d0e61ddfd55c4724@ti.com>
Message-ID: <20150624124956.GH4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [150624 05:21]:
> On Wed, 24 Jun 2015 05:09:39 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> > 
> > My take is we should only use regmap for the scm_conf area
> > in general.
> 
> +1
> 
> should we get rid of dra7_ctrl_core and dra7_ctrl_general?
> or move them to scm node?

Well at least move them. And if there are clear dedicated
register ranges there claimed only by a single device driver,
then those drivers should be just regular loadable driver
modules doing of_ioremap on the range. And in that case they
can be removed.

We have examples of both in dra7.dtsi, pbias_regulator using
the scm_conf via syscon, and then dra7_pmx_core ioremapping
a dedicated register range. So unless there are other messy
register ranges like the scm_conf area then there should not
be need for other syscon areas.

Regards,

Tony
