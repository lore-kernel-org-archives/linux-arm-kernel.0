From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 May 2016 23:07:33 +0200
Subject: [PATCH 10/16] clk: sunxi-ng: Add M-P factor clock support
In-Reply-To: <CAGb2v65GbZosmh56Z7wBa5gHOe1Ox2Jz3tcOq1kugBHO54OvbQ@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-11-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67F3UvSCYDTxeLkCJL3FzmcpkogM4RAQgDseXMJDv7bUw@mail.gmail.com>
 <20160523171845.GC27618@lukather>
 <CAGb2v65GbZosmh56Z7wBa5gHOe1Ox2Jz3tcOq1kugBHO54OvbQ@mail.gmail.com>
Message-ID: <20160524210733.GK27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 24, 2016 at 12:14:09PM +0800, Chen-Yu Tsai wrote:
> >> > +#define SUNXI_CCU_MP_WITH_MUX_GATE(_struct, _name, _parents, _reg,     \
> >>
> >> We could merge _struct with _name ...
> >>
> >> > +                                  _mshift, _mwidth,                    \
> >> > +                                  _pshift, _pwidth,                    \
> >> > +                                  _muxshift, _muxwidth,                \
> >> > +                                  _gate, _flags)                       \
> >> > +       struct ccu_mp _struct = {                                       \
> >>
> >> and have struct ccu_mp _name##_clk = {
> >
> > Unfortunately, that prevents to use dashes as clock names, which is
> > something we've done in the past. Having a separate name allows us to
> > use whatever we want.
> 
> We could do some replacement in the register function, but that seems
> hackish

Indeed

> Also I noticed we aren't using clock-output-names from the DT
> anymore?

Yep, there's just too many clocks to be practical, and you have to
have the name in the source code anyway for the parenting
relationships.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160524/3297fc91/attachment.sig>
