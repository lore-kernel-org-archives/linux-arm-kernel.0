From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 13:49:32 +0200
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <6270066.3Z82jfEmEA@wuerfel>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <8028011.DbLMpGku5b@wuerfel> <20140616182645.GD16758@arm.com>
 <6270066.3Z82jfEmEA@wuerfel>
Message-ID: <20140617114928.GA18816@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 09:14:41AM +0200, Arnd Bergmann wrote:
> On Monday 16 June 2014 19:26:45 Will Deacon wrote:
> > On Mon, Jun 16, 2014 at 06:25:35PM +0100, Arnd Bergmann wrote:
> > > On Monday 16 June 2014 17:45:17 Will Deacon wrote:
> > > > On Mon, Jun 16, 2014 at 05:42:10PM +0100, Arnd Bergmann wrote:
> > > > > We have to migrate the driver to the new binding anyway, it may be
> > > > > a bit painful, but there are not really any users yet so there
> > > > > is a chance we can remove the nonstandard code at some point,
> > > > > perhaps in a few years.
> > > > 
> > > > The only way I see this working is if we kill the existing binding and move
> > > > exclusively to the new one. I'm actually ok with that (we have no in-tree
> > > > users), but it needs to happen ASAP in my opinion, otherwise we increase the
> > > > window where the old binding can be adopted.
> > > 
> > > I agree. I was hoping to get the generic binding ready for 3.16, but that
> > > didn't happen. Maybe we can add a small patch to the binding to explain
> > > that it will change in the future.
> > 
> > Perhaps, but saying "don't use this" isn't much better than just ripping out
> > the support altogether. That said, I won't object to a patch adding a big
> > fat warning to the current binding docs if it dissuades people from using
> > what we currently have.
> 
> Ok.
> 
> > > > Note that the next version of the ARM SMMU (v3) is considerably different to
> > > > the current architecture, so a new driver (using the new bindings) will be
> > > > required.
> > > > 
> > > > This actually opens a wider question: if we don't have an in-tree user for a
> > > > device-tree binding, do we consider that binding to be unused?
> > > 
> > > Not in general, but often. We don't require dts files to be in the kernel,
> > > so we have to apply a bit of common sense. If anyone knows of out-of-tree
> > > users of the binding that are actually working with upstream kernels,
> > > we need a migration path. Anything that also requires out-of-tree kernel
> > > patches however is something we don't have to worry about.
> > 
> > Ok. If Thierry's binding gets in for 3.17, then I'll try to convert the ARM
> > SMMU driver over to it for 3.18 providing we don't grow any in-tree users of
> > the existing binding in the meantime (or 3.17 depending on how early it gets
> > queued).
> > 
> > Sound fair?
> 
> Sounds good. Let's make sure we get this done quickly now. I think there
> isn't much controversy left with the binding, though this particular one
> has been tough in the past.

I'm not sure how much else needs to be discussed for the generic binding
since there seemed to be various degrees of agreement and then somebody
came up with another use-case where the current proposal wouldn't work.
I always thought that if we kept things completely generic (that is,
leave it completely up to the device-specific binding what the specifier
is used for), then there shouldn't be much controversy at all and the
specifics could be handled in drivers where it makes the most sense.

That said, I'll be mostly away from a computer this week, so I expect to
only be able to get back to this sometime next week at the earliest.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/c7cc4e55/attachment.sig>
