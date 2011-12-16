From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 Dec 2011 13:03:01 -0800
Subject: [GIT PULL] at91: devices and boards files update for 3.3
In-Reply-To: <4EEB73DD.3070505@atmel.com>
References: <4EEA034C.9020800@atmel.com>
 <CAOesGMiEg-8LA9-yUXRrDwGLGfVeFn7Xax9jhkDr+fZ5GU06QA@mail.gmail.com>
 <4EEB73DD.3070505@atmel.com>
Message-ID: <CAOesGMjC8tOY52LV=E9=KX_FbcC-eMoNHJ4E87vOrqk44=zJnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Dec 16, 2011 at 8:37 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Yes, this ISI driver addition is also dependent on an update of the ISI
> driver itself that will certainly be included in 3.3 by Guennadi using
> v4L2 path.
>
> So, do we have to wait for its inclusion in linux-next or maybe we can
> manage this little out-of-sync situation during the 3.3 life cycle...
>
> ISI is a "several times reworked" and "long-awaited" driver and I really
> would like to see it included in mainline soon...

I don't see why code that is known to be broken should be added to the kernel.

The way these things are normally handled is that once Guennadi has
the patch on a stable branch, we can add that branch as a dependency
that your code requires. So we pull that in as a dependency and apply
your code on top of it (or, if it is just one or two patches, that
they are are cherry-picked into your branch in the same way).

But that requires that he picks up the v4l patches and keeps it in a
stable, small, branch and that said branch gets merged in the 3.3
merge window before the branch containing these at91 changes do.

Guennadi, sound reasonable to you?


-Olof
