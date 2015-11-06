From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 14:32:29 -0800
Subject: [PATCH 09/19] drm: sun4i: Add DT bindings documentation
In-Reply-To: <CAL_JsqLuUUApGAgdw7U8EJ7p5yrYJg8AKFB32AE9Ufrf47=WpQ@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAL_JsqLuUUApGAgdw7U8EJ7p5yrYJg8AKFB32AE9Ufrf47=WpQ@mail.gmail.com>
Message-ID: <20151106223229.GM6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Oct 30, 2015 at 11:40:03AM -0500, Rob Herring wrote:
> > +Display Engine Backend
> > +----------------------
> > +
> > +The display engine backend exposes layers and sprites to the
> > +system. It's split into two components, the frontend and backend, the
> > +frontend doing formats conversion, scaling, deinterlacing, while the
> > +backend actually manages the layers.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun5i-a13-display-engine
> > +
> > +  - reg: base address and size of the memory-mapped region. Two are needed:
> > +    * backend0: registers of the display engine backend
> > +    * frontend0: registers of the display engine frontend
> 
> Why the zeros? I think they should be dropped.

We have SoCs that have two backends and two frontends, hence why I
added 0. I guess I can also add several devices for them, but then I'd
need to move to the component framework I guess (which was the plan anyway).

> > +
> > +  - allwinner,tcon: phandle to the TCON in our pipeline
> 
> Use of-graph or just let the relationship live in the driver. If there
> is only 1 instance of the blocks, the latter is fine.

We can also have several TCON instances in the SoC, and even though
you can on a theorical point of view use any TCON with any backend,
usually you're tied because of how the pins are routed on the boards.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/77e51878/attachment.sig>
