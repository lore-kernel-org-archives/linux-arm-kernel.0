From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 3 May 2011 00:06:43 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DBF2A9E.5010201@bluewatersys.com>
References: <20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
	<20110502202449.GB13724@game.jcrosoft.org>
	<4DBF164C.7030900@bluewatersys.com>
	<20110502205154.GC13724@game.jcrosoft.org>
	<4DBF21B0.5060202@bluewatersys.com>
	<20110502212920.GD13724@game.jcrosoft.org>
	<4DBF2A9E.5010201@bluewatersys.com>
Message-ID: <20110502220643.GF13724@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The boards are different. They have a common base pinout, but their
> peripheral pinouts are different. Multiple mach-types cost nothing and
> are a well understood part of ARM Linux. Your proposed cpu detection
> code adds complexity and code, and has zero benefit for any of the
> boards currently in mainline.
So we will do an other re-architecture in the few months
Linus is going to said no
We do need to stop to do changset again and again just because we don't solve
the issue at the beginning
> 
> Carrier boards are a separate issue, and there has not really been a
> consensus on what the best way to solve the issue of combining system on
> modules (SoMs) with carrier boards. Should the mach-type belong to the
> SoM or to the system as a whole (SoM + carrier board)? There is
> currently a push to get ARM to consolidate on things rather than each
> sub-architecture doing things its own way.
Sorry but cpu detection is soc specific
hardcode it via machine ID is not good
> So if you want a way to
> differentiate carrier boards, then I think that needs to be discussed
> with other sub-architecture maintainers so that a common approach can be
> devised. I don't think that cpu detection is a robust solution. Device
> tree is probably the long-term solution to this.
> 
> In short, your soc detection patches add additional complexity, but have
> zero effect on the possibility of supporting all of the current mainline
> at91 platforms in a single kernel. We need to fix the other barriers to
> this support first (such as the work Andrew Victor is doing).
Which can be also simply be knowning the CPU you are on

If you take a look on other arch they do cpu detection and there is nothing
wrong about it. And device tree is not the solution to everything
If you have work on it on PowerPC or other arch, you will known that it's also
have its own issue
such as bootloader/kernel incompatibilty
so detect cpu type at runtine in the kernel is good to do not realy blindly on
DT

Best Regards,
J.
