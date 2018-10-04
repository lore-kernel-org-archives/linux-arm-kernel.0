From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 4 Oct 2018 18:21:09 +0100
Subject: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
In-Reply-To: <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan>
 <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com>
 <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
Message-ID: <20181004172109.GA16878@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:

[...]

> > > I don't see any dependency there, so I'll queue up the 1-3 in
> > > pm-domains and the 4-6 in pm-cpuidle.
> >
> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
> > (DT bindings and related parsing code) with no user in the kernel; we
> > may still want to tweak them, in particular PSCI DT bindings.
> 
> My impression was that 4-6 have been agreed on due to the ACKs they
> carry.  I'll drop them if that's not the case.

I have not expressed myself correctly: they have been agreed (even
though as I said they may require some tweaking) but I see no urgency
of merging them in v4.20 since they have no user. They contain DT
bindings, that create ABI/legacy, I think it is better to have code
that uses them in the kernel before merging them and creating a
dependency that is not needed.

> > Likewise, it makes no sense to merge patches 7-8 without the rest of
> > the PSCI patches.
> 
> OK
> 
> I'll let the ARM camp sort out the PSCI material then.

We will do.

Thanks,
Lorenzo
