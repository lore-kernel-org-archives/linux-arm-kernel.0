From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 May 2011 17:35:36 -0600 (MDT)
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110502223636.GB28001@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
	<4DBE2064.2060303@gmail.com> <1304307632.2686.33.camel@pororo>
	<4DBEDC12.4090203@gmail.com>
	<20110502223636.GB28001@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105041732290.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 2 May 2011, Russell King - ARM Linux wrote:

> This does bring us to an interesting question though: should clk_set_rate()
> succeed or fail with a NULL clk?  There is no clock to control, so my
> feeling is that it should fail, just like clk_get_rate() should return
> zero because the rate is meaningless.  There is no rate to get and no
> rate to set.

Returning an error would be my preference when a NULL or bogus clock 
pointer is passed to any clk_* operation, especially since those 
operations will need to dereference the clock pointer.


- Paul
