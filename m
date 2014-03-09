From: ian.campbell@citrix.com (Ian Campbell)
Date: Sun, 9 Mar 2014 02:35:48 +0000
Subject: [stable 3.10.y] Please backport a56a5cf1f2ec "ARM: highbank: avoid
 L2 cache smc calls when PL310 is not present"
Message-ID: <1394332548.13270.74.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[trying again with the correct stable@, sorry for the noise]

Hi stable@,

Please could you backport the changeset in $SUBJECT (and below) to
3.10.y. It went into v3.12-rc1 so I suppose you might also consider it
for other stable branches before then which are still live.

I thought it might require 0b53c11d533a "ARM: move outer_cache
declaration out of ifdef" but Kconfig seems to be such that it isn't
needed in practice.

Cheers,
Ian.


commit a56a5cf1f2ec895599eace0ac6eba1e4a489e4bf
Author: Rob Herring <rob.herring@calxeda.com>
Date:   Sat Aug 17 20:10:28 2013 -0500

    ARM: highbank: avoid L2 cache smc calls when PL310 is not present
    
    While Midway firmware handles L2 smc calls as nops, the custom smc calls
    present a problem when running virtualized Midway guest. They aren't
    needed so just avoid calling them.
    
    In the process, cleanup the L2X0 ifdefs and use IS_ENABLED instead.
    
    Signed-off-by: Rob Herring <rob.herring@calxeda.com>
