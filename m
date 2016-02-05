From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Feb 2016 10:05:45 +0100
Subject: [PATCH v2 2/3] Input: rotary-encoder - move configuration data
 to driver data
In-Reply-To: <20160204211842.GA40137@dtor-ws>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09CAB.5020600@zonque.org>
 <20160203093527.GD13664@pengutronix.de>
 <20160204211842.GA40137@dtor-ws>
Message-ID: <20160205090545.GM13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dmitry,

On Thu, Feb 04, 2016 at 01:18:42PM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 03, 2016 at 10:35:27AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Tue, Feb 02, 2016 at 01:10:19PM +0100, Daniel Mack wrote:
> > > On 02/02/2016 11:24 AM, Uwe Kleine-K?nig wrote:
> > > > This is a preparation for the next patche. There is no change in
> > > > behaviour intended.
> > > 
> > > This one looks good to me, but it clashes with Dmitry's latest patch
> > > sets (which I haven't found the time to test yet, sorry!).
> > 
> > There is nothing in next-20160203, so I assume Dmitry either fixes this
> > up when applying my patches or tells me when I should rebase.
> 
> Please take a look at my rotary-encoder branch. I am waiting to merge it
> into next until I can get some testers. If you have raumfild device that
> would be awesome.

I don't have a raumfeld device. I did a similar conversion and the only
relevant difference is that I used

	.dev_id = "rotary_encoder.0",

while you used

	.dev_id = "rotary-encoder",

in raumfeld_rotary_gpios_table.
I think a mixture of these is the right thing, i.e.

	.dev_id = "rotary-encoder.0",

Your series obsoletes my first two patches, so I will port my third
patch on top of your branch and retest there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
