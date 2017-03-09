From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 15:55:39 +0100
Subject: [linux-sunxi] Re: [PATCH 10/15] drm/sun4i: tcon: Switch mux on
 only for composite
In-Reply-To: <CAGb2v67XkaC2+AxubaUF9nPcoGZcAzny7LKVD6C+-9BM5Fi+9g@mail.gmail.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67iTOV-=u5rReu6_wi6NFoCoJkbJKshTpmFYUmJ=ggKUw@mail.gmail.com>
 <20170309105800.mnzhvnky6na7d5vn@lukather>
 <CAGb2v67XkaC2+AxubaUF9nPcoGZcAzny7LKVD6C+-9BM5Fi+9g@mail.gmail.com>
Message-ID: <20170309145539.43eequth2ej7wvqk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 07:31:27PM +0800, Chen-Yu Tsai wrote:
> >> Additionally, the mux registers are only valid in the first TCON, meaning
> >> it must available be active in 2 pipeline chips. It's also why we'd pass
> >> "struct drm_device *" instead of "struct sun4i_tcon *".
> >
> > Hmmmm. That's going to be tricky to support. Has this been confirmed
> > somehow? Is the register used for something else on TCON1?
> 
> At this point, the only reference is Allwinner's kernel, and the old 3.4
> kernel for A10/A20. I could try getting HDMI working on the A31 to get
> some real results.
> 
> FWIW, the registers do not seem to be aliased across the two TCONs.

Then maybe we don't need to care, and we can just always write to the
mux?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/2f3b1816/attachment.sig>
