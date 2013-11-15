From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 15 Nov 2013 15:44:17 +0000
Subject: [PATCH v4] dt: update PSCI binding documentation for v0.2
In-Reply-To: <5286401E.5090400@gmail.com>
References: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
 <alpine.DEB.2.02.1311151447590.4714@kaball.uk.xensource.com>
 <5286401E.5090400@gmail.com>
Message-ID: <alpine.DEB.2.02.1311151540550.4714@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Nov 2013, Rob Herring wrote:
> On 11/15/2013 08:48 AM, Stefano Stabellini wrote:
> > On Thu, 19 Sep 2013, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> The PSCI spec from ARM has been updated to 0.2 version. Update the
> >> binding document to reflect the spec changes. For the binding, the
> >> major changes are the addition of psci_version, affinity_info,
> >> migrate_info_type, migrate_info_up_cpu, system_reset and system_off
> >> functions. The recommended function ID numbering has also changed.
> >>
> >> This update also defines 32 and 64 bit calling conventions. The calling
> >> convention is defined on a per function ID basis.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> Cc: Dave Martin <Dave.Martin@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ian Campbell <Ian.Campbell@citrix.com>
> >> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> >> Cc: Christoffer Dall <christoffer.dall@linaro.org>,
> >> Cc: Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
> >> Cc: Matt Sealey <neko@bakuhatsu.net>
> >> Cc: devicetree at vger.kernel.org
> > 
> > Rob,
> > I noticed that this patch hasn't gone upstream yet. Is the interface
> > still under discussion?
> > I am thinking of implementing the Xen side of it.
> 
> Since we can't seem to agree on how to extend the binding, I plan to go
> back to something more simple which is simply adding 2 optional
> properties to the existing "arm,psci" binding. This would be enough to
> meet the needs of KVM, Xen, and highbank. A future binding can deal with
> the whole 32 and 64-bit calling convention issue.

OK. TBH Xen doesn't need anything more than what is already specified in
"arm,psci".
However it would have been nice to fully implement the latest PSCI spec.
