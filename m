From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 11:32:33 +0000
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <510BA728.4060300@ti.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com>
Message-ID: <20130201113233.GJ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 04:59:44PM +0530, Santosh Shilimkar wrote:
> Now since we are moving the code under common place, probably we should
> update this a function a bit so that it invalidates the CPU cache till
> line of unification. Just to be consistent with other flush API.

Hmm.  Do you really want a CPU being brought up to do that to the PoU,
every time that it is brought up?  I thought you wanted to get rid of
that kind of stuff from the hotplug paths so that a CPU being brought
up/taken down doesn't affect the caches for the other CPUs within the
inner sharable domain.
