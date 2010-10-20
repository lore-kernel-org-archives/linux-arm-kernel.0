From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 20 Oct 2010 10:54:46 +0300
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
Message-ID: <20101020075446.GG2562@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 19, Matt Sealey wrote:
> On Tue, Oct 19, 2010 at 4:15 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Oct 19, 2010 at 10:42:54PM +0200, Arnaud Patard wrote:
> >> read board id value from the GPIO3_16/17/11
> >>
> >>
> >> +/* ? PCBID2 ?PCBID1 PCBID0 ?STATE
> >> + ? ? 1 ? ? ? 1 ? ? ?1 ? ?ER1:rev1.1
> >> + ? ? 1 ? ? ? 1 ? ? ?0 ? ?ER2:rev1.2
> >> + ? ? 1 ? ? ? 0 ? ? ?1 ? ?ER3:rev1.3
> >> + ? ? 1 ? ? ? 0 ? ? ?0 ? ?ER4:rev1.4
> >> +*/
> >> +static void __init mx51_efikamx_board_id(void)
> >> +{
> >> + ? ? int id;
> >> +
> >> + ? ? /* things are taking time to settle */
> >> + ? ? msleep(500);
> >
> > Is it really necessary to delay the boot process such a long time?
> 
> Yes. On older boards the PCBID pins are pulled high by IOMUX settings
> (a pulldown on the board on newer revisions will keep it down). IOMUX
> and GPIO stuff takes a little while to settle in, so if you do it
> immediately, it will return some freakish values based on random GPIO
> setup (it may be high, low, or none of the above at any point before
> the pad setting kicks in).

Then perhaps do this only for the older boards?

So by default there is no delay, but when a (new) config option is enabled,
delay boot.
