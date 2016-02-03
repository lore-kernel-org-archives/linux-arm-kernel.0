From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 21:47:30 +0100
Subject: [PATCH v2 17/26] drm: sun4i: Add DT bindings documentation
In-Reply-To: <CAL_JsqLLvK0L+PaOxesgr9u_3hb6EWbb9w2-yw80D8sUqiohTA@mail.gmail.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-18-git-send-email-maxime.ripard@free-electrons.com>
 <20160115031515.GA19797@rob-hp-laptop>
 <20160203195919.GB3327@lukather>
 <CAL_JsqLLvK0L+PaOxesgr9u_3hb6EWbb9w2-yw80D8sUqiohTA@mail.gmail.com>
Message-ID: <20160203204730.GH3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 02:19:31PM -0600, Rob Herring wrote:
> >> > +Required properties:
> >> > +  - compatible: value must be one of:
> >> > +    * allwinner,sun5i-a13-display-engine
> >> > +  - allwinner,pipelines: list of phandle to the entry points of the
> >> > +    pipelines (either to the frontend or backend)
> >> > +
> >> > +Example:
> >> > +
> >> > +panel: panel {
> >> > +   compatible = "olimex,lcd-olinuxino-43-ts";
> >>
> >> This should either be a child of what it is attached to or use of-graph.
> >
> > You had a similar discussion with Thierry last time I sent it, and it
> > seemed to settle on keeping that property:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/382115.html
> >
> > Has that changed?
> 
> No, I still disagree. We already have 2 ways to describe panels: as a
> child node of its controller or with of-graph. We don't need a 3rd way
> even if it is simple. The problem with of-graph today is too much of
> the parsing is left to the individual drivers. We need to fix that and
> make it be handled by common code.

Ok. I'm guessing from your answer you prefer of-graph over a child
node ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/d38c1394/attachment.sig>
