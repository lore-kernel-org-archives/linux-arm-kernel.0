From: sam.van.den.berge@telenet.be (Sam Van Den Berge)
Date: Thu, 8 Sep 2016 21:24:34 +0200
Subject: [GIT PULL 1/4] ARM: exynos: SoC/Mach for v4.9
In-Reply-To: <08dfc5c7-e844-023c-b5a8-9996dfb403ff@samsung.com>
References: <1472548739-20050-1-git-send-email-k.kozlowski@samsung.com>
 <1472548739-20050-5-git-send-email-k.kozlowski@samsung.com>
 <5635206.ooNAZCeQOe@wuerfel> <20160902163244.GB5534@kozik-lap>
 <08dfc5c7-e844-023c-b5a8-9996dfb403ff@samsung.com>
Message-ID: <20160908192434.GA609@sam-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 10:06:14AM +0200, Sylwester Nawrocki wrote:
> On 09/02/2016 06:32 PM, Krzysztof Kozlowski wrote:
> > On Fri, Sep 02, 2016 at 06:26:42PM +0200, Arnd Bergmann wrote:
> >> On Tuesday, August 30, 2016 11:18:59 AM CEST Krzysztof Kozlowski wrote:
> >>> Samsung mach/soc update for v4.9:
> >>> 1. Fix for DMA on S3C24xx. This was probably broken for long time, nobody runs
> >>>    this code... till now.
> >>
> >> Good to know. This reminds me that the s3c24xx DMA code is one of those
> >> that need to be converted to dma_slave_map at some point. Maybe if someone
> >> is now running that code, they could give that a try as well?
> >>
> >> It shouldn't be hard to convert, let me know if you need more information.
> > 
> > +Cc Sylwester,
> > 
> > Sylwester recently dig into this platform. I think he managed to play
> > some audio.
> 
> I revived this platform for testing ASoC changes.  I should find time
> to do that dma_slave_map refactoring sooner or later.
> 
> Or if you would like to do it Sam please go ahead.

Thanks for the suggestion and apologies for the late response. Last couple of 
days I've been figuring out what this would involve and I decided that I want
to give this a try. I found this patch series [1] that I'll use as an example.
If I understand it correctly, I'll need to create a dma_slave_map and
pass that via the platform data into the s3c24xx-dma driver. There I'll
need to fill in the filter_map of the dma slave device. Right?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393635.html

Kr,
Sam
