From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 1 Feb 2012 12:01:53 +0200
Subject: [PATCH v2 3/8] ARM: tegra: rework Tegra secondary CPU core bringup
In-Reply-To: <20120201075448.GI7399@quad.lixom.net>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-4-git-send-email-pdeschrijver@nvidia.com>
 <20120201075448.GI7399@quad.lixom.net>
Message-ID: <20120201100153.GM24948@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 08:54:48AM +0100, Olof Johansson wrote:
> On Tue, Jan 31, 2012 at 06:40:41PM +0200, Peter De Schrijver wrote:
> 
> > +	.align L1_CACHE_SHIFT
> > +	.type	__tegra_cpu_reset_handler_data, %object
> > +	.globl	__tegra_cpu_reset_handler_data
> > +__tegra_cpu_reset_handler_data:
> > +	.rept	TEGRA_RESET_DATA_SIZE
> > +	.long	0
> > +	.endr
> > +	.size	__tegra_cpu_reset_handler_data, .-tegra_cpu_reset_handler_data
> > +	.align L1_CACHE_SHIFT
> > +
> 
> This doesn't build:
> 
> /tmp/ccPd4Pcj.s: Assembler messages:
> /tmp/ccPd4Pcj.s: Error: .size expression for __tegra_cpu_reset_handler_data does not evaluate to a constant
> 
> Did you mean .-__tegra_cpu_reset_handler_data there?

Yes. It's not used anywhere though :) So I will leave it out in the next version.

Cheers,

Peter.
