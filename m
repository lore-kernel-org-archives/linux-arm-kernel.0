From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Sep 2015 15:46:40 +0200
Subject: [PATCH] ARM: multi_v7: Rebuild default configuration on v4.3-rc1
In-Reply-To: <20150915111257.GR21084@n2100.arm.linux.org.uk>
References: <1442314300-4714-1-git-send-email-thierry.reding@gmail.com>
 <20150915111257.GR21084@n2100.arm.linux.org.uk>
Message-ID: <20150915134639.GC2983@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 12:12:57PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 15, 2015 at 12:51:40PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > It's becoming more and more difficult to update the multi_v7 default
> > configuration because it hasn't been kept in proper order. Typically the
> > workflow to update it would be to do the following:
> 
> If we start regularly updating the defconfigs, it'll annoy Linus,
> because it will create a lot of useless churn, bloating his diffstats
> needlessly.

We are already regularly updating defconfigs. It's a natural thing to do
as new features are implemented.

> Since the defconfig files are not order specific, it would have been
> a good idea if savedefconfig had sorted the options into alphanumeric
> order propr to outputting them.  That would cut down on the useless
> churn, some of which is in your patch.

That would be one solution. But it would also mean that people need to
actually go and check that things are properly sorted. Most of the churn
here doesn't come from the fact that these options have moved in Kconfig
but because people have inserted them in the wrong places. The same
could happen even if savedefconfig sorted options alphanumerically,
because evidently people aren't using the tools properly.

> In fact, most of this patch is pure churn - it's merely moving options
> about.  It provides very little in the way of useful benefit for its
> size.  We need to do better than this.

Yes, I know. In fact I stated that in the commit message. But this
really should be a one-time thing. If we make it easy for people to
properly update the default configuration there will be less churn
further down the road. The changes that end up in multi_v7 default
configuration patches should be what's generated from the defconfig
output. So unless options get removed from Kconfig there should not
be any unnecessary churn subsequently.

As for changes that move options in Kconfig, I think those should be
discouraged. The sane thing to do is order them alphabetically, which
will remove any need to move things around.

> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index 03deb7fb35e8..56775eb9b9cc 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -12,7 +12,6 @@ CONFIG_MODULE_UNLOAD=y
> >  CONFIG_PARTITION_ADVANCED=y
> >  CONFIG_CMDLINE_PARTITION=y
> >  CONFIG_ARCH_VIRT=y
> > -CONFIG_ARCH_ALPINE=y
> >  CONFIG_ARCH_MVEBU=y
> >  CONFIG_MACH_ARMADA_370=y
> >  CONFIG_MACH_ARMADA_375=y
> > @@ -20,14 +19,15 @@ CONFIG_MACH_ARMADA_38X=y
> >  CONFIG_MACH_ARMADA_39X=y
> >  CONFIG_MACH_ARMADA_XP=y
> >  CONFIG_MACH_DOVE=y
> > +CONFIG_ARCH_ALPINE=y
> 
> This option has moved, and the above two changes are therefore nothing
> but churn.
[...]

This and all the below I know already. I went through each and every one
of these options and checked what happened to them. Those listed in the
commit message are the ones that have actually changed. Those not listed
are the ones that have only moved around.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/c773f3f6/attachment.sig>
