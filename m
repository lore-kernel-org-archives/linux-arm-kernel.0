From: phil.edworthy@renesas.com (phil.edworthy at renesas.com)
Date: Tue, 18 Dec 2012 09:58:35 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Fix PFC - MOD_SEL2 missed an entry
In-Reply-To: <20121218042854.GH29354@verge.net.au>
References: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
 <20121218023610.GV28065@verge.net.au> <20121218035144.GC13353@verge.net.au>
 <20121218042854.GH29354@verge.net.au>
Message-ID: <OFBEDBF9C1.A0917823-ON80257AD8.0034C56B-80257AD8.0036CE31@eu.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

> On Tue, Dec 18, 2012 at 12:51:44PM +0900, Simon Horman wrote:
> > On Tue, Dec 18, 2012 at 11:36:10AM +0900, Simon Horman wrote:
> > > On Thu, Nov 22, 2012 at 04:28:57PM +0000, Phil Edworthy wrote:
> > > > The list of functions selected by the MOD_SEL2 register was 
missing
> > > > an entry. This caused all entries after this to modify the 
MOD_SEL2
> > > > register incorrectly.
> > > 
> > > Laurent, can you handle this in your series?
> > > I believe it removes this file.
> > 
> > Sorry, I missed the fact that this is for stable.
> > Laurent, can you handle upstream and I'll handle stable?
> 
> Sorry, yet another thing.
> 
> Phil, could you explain what problems manifest at for users without this
> change? To be included in stable it is important that it solves a 
problem
> that actually manifests.

If the user requests certain pin functionality (e.g. any HSPI2_B pins such 
as GPIO_FN_HSPI_CLK2_B), the MOD_SEL2 register won't be set up correctly, 
so it won't work. I am not sure if that warrants going onto stable or not 
- your call!

Thanks
Phil
