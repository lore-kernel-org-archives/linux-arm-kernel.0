From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 18 Feb 2016 07:15:54 -0800
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <20160218105603.GE3939@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de>
 <1454295246.22151.6.camel@mtksdaap41>
 <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
 <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
 <56C4A875.6080908@gmail.com> <20160218105603.GE3939@pengutronix.de>
Message-ID: <20160218151552.GA1852@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

On Thu, Feb 18, 2016 at 11:56:03AM +0100, Sascha Hauer wrote:
> On Wed, Feb 17, 2016 at 06:05:57PM +0100, Matthias Brugger wrote:
> > 
> > 
> > On 15/02/16 03:14, Daniel Kurtz wrote:
> > >On Mon, Feb 15, 2016 at 10:11 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > >>Hi Eduardo, Sascha,
> > >>
> > >>>>Any input on this? I really like to get this driver upstream as it is
> > >>>>currently blocking other Mediatek drivers.
> > >>>>
> > >>>
> > >>>Hi Eduardo,
> > >>>
> > >>>Do you have any comment about Sascha's response ? We really hope get
> > >>>your comment since Mediatek thermal driver already reviewed in public
> > >>>over half years, and we have other patches [0] [1] depend on thermal
> > >>>driver.
> > >>>
> > >>>[0]:
> > >>>http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394084.html
> > >>>[1]:
> > >>>http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401055.html
> > >>
> > >>Friendly ping on the Mediatek thermal driver.
> > >>The "EFUSE" dependency has now landed in v4.5-rc4.
> > >
> > >Actually, it landed in char-misc-next, not v4.5-rc4.
> > >
> > >>So, AFAICT, the only thing left that may be blocking landing Mediatek
> > >>thermal driver is resolution of this discussion about thermal zones.
> > >>Can we kindly resolve this soon so we have a chance to land it in v4.6.
> > >>
> > 
> > 
> > I think the problem is, that Eduardo wants to see the hierachical thermal
> > zones being used. But there is still a discussion ongoing [1].
> 
> It seems the original Author lost interest in the hierarchical thermal
> zones. I am not convinced that we need hierarchical thermal zones for
> the Mediatek driver since from the five sensors we only need the maximum
> temperature (If this ever changes we could still rework it).
> 
> Given the current speed of communication I am not willing to add
> another, possibly controversal, dependency to an otherwise simple
> driver. I am even less willing when concerns like these come after *v12*
> of this series.
> 
> Eduardo, it would really help to get a word from you.

Apologize for the long delays here. In fact I want the hierarchical
support on this driver. But given that it is not really a strong
dependency and the hierarchical support is still an ongoing development,
I don't see why we should not merge this driver.

I also have had the chance to try it out in a board, and seams to work
for me. I am adding to my tree.

Thanks for the perseverance. :-)

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
