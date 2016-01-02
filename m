From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 10:29:55 +0000
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
In-Reply-To: <alpine.DEB.2.11.1512291449380.28591@nanos>
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
 <20151027081834.GB1425@svinekod>
 <DB3PR04MB07407D83CC5F8F5F19A7207F4FB0@DB3PR04MB074.eurprd04.prod.outlook.com>
 <4875455.lvoc6XpkZc@wuerfel>
 <alpine.DEB.2.11.1512291449380.28591@nanos>
Message-ID: <20160102102955.GP8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2015 at 02:54:10PM +0100, Thomas Gleixner wrote:
> On Mon, 28 Dec 2015, Arnd Bergmann wrote:
> 
> > On Monday 28 December 2015 07:18:58 Huan Wang wrote:
> > > Hi, Arnd,
> > > 
> > > 	Could you help to review the following patch? Thanks.
> > > 
> > 
> > Hi Alison,
> > 
> > I'm sorry but I understand very little of this particular area of the kernel.
> > 
> > I've added Daniel Lezcano, John Stultz and Thomas Gleixner to Cc, they all
> > know this much better than I do and one of them should be able to comment after
> > their Christmas break.
> 
> I have no real opinion about that patch. It does no harm to unconditionally
> setup the hrtimer based broadcast even if it's never used.
> 
> Up to the arch maintainer to decide. 

That's really not fair to keep shovelling these kinds of decisions onto
architecture maintainers without any kind of explanation about how an
architecture maintainer should make such a decision.

Do I roll a 6-face dice, and if it gives an odd number, I apply this
patch, otherwise I reject it?

Is there a technical basis for making the decision?  If so, please
explain what the technical arguments are against having or not having
this change.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
