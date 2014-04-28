From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 12:52:36 +0200
Subject: [PATCH RFC 6/8] component: remove old add_components method
In-Reply-To: <20140428102806.GH26756@n2100.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBbp-0002Gs-Ju@rmk-PC.arm.linux.org.uk>
 <20140428070727.GC19455@ulmo>
 <20140428102806.GH26756@n2100.arm.linux.org.uk>
Message-ID: <20140428105235.GG19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:28:06AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 28, 2014 at 09:07:28AM +0200, Thierry Reding wrote:
> > I'm wondering if there may be an advantage to keeping both interfaces.
> > Even if currently what all implementations do is essentially creating
> > the match table at probe time there may be use-cases where that doesn't
> > work so well.
> 
> Keeping both interfaces makes this whole change is pointless, because
> then there's no way to avoid having to rebuild the tracking of which
> components belong to which master - and we might as well stick with
> what we have.
> 
> Moreover, one of the other points Laurent raised is that we need to
> be able to do partial binds for some subsystems, and for that to work
> we need more information held within the component helpers and the
> teardown/rebuild of the master/component relationships to be eliminated.
> 
> The last point is that the repeated teardown/rebuild is already being
> used as a justification to go off and write a completely different
> infrastructure instead... it seems some people deem this to be far
> too wasteful of our billion cycles per second CPUs.

FWIW, I do like the simplicity of the ->add_components() variant, and I
don't mind the few extra cycles wasted, but if this change makes sense
for everybody else I'll go convert my Tegra patches on top of this.

By the way, any chance I could get you to look at two earlier patches[0]
I did to make component/master work better for my use-case? The patches
are part of a series to convert the Tegra DRM driver to use the
component framework. The final patch[1] has the complete conversion with
a diff that I really like, although it requires yet another patch to
make it work (because Tegra has a somewhat unusual architecture).

Thierry

[0]: https://lkml.org/lkml/2014/4/22/535
     https://lkml.org/lkml/2014/4/22/1123
[1]: https://lkml.org/lkml/2014/4/22/1099
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/5ef864d2/attachment-0001.sig>
