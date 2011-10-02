From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 20:36:14 +0200
Subject: [PATCH 02/26] sound/pxa-zylonite: use a valid device for dev_err()
In-Reply-To: <20111002181611.GA2857@opensource.wolfsonmicro.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-3-git-send-email-arnd@arndb.de>
	<20111002181611.GA2857@opensource.wolfsonmicro.com>
Message-ID: <2376094.AH5MH8IXqN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 19:16:11 Mark Brown wrote:
> On Sat, Oct 01, 2011 at 10:03:34PM +0200, Arnd Bergmann wrote:
> > A recent conversion has introduced references to &pdev->dev, which does
> > not actually exist in all the contexts it's used in.
> 
> > Replace this with card->dev where necessary, in order to let
> > the driver build again.
> 
> Applied, thanks.  I'm a bit confused about why this is buried in the
> middle of some enormous series of some kind?

The series is about trivial build fixes that are specific to pxa.
I was expecting most of them to go through the pxa tree because
I figured out would be easier to keep them together like this.

I also have a few sound/soc fixes in the respective samsung and
omap series, so if you prefer I can move them to a sound/soc
series and submit them all at once to you instead.

> Oh, and please do try to use subject lines which match up with the rest
> of the code you're patching - in this case it even looks like whatever
> you're using to autogenerate is misfiring as you've got a combination of
> - and / in filenames.

The subject line was hand-written, any problem in there is purely
my own. What is the naming you want for sound/soc, should I use
"ASoC: pxa-zylonite:" or "sound/soc/pxa/zylonite:" or something
else?

	Arnd
