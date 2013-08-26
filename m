From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Aug 2013 19:58:24 +0200
Subject: [RFC] cleanup mach-s5p*
In-Reply-To: <521B4213.8040601@samsung.com>
References: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
 <521B4213.8040601@samsung.com>
Message-ID: <1903807.r5EYhW26aB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 August 2013 13:54:59 Marek Szyprowski wrote:
> Hi Kukjin,
> 
> On 8/26/2013 2:52 AM, Kukjin Kim wrote:
> > Hi all,
> >
> > I have a plan to remove supporting following SoCs in mainline in the near
> > future.
> > - s5pc100 - smdkc100
> > - s5pv210(s5c110) - aquial, goni, smdkc110, smdkv210, torbreck
> > - s5p64x0(s5p6440, s5p6450)- smdk6440, smdk6450
> >
> > I think users don't seem to use that any more with mainline. If so, we are
> > able to consider, it is not right now though.
> >
> > How do you think?
> 
> I am against removing support for S5PC110/S5PV210. We still use it for some
> of our internal development. DT support patches will be posted soon (pinctrl
> and clocks). Support for S5PC100 can be easily added the same way (we also
> have DT patches almost ready). S5PV210, S5PC100 and the older S3C64xx can
> all be handled by the same Samsung-DT 'machine file'.
> 
> However we don't have any s5p64x0 based boards to develop DT support for
> them.

I agree regarding s5pv210 -- there are multiple real boards supported
besides the smdk development boards, so it would be a regression to lose
those.

For s5pc100 and s5p64x0, the kernel currently only supports the smdk
board, which is not meant for production use as far as I know, so I would
not be too sad to see them gone. I guess converting them to DT would
however make it possible to use other boards without changes in the
kernel, which does sound useful if other boards exist.

Marek, can you give some insight into what hardware you are using?
Do you in fact use the smdkc100 or are you interested in adding support
for other boards?

Speaking in more general terms, the rule we usually apply is that any
hardware that people are still interested in using stays supported
in mainline, but if the current maintainer isn't interested in dealing
with them any more, it's up to whoever wants to keep them alive to
ensure they don't hold up progress in other areas.

	Arnd
