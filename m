From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jul 2016 09:32:04 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
 <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
Message-ID: <20160725073204.GD7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:34:44PM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 13 June 2016 at 21:57, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
> >> Hello,
> >>
> >> This is update of the sunxi spi patches that should give full-featured SPI
> >> driver.
> >>
> >> First three patches fix issues with the current driver and can be of use for
> >> stable kernels so adding cc for those.
> >>
> >> I merged the sun4i and sun6i driver because there several issues that need to
> >> be fixed in both separately and they are even out of sync wrt some fixes.
> >> I guess some of the merge patches can be squashed.
> >>
> >> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
> >> tell if that side was broken by this patchset - especially the last patch that
> >> adds DMA was afaik never tested on sun6i.
> >
> >
> > For the record, I'm still very much opposed to such a merge.
> 
> What is the reason against the merge? I did not find the original
> discussion.

I really prefer some code that is concise and clear but a little
duplicated over some code that shares every possible lines of code but
is a giant mess impossible to understand.

I just came across the reg_field stuff in regmap that would allow to
partially address that problem though, there's still the bit indices
issue to overcome though.

> I tried to rename everything in the drivers from sun4i and sun6i to
> sunxi to look at a clean diff and found about 5 differences 2 of which
> look like a bug.

It's hard to tell without testing.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/30b5e523/attachment.sig>
