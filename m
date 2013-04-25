From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 25 Apr 2013 08:48:26 +0100
Subject: [Xen-devel] [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304221151200.17375@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181237480.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181749260.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191035360.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304191146230.17375@syhkavp.arg>
 <1366388166.29403.2.camel@dagon.hellion.org.uk>
 <alpine.LFD.2.03.1304191223280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191739120.7254@kaball.uk.xensource.com>
 <1366644069.20256.8.camel@zakaz.uk.xensource.com>
 <alpine.LFD.2.03.1304221151200.17375@syhkavp.arg>
Message-ID: <1366876106.20256.399.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-22 at 17:07 +0100, Nicolas Pitre wrote:
> Sure there are ways to screw up Xen support from within this hook, but 
> that can be achieved in many other places.  Will Xen take over every 
> possible hooks in the kernel to prevent that from happening?

In the majority of the other cases we would consider it a bug in Xen for
not exposing these bits of the underlying hardware correctly to dom0,
however the SMP stuff is a bit of a special case for the reasons I
explained earlier which is why we are worrying about it more.

> So please let's not cry wolf needlessly.

Yes, perhaps those worries unfounded at this stage and we should just
run with it and reference this discussion if it turns out to not work
out well in practice.

Ian.
