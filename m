From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2016 20:09:36 +0100
Subject: [PATCH 0/2] serial: introduce DSR handling property
In-Reply-To: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
References: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <20161122190936.qmjpplmaherpgipw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 06:14:09PM +0100, Christoph Fritz wrote:
> This patchset introduces device-tree property "disable-dsr" including
> documentation and usage.
> 
> Christoph Fritz (2):
>   doc: DT: add generic serial property to disable DSR

I'd add the documentation for all handshaking lines, not only dsr. And
I'd call it disable-hw-dsr, otherwise

	{
		disable-dsr;
		dsr-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
	}

looks strange. (Not 100% sure this would make sense, but I think it
does.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
