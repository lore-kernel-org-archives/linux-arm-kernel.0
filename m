From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Jul 2016 08:27:36 +0200
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <1467691450-22975-3-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
Message-ID: <20160705062736.GL16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 05, 2016 at 06:04:09AM +0200, Andreas F?rber wrote:
> +&iomuxc {
> +	imx6sx-udoo-neo {

There is no need for this machine group. Please just put the pinctrl
groups directly into &iomuxc { }.

> +		pinctrl_enet1: enet1grp {
> +			fsl,pins =
> +				<MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0xa0b1>,
> +				<MX6SX_PAD_ENET1_MDC__ENET1_MDC		0xa0b1>,

It's unusual to write pinmuxes this way. The usual form is to write it
in a single array. (Not sure I'm using the right term here.) Having said
that I like it your way, but still it should (IMHO) get a more official
blessing.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
