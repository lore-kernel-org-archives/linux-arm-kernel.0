From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Nov 2013 20:10:31 +0100
Subject: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
In-Reply-To: <20131118185959.GE19318@pengutronix.de>
References: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
 <20131118185959.GE19318@pengutronix.de>
Message-ID: <20131118191031.GF19318@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Mon, Nov 18, 2013 at 07:59:59PM +0100, Uwe Kleine-K?nig wrote:
> 	if (pgoff > screen_size || pgoff + len > screen_size)
This must be:

	if (pgoff > screen_size || len > screen_size - pgoff)

to do what I intended.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
