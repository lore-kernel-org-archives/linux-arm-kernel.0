From: davem@davemloft.net (David Miller)
Date: Sat, 26 Oct 2013 01:45:45 -0400 (EDT)
Subject: [PATCH RFC v2 3/4] net: mvmdio: slight optimisation of
 orion_mdio_write
In-Reply-To: <6d044f3760cd506a325d5aab1199131ade96d632.1382637156.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
 <cover.1382637156.git.leigh@solinno.co.uk>
 <6d044f3760cd506a325d5aab1199131ade96d632.1382637156.git.leigh@solinno.co.uk>
Message-ID: <20131026.014545.318441640809669571.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leigh Brown <leigh@solinno.co.uk>
Date: Thu, 24 Oct 2013 19:09:33 +0100

> Make only a single call to mutex_unlock in orion_mdio_write.
> 
> Signed-off-by: Leigh Brown <leigh@solinno.co.uk>

You patch does more than what you're talking about here in your
commit message.  In particular you're also changing the interpretation
of the orion_mdio_wait_ready() return value by changing the test
from < 0 to != 0.

Even if that is a legitimate change:

1) You're not describing it in the commit message@all.

2) It's a logically separate change, so should go into a completely
   separate patch.
