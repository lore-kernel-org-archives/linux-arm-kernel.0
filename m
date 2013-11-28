From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 28 Nov 2013 18:26:11 +0000
Subject: ACPI
In-Reply-To: <20131126233224.GA21189@srcf.ucam.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131126233224.GA21189@srcf.ucam.org>
Message-ID: <alpine.DEB.2.02.1311281816350.3198@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Matthew Garrett wrote:
> On Tue, Nov 26, 2013 at 05:11:23PM -0600, Matt Sealey wrote:
> 
> > Before stabbing around adding ACPI and then having DT-in-ACPI isn't
> > there a use case for an an ARM Linux kernel actually being a good
> > citizen of UEFI?
> 
> That's work in progress. Patches have been posted and are getting pretty 
> close to being mergeable. You can already run VExpress with UEFI.
> 
> > Having UEFI pass along the DT as a configuration table as well as ACPI
> > tables should be the first order of business. It needn't be
> > DT-specific either - there's no reason that specific configuration
> > table can't define a thousand ways to boot Linux on ARM. But one or
> > two might be better for the sanity of the Linux kernel guys. In fact,
> > because UEFI hands information in the early boot process to the
> > 'application' (being the kernel), and has a very well defined API, it
> > would remove the need for weird out of band stuff like /memreserve/
> > entries in the DT and simplify and make the Linux early boot process
> > more robust and debuggable.
> 
> Passing both is somewhat problematic - if one is supposed to be 
> sufficient, why pass the other? It'd be pretty easy to end up with skew 
> between them, and unless we're clear on what happens in the event of 
> conflicting information then it's going to end badly.

Because I think that it is likely that we'll be able to convince them
that device tree is the right thing to do right now for Linux, Xen,
BSDes, etc.  However they might want to support ACPI in the future, if
nothing else to get other proprietary operating systems running.
So at some point one or more SoCs are going to come out with both.

In that case, I think that we should use the one we know has better
support in the kernel, that at the moment is device tree but in the
future might change.
