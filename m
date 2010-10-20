From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 11:16:54 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
Message-ID: <20101020091654.GL28166@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiho,

On Tue, Oct 19, 2010 at 04:30:25PM -0500, Matt Sealey wrote:
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
If the bootloader might configure the pins correctly, maybe something
like:

	if (pins_are_not_yet_configured_correctly()) {
		do_configure_them();
		msleep(500);
	}

?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
