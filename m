From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 20 Sep 2012 14:30:26 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <505B0C00.5010003@arm.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet>
 <alpine.DEB.2.02.1209201235450.29232@kaball.uk.xensource.com>
 <1348142133.11116.109.camel@hornet>
 <alpine.DEB.2.02.1209201308490.29232@kaball.uk.xensource.com>
 <505B0C00.5010003@arm.com>
Message-ID: <1348147826.26501.47.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 13:28 +0100, Marc Zyngier wrote:
> I think the important thing here is that the memory map is RS1. As this
> is a (very limited) subset of a vexpress A15, it seems to make some sense.

Looking at arch/arm/boot/dts/vexpress-v2m-rs1.dtsi I don't think we
provide anything which is on rs1 though.

The Xen VM environment has only a gic (via a combination of the gic
virtualisation mode for CPU regs and emulation for the distributor), the
arch timers and xenbus (which is the s/w bus which Xen uses to discover
its paravirtualised peripherals).

Currently we provide a very simple output only emulation of UART0,
simply to get the debug output from the decompresser, but we want that
to go away not get baked in.

Ian.
