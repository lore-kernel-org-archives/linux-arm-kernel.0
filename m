From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Sep 2014 10:10:38 +0900
Subject: [PATCH repost] ARM: shmobile: lager: correct memory map
In-Reply-To: <5406B396.30907@renesas.com>
References: <20140903004901.GA3277@verge.net.au> <54068031.5050806@renesas.com>
 <20140903054843.GA29259@verge.net.au> <5406B396.30907@renesas.com>
Message-ID: <20140904011038.GA433@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 03:22:14PM +0900, Khiem Nguyen wrote:
> Dear Simon-san,
> 
> On 9/3/2014 2:48 PM, Simon Horman wrote:
> > Hi Khiem-san,
> > 
> > On Wed, Sep 03, 2014 at 11:42:57AM +0900, Khiem Nguyen wrote:
> >> Dear Simon-san, Shiiba-san,
> >>
> >> Thanks for the patch.
> >>
> >> On 9/3/2014 9:49 AM, Simon Horman wrote:
> >>> The base address of the second memory region on the lager
> >>> board is 0x140000000. Update the tag used in the dts file accordingly.
> >>>
> >>> This is a documentation fix and should have no run-time affect.
> >>>
> >>> This problem was introduced when the second memory region
> >>> was added to the lager dts file by 62bc32a2573c4219
> >>> ("ARM: shmobile: Include all 4 GiB of memory on Lager)"
> >>> in v3.14.
> >>>
> >>> Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
> >>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>> ---
> >>>  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> I am reposting this as Olof originally requested a syntax change,
> >>> which I followed up on, however that change no longer seems appropriate.
> >>> This this patch seems to be correct.
> >> [...]
> >>> -	memory at 180000000 {
> >>> +	memory at 140000000 {
> >>
> >> Could you give more information about not using new syntax ?
> >>
> >> I checked memblock information in both 2 ways 
> >> (i.e memory at 140000000 and memory at 1,40000000)
> >> and I got same result.
> >> root at lager:~# cat /sys/kernel/debug/memblock/memory
> >>    0: 0x0000000040000000..0x000000007fffffff
> >>    1: 0x0000000140000000..0x00000001ffffffff
> >>
> >> So, what does 'no longer seems appropriate" mean ?
> > 
> > Sorry for being vague.
> > 
> > I am specifically referring to the conversation in
> > the thread "[PATCH 11/14] arm64: dts: Add initial device tree support for
> > EXYNOS7" and in particular the following contribution to that discussion by
> > Olof:
> > 
> > 	"Ok, I'm happily proven wrong here, also by confirming how this is
> > 	 done on "real" OF.
> > 
> > 	 According to benh:
> > 
> > 	 15:20 <benh> ojn: 0,0 is not quite right, it's supposed to be used
> > 	 when the two numbers are different things, like device,fn on PCI
> > 
> > 	 The same is true for >2^32 unit addresses, they just use the one
> > 	 integer instead of x,y.
> > 
> > 	 So, I take back all I've said on this in the last 72 hours. :) It
> > 	 looks like we might need to revisit some of the 32-bit DTs.  Simon,
> > 	 drop the series you had. :)"
> > 
> > An archive of the message in question is available at:
> > https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36123.html
> 
> OK. I understood.
> Let's follow the right way. :)

Thanks. I have queued up this patch.
