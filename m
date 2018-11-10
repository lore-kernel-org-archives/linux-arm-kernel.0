From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sat, 10 Nov 2018 14:16:47 +0300
Subject: [PATCH] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181110001615.GA5665@brain-police>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
Message-ID: <20181110111647.GA3511@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 12:16:16AM +0000, Will Deacon wrote:
> On Fri, Nov 09, 2018 at 11:47:47PM +0300, Sergey Matyukevich wrote:
> > Specify correct type for the constants to avoid
> > the following sparse complaints:
> > 
> > ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > 
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I thought this was fixed in newer versions of sparse so that it treats
> AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]

I am using up-to-date sparse. However this warning still appears,
not sure why. Maybe sparse treats such constants as unsigned int ?

Meanwhile it looks like I chose wrong type: it is enough to use UL
instead of ULL to make sparse happy. In fact warning is clear
about it.

Regards,
Sergey
