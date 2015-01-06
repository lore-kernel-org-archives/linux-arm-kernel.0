From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Jan 2015 11:47:18 -0200
Subject: [PATCH] ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling
In-Reply-To: <1420551365.2333.15.camel@pengutronix.de>
References: <1420478348-2754-1-git-send-email-fabio.estevam@freescale.com>
 <20150106124343.GM24511@dragon>
 <1420551365.2333.15.camel@pengutronix.de>
Message-ID: <CAOMZO5Bn58O2Mr4SsBqWbiwecOKOiQMDDugLzi+aRVf+jOx=Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 6, 2015 at 11:36 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> For the record:
> I'm not happy with this patch. It still abuses the regulator API for
> something completely unrelated and this may well break again in the
> future. But given that it fixes an actual regression and you already
> sent a pull including this I'm okay to keep it.
>
> We still need a proper fix to handle ULPI resets to get rid of this
> hackery.

Actually the ULPI PHY reset is properly handled now. What is missing
is the USB Hub reset to be properly handled.

According to the USB maintainer, Alan Stern, a proper solution has not
come up yet:
http://www.spinics.net/lists/linux-usb/msg97483.html

When a proper USB hub reset solution shows up, we can certainly use
it, but for now let's have USB host functional by using the regulator
API hack.
