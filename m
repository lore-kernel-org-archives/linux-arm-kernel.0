From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Aug 2012 13:15:16 +0100
Subject: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no avaiable path found
 for widget kcontrol
In-Reply-To: <20120801074952.GC30492@shlinux2.ap.freescale.net>
References: <1343387941-25266-1-git-send-email-b29396@freescale.com>
 <20120729202219.GA4384@opensource.wolfsonmicro.com>
 <20120801074952.GC30492@shlinux2.ap.freescale.net>
Message-ID: <20120801121516.GO11892@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 03:49:53PM +0800, Dong Aisheng wrote:
> On Mon, Jul 30, 2012 at 04:22:19AM +0800, Mark Brown wrote:

> > This isn't a good idea, it's fairly common for widgets to have a "None"
> > option which isn't expected to have an input.

> What i changed is mux widgets, i'm wondering is it possible or correct
> the mux widget has no input path?
> If i understand correct, we may need set correct input path
> for mux widget, or why we still need a mux?

> Or can you help give an example that no input needed for mux widget?

The above is the most common example - one of the inputs to a mux being
a "no input" option which shouldn't be connected to anything.  A mux
with no inputs at all would be silly, but having one (or sometimes a
couple for various reasons) that isn't connected isn't unusual.
