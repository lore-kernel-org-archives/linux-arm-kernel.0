From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 14:08:13 +0100
Subject: [PATCH v2 16/19] drm/sun4i: backend: Assign the pipes
 automatically
In-Reply-To: <CAGb2v662Qx6nY3Tgvnh=CRMoSDsFwNEiZwW+X8YuN8zMaNwLgw@mail.gmail.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
 <d4ae26685ad75bd2dde3c3c3b7d086fb544347cc.1516617243.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v662Qx6nY3Tgvnh=CRMoSDsFwNEiZwW+X8YuN8zMaNwLgw@mail.gmail.com>
Message-ID: <20180129130813.rrnjzmskgjrbzxg2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 10:22:54AM +0800, Chen-Yu Tsai wrote:
> On Mon, Jan 22, 2018 at 6:35 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Since we now have a way to enforce the zpos, check for the number of alpha
> > planes, the only missing part is to assign our pipe automatically instead
> > of hardcoding it.
> >
> > The algorithm is quite simple, but requires two iterations over the list of
> > planes.
> >
> > In the first one (which is the same one that we've had to check for alpha,
> > the frontend usage, and so on), we order the planes by their zpos.
> >
> > We can then do a second iteration over that array by ascending zpos
> > starting with the pipe 0. When and if we encounter our alpha plane, we put
> > it and all the other subsequent planes in the second pipe.
> >
> > And since we have runtime checks and pipe assignments now, we can just
> > remove the static declaration of the planes we used to have.
> 
> It would be slightly better if you could split this out into a separate
> patch. It's not immediately obvious to others that the changes to
> sun4i_layer.c are self-contained, while the change to sun4i_layer.h
> is part of the new pipeline tracking thing. Plus I think the way you
> structured everything means it won't break if you split it out.

You're right, I'll split this patch and resend it. I've pushed the
patches 9-15 to drm-misc, with your suggestions when you had some.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/f5b13d81/attachment.sig>
