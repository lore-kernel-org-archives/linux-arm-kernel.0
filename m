From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 8 May 2018 08:29:30 -0500
Subject: [PATCH v2 08/10] PCI: Deprecate of_pci_get_host_bridge_resources()
In-Reply-To: <b13dd4b5-61c4-3acb-c194-3e448cb8b3d2@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
 <20180502123923.GA10783@infradead.org>
 <b13dd4b5-61c4-3acb-c194-3e448cb8b3d2@siemens.com>
Message-ID: <20180508132930.GL161390@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 09:53:58AM +0200, Jan Kiszka wrote:
> On 2018-05-02 14:39, Christoph Hellwig wrote:
> > On Mon, Apr 30, 2018 at 07:48:42AM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> There are no in-tree users remaining, all are converted to the managed
> >> variant. And it is unlikely that any out-of-tree user got the resource
> >> management right as well. So deprecate the interface and push users to
> >> the managed version instead.
> >>
> >> To avoid raising a warning when exporting a deprecated symbol, wrap the
> >> API with an inline and export an internal name.
> > 
> > Don't deprecated it, just remove it.
> 
> I see a clear favorite now: consider this patch obsolete. I'll send a
> separate removal patch, or a v3 of this series when otherwise needed.

Can you just send an update to this patch to remove it?  I've got these on
a branch and will just update my branch with the removal.

Then I'll coordinate with Lorenzo and make sure the dependency issue is
resolved.
