From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 13 Sep 2012 12:19:06 +0100
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <20120913102938.GB2470@linaro.org>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <503BFCD8.5090804@gmail.com>
 <alpine.DEB.2.02.1208281823270.15568@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
 <50514634.3080303@gmail.com> <20120913102938.GB2470@linaro.org>
Message-ID: <alpine.DEB.2.02.1209131215360.15568@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Sep 2012, Dave Martin wrote:
> Do you think it's feasible to standardise on some interoperable ABI for
> kvm and Xen?  This sounds pretty optimistic, but I'm not aware of all
> the technicalities, or what possible third-party hypervisors are out
> there.
> 
> If we could do it, it would be good.  But I have my doubts about the
> feasibility and the benefits.  If different hypervisors are significantly
> imcompatible, then having a common low-level ABI doesn't help all that
> much.

It is not really possible because each hypervisor offers a different set
of hypercalls and has a different calling convention, so there is very
little we can do to unify them.

For example many of the current Xen hypercalls are to deal with the grant
table and event channels, that are Xen specific concepts completely
missing in KVM.
