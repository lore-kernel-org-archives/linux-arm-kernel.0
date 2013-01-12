From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 12 Jan 2013 14:34:50 +0100
Subject: [PATCH 0/2 v2] at91/ssc: fixes on ASoC tree for 3.8
In-Reply-To: <20130111195331.GA2533@quad.lixom.net>
References: <cover.1357912706.git.nicolas.ferre@atmel.com>
 <CAOesGMhhSkrvP7X=y8qmdMKKXZ694+1+ZXY3y6HK1E85qaN5sQ@mail.gmail.com>
 <20130111193948.GA8677@opensource.wolfsonmicro.com>
 <20130111195331.GA2533@quad.lixom.net>
Message-ID: <20130112133450.GF7360@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:53 Fri 11 Jan     , Olof Johansson wrote:
> On Fri, Jan 11, 2013 at 07:39:49PM +0000, Mark Brown wrote:
> > On Fri, Jan 11, 2013 at 10:52:19AM -0800, Olof Johansson wrote:
> > > On Fri, Jan 11, 2013 at 6:08 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > > 
> > > > This material was designed to enter Mark's fixes queue, but as discussed with
> > > > Olof, we can imagine merging everything through arm-soc or split the series (of
> > > > 2 patches) and let them progress upstream separated (option that I do not like
> > > > even if I know that the consequences are not so dramatic).
> > > > So please, Olof, if you feel confortable with this series, tell us what you
> > > > prefer and we will make our best to make this material go forward...
> > 
> > > You're setting yourself up for awkward merges. The driver change is
> > > strongly dependent on the device tree change by failing probe unless
> > > the device tree update is there, while before this patch, it still
> > > worked.
> > 
> > This is partly my fault for getting grumpy about adding the bolier plate
> > code without error checking - overall Linus' change to do the get in the
> > core seems like the most sane approach here.
> > 
> > > But to be honest, I don't think this is a fix, it's a feature that you
> > > just didn't include in time for the merge window. I don't really see
> > > them as appropriate 3.8 material at this point.
> > 
> > Jean-Christophe has been most insistent that pinctrl support is now
> > manadatory for all AT91 systems using device tree. 
> 
> That's a noble goal but enforcing it early gives everyone a lot of pain, and
> quite honestly doesn't make sense. During transition it's better to be lenient
> and allow both old and new methods (without breakage), unless it causes
> significant extra churn.
except here we can not as the same ip manage gpio & pinctrl

so no choice we need to do the switch at once

and that's why we wait 1 more release to do the switch so erveryone can play
with it before

Best Regards,
J.
