From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Sep 2018 17:33:01 +0100
Subject: [PATCH] PCI: remove unnecessary check of device_type == pci
In-Reply-To: <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
References: <20180829183440.13601-1-robh@kernel.org>
 <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
 <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
Message-ID: <20180919163301.GA21474@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 12:05:40PM -0700, Rob Herring wrote:
> On Thu, Sep 13, 2018 at 7:51 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> > > PCI host drivers have already matched on compatible strings, so checking
> > > device_type is redundant. Also, device_type is considered deprecated for
> > > FDT though we've still been requiring it for PCI hosts as it is useful
> > > for finding PCI buses.
> >
> > Hi Rob,
> >
> > I have no problem with the patch per-se, I can't parse though the second
> > paragraph, in particular what you mean by "useful for finding PCI
> > buses".
> 
> Device_type is the only generic way we can identify PCI buses which is
> useful for dtc for example to do PCI binding checks. Maybe we can use
> the node name which is what I'm doing for cpu nodes, but we've been
> less consistent about that for PCI.
> 
> >
> > What about the corresponding dts files ? I suspect we had better leave
> > them alone lest we can trigger regressions with new dts and older
> > kernels.
> 
> Yes. it will take some time before we can remove from dts files. Or
> maybe only new ones change.

OK, thanks. What about PCI host controllers bindings ? I assume we leave
the bindings (that enforce device_type) unchanged too.

If Will and Michal have no objections I will queue this patch as-is
for v4.20.

Thanks,
Lorenzo
