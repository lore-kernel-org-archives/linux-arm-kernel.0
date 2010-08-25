From: mgr@pengutronix.de (Michael Grzeschik)
Date: Wed, 25 Aug 2010 14:51:56 +0200
Subject: [PATCH 0/2] fix mx35fb display mappings
In-Reply-To: <4C73FDCE.9080808@eukrea.com>
References: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282663623-8404-1-git-send-email-m.grzeschik@pengutronix.de>
	<4C73FDCE.9080808@eukrea.com>
Message-ID: <20100825125156.GA4311@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Aug 24, 2010 at 07:13:50PM +0200, Eric B?nard wrote:
> Hi Michael,
>
> Le 24/08/2010 17:27, Michael Grzeschik a ?crit :
>> This patches introduce a fix for the display mappings
>> in the mx35 framebuffer. It also sets the platformspecific
>> display mapping for the mx35_3ds development board's tft panel
>> added with this patch:
>>
> won't this patch break other platforms which are using mx3fb ?
Yes i suppose it will. But i am currently looking for a proper solution
to strange coloring issues on different pannels.

I figured out a different but related issue in the mx3fb code:
The sdc_init_panel function, which does the display mapping, is only
called with the IPU_PIX_FMT_BGR666 or IPU_PIX_FMT_RGB666 pixfmt.
So this pixfmt should better be set over the function property
with proper di_mappings.

So i think this patches can be seen as an RFC.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
