From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 08:47:10 -0400
Subject: [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <20120920115213.GF2450@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920114148.GH17666@opensource.wolfsonmicro.com>
 <20120920115213.GF2450@S2101-09.ap.freescale.net>
Message-ID: <20120920124709.GN17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 07:52:15PM +0800, Shawn Guo wrote:
> On Thu, Sep 20, 2012 at 07:41:50AM -0400, Mark Brown wrote:

> > It's usually pretty early but Takashi will be on holiday this time so
> > I'm not sure if things might be different (he was going to send the pull
> > request from holiday).  I also didn't guarantee that it'll be stable
> > yet, can someone please tell me what the depenency is here?

> We need the patch to have all imx drivers mach/* inclusion free,
> so that we can enable multi-platform support for imx, which is the
> whole point of the series.

That doesn't answer the question.  What is the dependency - what is it
about this patch that something else depends on?  Your cover letters
just say you'd like to do this but don't mention dependencies at all and
when I asked the question last night you said the same thing.  I've not
seen the rest of the series...

> If your for-3.7 is not stable anyway, I guess the easiest the way

It probably *is* stable but I'm not enthused about people pulling
unsigned tags.  I might rebase, though - I'm going to finalise the tree
in the next few days.

> to do it might be you drop the patch "ASoC: mx27vis: retrieve gpio
> numbers from platform_data" from your tree and I have it be part of
> the series to go via arm-soc tree as a whole.  (This is the original
> plan that I mentioned in v1 cover letter)

You just mentioned it as a preference (you said it's something you'd
like to do), please if you're doing this sort of cross tree thing be
explicit about what the inter-tree relationships are.  If things need to
go in via the same tree say so explicitly (and ideally say way this is).

The main reason I applied it straight away was that Javier mentioned
that it was a bug fix and it's near the merge window and these random
ARM cleanup serieses never seem to go in quickly.
