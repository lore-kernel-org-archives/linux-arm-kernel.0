From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 22:33:03 +0100
Subject: [PATCH] gpio/samsung: Complain loudly if we don't know the SoC
In-Reply-To: <CACxGe6vqUjayFVu1wNUYN_zjngKJcXkzzcxcGn4bwkHG7xv2yg@mail.gmail.com>
References: <1318885455-905-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CACxGe6vqUjayFVu1wNUYN_zjngKJcXkzzcxcGn4bwkHG7xv2yg@mail.gmail.com>
Message-ID: <20111017213303.GA3366@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 03:07:47PM -0600, Grant Likely wrote:
> On Mon, Oct 17, 2011 at 3:04 PM, Mark Brown

> > If we don't know the SoC type then we won't add any chips which is rather
> > unfortunate as neither GPIO nor pinmux APIs will work, breaking lots of
> > different subsystems. Logging at least provides a hint to the user as to
> > what's gone wrong.

> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Be Bolder!  May as well use WARN() and be really obnoxious.  :-)

Actually what's really unfortunate here is that in most configurations
this will cause a catastrophic failure to boot so we never get far
enough to see the logging at all.  We really need aSCREAM_THROUGH_DEBUG_LL()
or whatever.  Or to fix these things to dump via that route if we don't
have the console up yet, which is going to be more practical.
