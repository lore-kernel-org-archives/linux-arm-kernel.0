From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 17 Dec 2011 19:34:45 +0100 (CET)
Subject: [GIT PULL] at91: devices and boards files update for 3.3
In-Reply-To: <CAOesGMjC8tOY52LV=E9=KX_FbcC-eMoNHJ4E87vOrqk44=zJnA@mail.gmail.com>
References: <4EEA034C.9020800@atmel.com>
 <CAOesGMiEg-8LA9-yUXRrDwGLGfVeFn7Xax9jhkDr+fZ5GU06QA@mail.gmail.com>
 <4EEB73DD.3070505@atmel.com>
 <CAOesGMjC8tOY52LV=E9=KX_FbcC-eMoNHJ4E87vOrqk44=zJnA@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1112171928380.13817@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

On Fri, 16 Dec 2011, Olof Johansson wrote:

> Hi Nicolas,
> 
> On Fri, Dec 16, 2011 at 8:37 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
> > Yes, this ISI driver addition is also dependent on an update of the ISI
> > driver itself that will certainly be included in 3.3 by Guennadi using
> > v4L2 path.
> >
> > So, do we have to wait for its inclusion in linux-next or maybe we can
> > manage this little out-of-sync situation during the 3.3 life cycle...
> >
> > ISI is a "several times reworked" and "long-awaited" driver and I really
> > would like to see it included in mainline soon...
> 
> I don't see why code that is known to be broken should be added to the kernel.
> 
> The way these things are normally handled is that once Guennadi has
> the patch on a stable branch, we can add that branch as a dependency
> that your code requires. So we pull that in as a dependency and apply
> your code on top of it (or, if it is just one or two patches, that
> they are are cherry-picked into your branch in the same way).
> 
> But that requires that he picks up the v4l patches and keeps it in a
> stable, small, branch and that said branch gets merged in the 3.3
> merge window before the branch containing these at91 changes do.
> 
> Guennadi, sound reasonable to you?

I'm not sure what you call a "stable" branch. If you mean a branch in some 
tree somewhere (like my tree on linuxtv.org) then I wouldn't yet use that. 
I think, there are two ways to handle this:

1. Safe from the dependency and synchronisation PoV, but might cause 
problems during merge. One of the patches gets an ack from the respective 
maintainer but gets merged together with the other patch via the "wrong" 
tree. E.g., someone from at91 could ack this patch and I could apply it to 
V4L together with the actual ISI patch.

2. Each patch goes via its own tree, but we make sure, that at91 tree is 
pushed to Linus after the V4L tree. This is more "correct" - each patch is 
merged via its respective tree, but if the V4L tree is merged near the end 
of the merge interval, it might be difficult for at91 to hit the remaining 
window.

I'm ok with either of the above.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
