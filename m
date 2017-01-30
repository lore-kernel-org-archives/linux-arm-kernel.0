From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 12:09:19 +0000
Subject: [PATCH 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170119131632.GA3862@afzalpc>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203837.6536-1-afzal.mohd.ma@gmail.com>
 <20170118221315.GP27312@n2100.armlinux.org.uk>
 <20170119131632.GA3862@afzalpc>
Message-ID: <20170130120919.GP27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 06:46:32PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Wed, Jan 18, 2017 at 10:13:15PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Jan 19, 2017 at 02:08:37AM +0530, afzal mohammed wrote:
> 
> > > +			MLK_ROUNDUP(vectors_base, vectors_base + PAGE_SIZE),
> > 
> > I think MLK() will do here - no need to use the rounding-up version
> > as PAGE_SIZE is a multiple of 1k.
> 
> Yes, i will replace it.
> 
> Earlier, used MLK(), got some build error, now checking again, no
> build error, i should have messed up something at that time.

Sorry for the delayed response.

With that change, you can get rid of this preprocessor conditional.
Arrange to have VECTORS_BASE defined to vectors_base in the nommu
part of asm/memory.h.  You'll also need to move the extern of that
there too.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
