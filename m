From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Mar 2010 08:32:23 -0700
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <20100319085403.GB8451@n2100.arm.linux.org.uk>
References: <20100317175731.GE2900@atomide.com>
	<1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
	<20100317191114.GH2900@atomide.com>
	<1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
	<20100318170021.GN2900@atomide.com>
	<20100319013521.GP2900@atomide.com>
	<20100319034645.GG14108@shareable.org>
	<20100319085403.GB8451@n2100.arm.linux.org.uk>
Message-ID: <20100319153223.GR2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100319 01:50]:
> On Fri, Mar 19, 2010 at 03:46:45AM +0000, Jamie Lokier wrote:
> > I'm thinking, why not an alternative() macro like on x86, which is a
> > very nice way to describe run-time patches of one or a few instructions
> > which depend on arch feature bits.
> 
> Having XIP support prevents that kind of thing.

How about we store the HWCAP_TLS flag into 0xffff0ff4 for
__kuser_get_tls? That way the userspace won't be able to set
it.

Tony
