From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 24 Apr 2013 10:56:28 +0300
Subject: [GIT PULL] omap dss board clean-up for v3.10 merge window
In-Reply-To: <20130423171438.GC10155@atomide.com>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net> <5174F593.20705@ti.com>
 <20130423171438.GC10155@atomide.com>
Message-ID: <5177902C.5070407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-23 20:14, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130422 01:37]:

>> So while I think it is a good habit to push the arch changes and driver
>> changes separately, my question is, should that rule be followed to the
>> extreme? Can I just keep all the changes in one branch if separating the
>> arch and driver changes would end up with cloning files or lots of extra
>> code?
> 
> Shread branches are just fine. In most cases it's possible to add new
> pdata and then remove the old pdata later on with follow-up patches.

Yes, that's what I've been doing. But it's not possible in all cases,
and in some cases it's just really difficult/laborious.

I'll soon need to change the dss panel device model, and the only way I
can see that would allow us to keep everything running if only arch or
driver changes are merged, is to create a copy of all the omap display
drivers, and change the copy for the new dss device model.

And that's obviously a terrible way to do it.

So presuming I need to have the dss changes in separate arch and driver
series, and everything should run fine even if only the other half is
merged, then, well, I have no idea how to proceed. I'll continue looking
at this, but it's a bit frustrating to spend most of my time trying to
twist the code to accommodate the merging process, instead of making the
code work.

That said, this dss device model change should be a one time thing.
After it's done, these merging-problems should be greatly reduced.

>> Of course, I don't know what DRM maintainer thinks of merging arch
>> changes through his tree, so that's also open.
> 
> No let's not go there, Linus T already complained about the conflicts
> between drivers/net and arch/arm/*omap*/ code few merge windows ago.
> We need to remove the driver dependencies to the arch/arm code, otherwise
> the merging requires way too much work from multiple maintainers. That
> does not scale well and often leads into merge errors that could have
> been avoided in the first place.
> 
> Of course the real solution here is to get things moved over to DT
> based booting and then we don't have any of these dependencies as the
> .dts changes can get merged separately from the driver changes.

It will remove compile time dependencies, but we'll still have runtime
dependencies just like we do now.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/dfaf82bb/attachment.sig>
