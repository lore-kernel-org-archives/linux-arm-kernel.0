From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 5 Sep 2014 16:11:31 -0600
Subject: [PATCH v9 04/12] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
In-Reply-To: <CAL_JsqLGa3em5Phct-H0Q=vB5AnA78h19uA=4xi3xHA1rCVq+A@mail.gmail.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-5-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJm6qWNdrJ2F8xddFUj46y42n6hQVu1nkTaA-5Tbg--XQ@mail.gmail.com>
 <20140822130640.GM13147@bart.dudau.co.uk>
 <CAL_JsqLGa3em5Phct-H0Q=vB5AnA78h19uA=4xi3xHA1rCVq+A@mail.gmail.com>
Message-ID: <20140905221131.GJ8080@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 06:27:48PM -0500, Rob Herring wrote:
> On Fri, Aug 22, 2014 at 8:06 AM, Liviu Dudau <liviu@dudau.co.uk> wrote:
> > mips is doing the same thing and I believe is not affected, pci-host-generic.c
> > was adjusting the returned values afterwards so that will not be needed and Lorenzo
> > has a patch for the driver to adapt it to this series anyway.
> >
> > pcie-designware.c also recalculates the io.start and io.end values, so that's fine
> > for now. The only ones that I believe are still affected are pci-tegra.c and
> > pcie-rcar.c for which I will need to provide a patch similar to integrator unless
> > the code gets converted to the new range parsing.
> 
> Well, the latter would be nice, but they certainly have to be fixed.
> Now that I think about it, this needs to be handled in a bisectable
> way. So I think you need to fix all affected platforms in this patch
> rather than a separate patch as you have done.

Yep, I was about to complain that the "ARM: integrator: Correct usage of
of_pci_range_to_resource()" patch needs to be squashed into whatever broke
it, but I see Rob already caught that.

Bjorn
