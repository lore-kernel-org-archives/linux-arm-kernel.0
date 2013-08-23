From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Aug 2013 18:45:05 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130823165800.GB30617@sirena.org.uk>
References: <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
 <20130823165800.GB30617@sirena.org.uk>
Message-ID: <20130823174505.GQ6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 05:58:00PM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 01:58:03PM +0100, Russell King - ARM Linux wrote:
> > The split of the DMA backend from the CPU DAI backend is something
> > which early ASoC forced, but that has "mostly" been fixed with (as
> > far as I'm currently aware through testing) the problem I've been
> 
> Essentially all the dmaengine based platforms in mainline use a shared
> device for DMA and DAI; I'm fairly sure someone would have mentioned if
> there were problems.  
> 
> As you have been repeatedly told the Kirkwood drivers are the first
> drivers submitted to mainline which use DPCM and therefore it is not
> surprising that there are a few issues which need to be worked through,
> there were a few revisions to the framework which went in as a result of
> review during the mainline merge.  The problem you are seeing here is
> due to this being the first platform with a *shared* device to use DPCM.

So that's why it fails _without_ any DPCM stuff?  That's why the codecs
fail to have their set_bias stuff called?

Look Mark, frankly, shut your fucking mouth up about DPCM.  This bug has
nothing what so ever to do with DPCM, and the more times you try and
state that doesn't change that *FACT*.  And it is a FACT.

You've had this problem described by IRC, including extracts from the
ASoC code indicating where things go wrong.  I've shown you the debug
I've used.  I've shown you the result of that debug.  You've had
descriptions of this problem via email too.  Yet you refuse to acknowledge
that there could possibly be a problem here.

All the time that you insist that there isn't a problem against factual
evidence, you're just making yourself look totally incompetent and
obstructive - not only that but you're making yourself look like a total
idiot.

Your comments above are just PLAIN WRONG.

I'm sick to death with you.

You are not a fit person to hold the maintainership role for ASoC in my
opinion, and you are long past having any ability to change my opinion
on that anymore, given your obtuseness against this bug.

I live in hope that one day you'll recognise your mistake here and
appologise to me - but frankly I think that's something that you would
find absolutely impossible to do.
