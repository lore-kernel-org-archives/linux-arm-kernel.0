From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Oct 2011 20:48:48 +0800
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4E97A601.1020005@gmail.com>
References: <4E97A601.1020005@gmail.com>
Message-ID: <20111020124847.GG32007@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 10:01:21PM -0500, Rob Herring wrote:
> Arnd,
> 
> Please pull GIC device tree support. This is the first of 2 pull
> requests. You can ignore this one if there are no other dependencies on
> GIC DT support.
> 
> This is based on rmk's for-next branch and v3.1-rc9. rc9 was needed for
> this dependency:
> 
> commit eef24afb28561a5a9f4be8f8da97735b7e6a826f
> irq: Fix check for already initialized irq_domain in irq_domain_add
> 
> Regards,
> Rob
> 
> The following changes since commit dd5e9eb0d051606ee3eda0c30222429c74e23f00:
> 
>   Merge commit 'v3.1-rc9' into upstream/base (2011-10-13 20:30:42 -0500)
> 
> are available in the git repository at:
> 
>   http://sources.calxeda.com/git/kernel/linux.git gic-dt
> 
> Rob Herring (4):
>       of/irq: introduce of_irq_init
>       irq: support domains with non-zero hwirq base
>       ARM: gic: add irq_domain support
>       ARM: gic: add OF based initialization
> 
Hi Rob,

Russell is going to take Marc Zyngier's ppi series for v3.2 merge
window.  I just noticed your patch 'ARM: gic: add irq_domain support'
gets some conflict with Marc's series on function gic_dist_init(),
which is not so obvious to resolve.  You may want to take a look. 

Regards,
Shawn
