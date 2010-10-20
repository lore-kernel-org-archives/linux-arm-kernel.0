From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 10:35:28 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101020082418.GF28242@pengutronix.de> (Sascha Hauer's message
	of "Wed\, 20 Oct 2010 10\:24\:18 +0200")
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020082418.GF28242@pengutronix.de>
Message-ID: <87mxq9cldb.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Tue, Oct 19, 2010 at 04:30:25PM -0500, Matt Sealey wrote:
>> On Tue, Oct 19, 2010 at 4:15 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Tue, Oct 19, 2010 at 10:42:54PM +0200, Arnaud Patard wrote:
>> >> read board id value from the GPIO3_16/17/11
>> >>
>> >>
>> >> +/* ? PCBID2 ?PCBID1 PCBID0 ?STATE
>> >> + ? ? 1 ? ? ? 1 ? ? ?1 ? ?ER1:rev1.1
>> >> + ? ? 1 ? ? ? 1 ? ? ?0 ? ?ER2:rev1.2
>> >> + ? ? 1 ? ? ? 0 ? ? ?1 ? ?ER3:rev1.3
>> >> + ? ? 1 ? ? ? 0 ? ? ?0 ? ?ER4:rev1.4
>> >> +*/
>> >> +static void __init mx51_efikamx_board_id(void)
>> >> +{
>> >> + ? ? int id;
>> >> +
>> >> + ? ? /* things are taking time to settle */
>> >> + ? ? msleep(500);
>> >
>> > Is it really necessary to delay the boot process such a long time?
>> 
>> Yes. On older boards the PCBID pins are pulled high by IOMUX settings
>> (a pulldown on the board on newer revisions will keep it down). IOMUX
>> and GPIO stuff takes a little while to settle in, so if you do it
>> immediately, it will return some freakish values based on random GPIO
>> setup (it may be high, low, or none of the above at any point before
>> the pad setting kicks in).
>
> Maybe it's possible to delay only the registering of the devices which
> depend on the board revision, perhaps with a workqueue. But ok, I don't
> care much and this won't be a show stopper for this patch.

ok. Will wait a little bit more for comments and send a new patchset.

Thanks,
Arnaud
