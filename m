From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 12:42:58 +0100
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1279073377.404006.432977736300.3.gpush@pororo>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
Message-ID: <20100722114258.GO31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 10:09:37AM +0800, Jeremy Kerr wrote:
> Since we're now using addruart to establish the debug mapping, we can
> remove the io_pg_offst and phys_io members of struct machine_desc.

BTW, it'd probably make more sense to do this as a script, something
like this (untested):

grep -rl MACHINE_START arch/arm | xargs --no-run-if-empty \
  sed -i '/MACHINE_START/,/MACHINE_END/ { /\.(phys_io|io_pg_offst)/d }'

as over time the number of boards, etc, will change, and there's already
context changes with these patches caused by the memblock stuff.
