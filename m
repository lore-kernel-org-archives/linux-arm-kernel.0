From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 16:57:16 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382625219.6040.96.camel@sakura.staff.proxad.net>
References: <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
 <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
 <1382621431.6040.66.camel@sakura.staff.proxad.net>
 <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
 <20131024141955.GB25061@ulmo.nvidia.com>
 <1382625219.6040.96.camel@sakura.staff.proxad.net>
Message-ID: <20131024145715.GC9044@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 04:33:39PM +0200, Maxime Bizon wrote:
> 
> On Thu, 2013-10-24 at 16:19 +0200, Thierry Reding wrote:
> 
> > We treated DT the same way we had treated platform data before, which
> > has inevitable lead to the current mess, which is only slightly better
> > than what we used to have. 
> 
> Side question, in your point of view, how is that better ?

The representation of the data may not be all that much better. But as a
side-effect of the whole DT shebang we've made improvements in many
other areas as well. Granted, we could've done that without DT too, but
DT was a pretty good motivator.

I also think that during the conversion of platform data to DT we've
made attempts to make the representation more generic and introduce
common or standard properties. So on the whole I think we have managed
to unify many things, which I think is a good thing.

> current DT tools are not able to validate a file wrt its schema, so for
> now we just moved platdata to DTS files and lost compiler type checking
> in between.

There's been talk about fixing that. I guess it might have been better
if we had had such a tool two years ago, but I certainly hadn't thought
about it before, so who am I to blame anyone else for not writing it.

> I respectfully understand people fighting for *stable* DT because I see
> the benefits behind this, even if IMO they absolutely do not outweigh
> the pain.
> 
> But I fail to see any benefits of "forever unstable" DT, if you have to
> tie the kernel tree with a DTB file, the description could have been
> left in C code.

Well the longterm goal certainly is to separate both, and keeping both
in lockstep was a means of easing the initial conversion. There's
certainly a lot of pain, but I also think that whatever we had before
just didn't work out so well. If it had all been sunshine and lollipops
then there wouldn't have been a need to change anything, right?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/2486e105/attachment-0001.sig>
