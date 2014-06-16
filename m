From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 19:26:45 +0100
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <8028011.DbLMpGku5b@wuerfel>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <5537408.I9tiuCA96J@wuerfel> <20140616164517.GY16758@arm.com>
 <8028011.DbLMpGku5b@wuerfel>
Message-ID: <20140616182645.GD16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 06:25:35PM +0100, Arnd Bergmann wrote:
> On Monday 16 June 2014 17:45:17 Will Deacon wrote:
> > On Mon, Jun 16, 2014 at 05:42:10PM +0100, Arnd Bergmann wrote:
> > > We have to migrate the driver to the new binding anyway, it may be
> > > a bit painful, but there are not really any users yet so there
> > > is a chance we can remove the nonstandard code at some point,
> > > perhaps in a few years.
> > 
> > The only way I see this working is if we kill the existing binding and move
> > exclusively to the new one. I'm actually ok with that (we have no in-tree
> > users), but it needs to happen ASAP in my opinion, otherwise we increase the
> > window where the old binding can be adopted.
> 
> I agree. I was hoping to get the generic binding ready for 3.16, but that
> didn't happen. Maybe we can add a small patch to the binding to explain
> that it will change in the future.

Perhaps, but saying "don't use this" isn't much better than just ripping out
the support altogether. That said, I won't object to a patch adding a big
fat warning to the current binding docs if it dissuades people from using
what we currently have.

> > Note that the next version of the ARM SMMU (v3) is considerably different to
> > the current architecture, so a new driver (using the new bindings) will be
> > required.
> > 
> > This actually opens a wider question: if we don't have an in-tree user for a
> > device-tree binding, do we consider that binding to be unused?
> 
> Not in general, but often. We don't require dts files to be in the kernel,
> so we have to apply a bit of common sense. If anyone knows of out-of-tree
> users of the binding that are actually working with upstream kernels,
> we need a migration path. Anything that also requires out-of-tree kernel
> patches however is something we don't have to worry about.

Ok. If Thierry's binding gets in for 3.17, then I'll try to convert the ARM
SMMU driver over to it for 3.18 providing we don't grow any in-tree users of
the existing binding in the meantime (or 3.17 depending on how early it gets
queued).

Sound fair?

Will
