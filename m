From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Jun 2012 10:04:49 +0200
Subject: RFC: [PATCH] ARM: Kirkwood: clk_register_gate_fn: add fn
 assignment
In-Reply-To: <4FDEDEAE.30502@blackshift.org>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
Message-ID: <20120618080449.GK4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks, this should go into 3.5.

Yes.

> BTW: I'm hacking on the dove clock support, I noticed that dove can make
> use of the same ethernet and pci phy shutdown functions than kirkwood.
> What about moving kirkwood_register_gate_fn and subfunctions to plat-orion?

Please coordinate with Sebastian.hesselbarth
<Sebastian.hesselbarth@googlemail.com> He has done some work in the
same area.

I would probably move the kirkwood_register_gate_fn() stuff to
drivers/clk. Also, the pcie and sata shutdown functions need
generalizing if they are the be re-used. The address map on Dove is
different to Kirkwood, so the registers are in different places.

	  Andrew
