From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 09:26:02 +0100
Subject: [PATCH v3 1/13] mmc: sunxi: Fix clock frequency change sequence
In-Reply-To: <CAPDyKFp735=MMm02PKEt2iZmN0Afyp52_g-8hKxpW71hw2RyiQ@mail.gmail.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <6f6b511bce9df86ee43486653ac55df0d135f198.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFp735=MMm02PKEt2iZmN0Afyp52_g-8hKxpW71hw2RyiQ@mail.gmail.com>
Message-ID: <20170125082602.llunpuqwsimtzkds@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Tue, Jan 24, 2017 at 09:12:07AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The MMC and SD specifications documents that the clock frequency should
> > only be changed once gated.
> 
> Where?
> 
> >
> > The current code first modifies the parent clock, gates it and then
> > modifies the internal divider. This means that since the parent clock rate
> > might be changed, the bus clock might be changed as well before it is
> > gated, which breaks the specification.
> >
> > Move the gating before the parent rate modification.
> 
> This all makes perfect sense to me, however I am not sure you need to
> refer to the spec to justify these changes.

I can't find it anymore :/

I'll resend that patch reworking the commit log.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/6f675543/attachment.sig>
