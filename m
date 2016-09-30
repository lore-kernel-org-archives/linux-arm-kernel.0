From: karl.beldan@gmail.com (Karl Beldan)
Date: Fri, 30 Sep 2016 12:49:42 +0000
Subject: [PATCH 4/6] ARM: dts: da850-lcdk: add support for 1024x768
 resolution
In-Reply-To: <CAMpxmJVA+p1st7HzwoOJftArqpY-wUQb8WKbQFAEWnBOysxF6w@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-5-git-send-email-bgolaszewski@baylibre.com>
 <20160929185805.q2pdihajikgzo4lm@gobelin>
 <CAMpxmJVA+p1st7HzwoOJftArqpY-wUQb8WKbQFAEWnBOysxF6w@mail.gmail.com>
Message-ID: <20160930124942.ul737vxmdmkxqdre@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 11:37:57AM +0200, Bartosz Golaszewski wrote:
> 2016-09-29 20:58 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
> > Hi,
> >
> > On Thu, Sep 29, 2016 at 06:31:53PM +0200, Bartosz Golaszewski wrote:
> >> Add svga timings for 1024x768 resolution to the da850-lcdk
> >> device tree.
> >>
> >
> 
> [snip]
> 
> >
> > Why do you also call 1024x768 svga ?
> >
> 
> Thanks, should have been xga. will fix in v2.
> 
> > I don't think the LCDK can cope with this resolution at this frequency
> > (in terms of mem bandwidth), at least that's what I observed back in
> > August. If confirmed I think it is worth mentioning in the log at least,
> > but then I doubt adding this config would be useful.
> >
> 
> Thanks for the heads up. How would that manifest itself? This seems to
> work fine for me - I'm not getting any warnings on a simple system -
> maybe if I added some additional memory load it would complain.
> 

A mere dmesg > /dev/tty0 (or repeatedly cat-ting a file to /dev/tty0)
should suffice to make the issue visible and trigger FIFO underflows.

Regards, 
Karl
