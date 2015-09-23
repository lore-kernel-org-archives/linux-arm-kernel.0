From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 23:31:12 +0200
Subject: [PATCH v2 1/9] ARM: dts: consolidate aliases for Cygnus dt files
In-Reply-To: <55FC85D6.7050506@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <25764744.UdkoAR05y0@wuerfel> <55FC85D6.7050506@broadcom.com>
Message-ID: <20046098.CeNft0Jl1D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 14:44:54 Ray Jui wrote:
> On 9/18/2015 2:27 PM, Arnd Bergmann wrote:
> > On Friday 18 September 2015 14:24:06 Ray Jui wrote:
> > 
> > The SoC has at least four uarts according to this, so it seems unlikely that
> > each board really only uses only the fourth one of them and labels it '0'
> > on the board. As soon as you get one board that has more than one uart wired
> > up, you would need to undo this.
> > 
> 
> I think Scott might have explained this in the past. uart3 is going to
> be used on all Cygnus boards (including all future boards) because the
> bootrom was designed to use uart3 as console and that won't change.
> 
> Let me know if you still think I need to move this back to the dts.

I would still like to see them stay in the .dts file, if only for
consistency with other platforms. 

Also, even if you can guarantee that uart3 is always used for the
console, that doesn't prevent board designers from adding more than
one uart, right?

	Arnd
