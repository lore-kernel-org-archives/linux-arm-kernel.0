From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Oct 2016 15:41:50 +0200
Subject: [PATCH v3 3/6] dt-bindings: pinctrl: Deprecate sunxi pinctrl
 bindings
In-Reply-To: <CACRpkdYGYPhPZQmgeLA-K-RQKZMLy1qHY6P7LS6SKsFC=d=MHg@mail.gmail.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
 <6aec73cd3b9d3dbf1085d042ec6c23f385a300de.1476971126.git-series.maxime.ripard@free-electrons.com>
 <CACRpkdb7zs7Nhs3i1o=WUt787vJCuePre3Tj3wLu++qwpO0atQ@mail.gmail.com>
 <20161024194917.g5oezqc4uacsyt24@lukather>
 <CACRpkdYGYPhPZQmgeLA-K-RQKZMLy1qHY6P7LS6SKsFC=d=MHg@mail.gmail.com>
Message-ID: <20161025134150.dct42swdbwxzgbgb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Oct 25, 2016 at 02:07:27PM +0200, Linus Walleij wrote:
> On Mon, Oct 24, 2016 at 9:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > However, it looks like the first patch from this serie is missing from
> > your tree, is there a reason for that?
> 
> No can you point it out?

Sure:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/462500.html

> > Also, in order to preserve bisectability, could you create an
> > immutable branch for those sunxi patches so that I can merge the DT
> > bits?
> 
> It's too late because they are already in the devel branch
> and mixed up with merged of *other* immutable stuff.

Hmmmm, ok.

> However I think it is plain wrong to try to keep any bisectability
> between the kernel at large and arch/*/boot/dts/*, because
> the DTS stuff is supposed to at some point be maintained outside
> of the kernel and for all OSes, they simply shouldn't be sync:ed.

Yes, in the case of a new driver that needs to be introduced, I
definitely get your point.

However, during a conversion like we're doing here, this is not ideal,
because it essentially means that you will not have a branch that
works, at all.

I'll hold off on those patches until 4.11 then.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/b74e47e6/attachment-0001.sig>
