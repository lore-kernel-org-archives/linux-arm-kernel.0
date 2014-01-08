From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 16:06:15 +0000
Subject: [RFC 12/18] clk: versatile: Split config options for sp810 and
 vexpress_osc
In-Reply-To: <20131223200538.25490.67340@quantum>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-13-git-send-email-pawel.moll@arm.com>
 <20131223200538.25490.67340@quantum>
Message-ID: <1389197175.23721.24.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-23 at 20:05 +0000, Mike Turquette wrote:
> Quoting Pawel Moll (2013-12-23 08:23:44)
> > Move the Kconfig entry for Versatile (& Express) clock drivers
> > into a separate file and add individual options for sp810
> > and vexpress_osc drivers, as they are optional in some
> > configurations and may have separate dependencies.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> 
> Is there a reason to continue to expose these as user-visible config
> options? I guess that with Device Tree we can just include clock nodes
> (or not) for boards that use these clocks (or do not use them).
>
> And it seems for many configurations COMMON_CLK_VERSATILE is always
> selected, so what is the point of the other two sub-options?

It's mostly for arm64, where all the bits and pieces are individually
selected (and SP810 is not present in some vexpress configurations).

Pawe?
