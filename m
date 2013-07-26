From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 26 Jul 2013 09:47:20 -0400
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <1374846070.14574.92.camel@i7.infradead.org>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726132709.GH29916@titan.lakedaemon.net>
 <1374846070.14574.92.camel@i7.infradead.org>
Message-ID: <20130726134720.GJ29916@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 02:41:10PM +0100, David Woodhouse wrote:
> On Fri, 2013-07-26 at 09:27 -0400, Jason Cooper wrote:
> > 
> > The other dynamic change that bears mentioning here is attributes which
> > have been configured by the bootloader.  For example, in mvebu, we have
> > the Schrodinger's Cat register.  It allows you to reconfigure the base
> > address of the registers from *within* that register range.  If the
> > bootloader does this, the DT needs to be updated to reflect the current
> > hardware configuration.  Otherwise, the kernel is stuck poking around at
> > memory addresses hoping to find something sane.
> > 
> > But this falls into the same category as you mentioned, but outside of
> > chosen {};.
> 
> Yeah, /chosen was given as an example of stuff that's almost
> *exclusively* "configuration" stuff.
> 
> But there's plenty outside there that can reasonably change.
> 
> It's OK to change the data, and of *course* the base address reported in
> the DT should actually match reality *today*, if it changes on the fly.
> 
> It's not OK to change the *schema*  in which those data are expressed.
> That's the ABI we're talking about.

Agreed, much more clear than what I was saying.

thx,

Jason.
