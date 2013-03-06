From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 6 Mar 2013 10:14:01 +0200
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <513624AA.4090207@wwwdotorg.org>
References: <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <5130E757.6090500@wwwdotorg.org>
 <20130304063436.GB27241@tbergstrom-lnx.Nvidia.com>
 <20130304091600.GC27241@tbergstrom-lnx.Nvidia.com>
 <5134D50B.8060001@wwwdotorg.org>
 <20130305074047.GH27241@tbergstrom-lnx.Nvidia.com>
 <513624AA.4090207@wwwdotorg.org>
Message-ID: <20130306081401.GN27241@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 06:00:26PM +0100, Stephen Warren wrote:
> On 03/05/2013 12:40 AM, Peter De Schrijver wrote:
> > On Mon, Mar 04, 2013 at 06:08:27PM +0100, Stephen Warren wrote:
> >> On 03/04/2013 02:16 AM, Peter De Schrijver wrote:
> >>> On Mon, Mar 04, 2013 at 07:34:36AM +0100, Peter De Schrijver wrote:
> >>>> On Fri, Mar 01, 2013 at 06:37:27PM +0100, Stephen Warren wrote:
> >>>>

> > Unfortunately we can't write to the diag register if we are in non-secure
> > mode. So unless we never want to support running in non-secure mode, we will
> > need to make the distinction somehow and use a different method for non-secure
> > mode. Or assume the secure OS has applied the WARs.
> 
> Yes. The secure OS really has to have enabled the appropriate WARs
> before jumping into the kernel's reset vector. If/when we support the
> upstream kernel running on Tegra in non-secure mode, the plan was to use
> a Tegra-specific mechanism to detect secure-vs-normal mode in the Tegra
> reset vector, and skip the application of secure-only WARs based on that.
> 

Ok. If we have such a mechanism, that works too ofcourse. I was under the
impression there is no way to know if you're running in secure mode
or non-secure mode.

> > I'm afraid existing secure
> > OS implementations for Tegra don't work that way though. They just offer an
> > SMC which allows the kernel to read and write the diag register.
> 
> I had a downstream discussion about this, and Bo Yan said someone had
> verified this was working correctly for at least for some WARs on some
> CPUs and for the one particular secure OS we're using.
> 

Ok. That should be good enough indeed.

> I think it's reasonable to require a fixed secure OS (i.e. one that
> correctly enables any required WARs) be used with any upstream kernel,
> since running in normal world would be a new feature that we'd be
> supporting.
> 

Sure. But it would be nice if we can support existing systems which have a
secure OS we can't change.

> An SMC to read/write the diag register sounds the opposite of secure...
> 

GP OMAP devices provide this, but then again they aren't meant to be secure
even though they run linx in non-secure mode...

Cheers,

Peter.
