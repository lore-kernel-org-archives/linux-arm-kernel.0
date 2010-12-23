From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 23 Dec 2010 21:15:41 +0100
Subject: [patch 1/5] ehci-mxc: Enable vbus later
In-Reply-To: <20101221093132.GZ6017@pengutronix.de> (Sascha Hauer's message of
	"Tue, 21 Dec 2010 10:31:32 +0100")
References: <20101220154853.254931637@rtp-net.org>
	<20101220155810.708379512@rtp-net.org>
	<20101221093132.GZ6017@pengutronix.de>
Message-ID: <871v58b5zm.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Mon, Dec 20, 2010 at 04:48:54PM +0100, Arnaud Patard wrote:
>> vbus should be enabled after usb_add_hcd() otherwise USB is not working
>> on my efikamx.
>
> There is really something wrong with the way we handle initialization of
> the mxc ehci controller. There are frequently patches posted trying to
> change this order, and I think we are at a point where we can't move
> anymore without possibly breaking some other board. Should this be
> completely board dependend in the end?

I'm not aware of any other bug except the postsc setting one (which was
that any code trying to read the ulpi register without making sure that
portsc is configured for ulpi is buggy). Moreover, the change is
following the fsl bsp. I know it's not necessary the best code of the
world but I believe it has been tested on a lot of imx platforms.


Arnaud
