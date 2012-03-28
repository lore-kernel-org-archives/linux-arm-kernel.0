From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Mar 2012 10:43:51 +0100
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <20120314123236.GE3133@opensource.wolfsonmicro.com>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
 <1331242494-3157-1-git-send-email-paul.gortmaker@windriver.com>
 <CAN1soZzDRR4XQ34WDL48=j+Ff8t5fsCFaccqZAKOQ1OAPeDXcA@mail.gmail.com>
 <4F608F4F.8020106@windriver.com>
 <20120314123236.GE3133@opensource.wolfsonmicro.com>
Message-ID: <20120328094351.GB22414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 12:32:36PM +0000, Mark Brown wrote:
> On Wed, Mar 14, 2012 at 08:30:07AM -0400, Paul Gortmaker wrote:
> > On 12-03-14 04:38 AM, Haojian Zhuang wrote:
> 
> > > How do you think about Mark's comments? Use dev_name() at here.
> 
> > I'm not sure I quite understand you.  I'd looked up the
> > structs and got their respective value that would be
> > returned by dev_name(), which is what I thought was
> > requested of me.
> 
> Yes, that's what you should do.  Calling dev_name() is only possible if
> you have the struct device and removing the need for the struct device
> is exactly what we're trying to avoid here.

So what the hell is happening here to fix the breakage which the
regulator tree caused in mainline?  From this thread, it looks like
it's been known about since 8th March which is now twenty days ago,
and it's still broken.
