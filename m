From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:31:42 +0100
Subject: [PATCH 4/6] arm: mx5: always use __mxc_cpu_type to check cpu type
In-Reply-To: <AANLkTinOu0GHKTRJCB0Yn11QjN8ZoiCp9ZmAUTtDAJkZ@mail.gmail.com>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-4-git-send-email-richard.zhao@freescale.com>
	<20101209071026.GI17441@pengutronix.de>
	<AANLkTinOu0GHKTRJCB0Yn11QjN8ZoiCp9ZmAUTtDAJkZ@mail.gmail.com>
Message-ID: <20101209083142.GN17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Thu, Dec 09, 2010 at 03:52:01PM +0800, Richard Zhao wrote:
> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Thu, Dec 09, 2010 at 10:08:34PM +0800, Richard Zhao wrote:
> >> Every SoC in mach-mx5 calls mxc_set_cpu_type to set cpu type.
> > I don't like that. ?Your change makes the usage of cpu_is_mx51() for
> > single-machine builds more expensive.
> You're right. I'll add the below like other SoCs:
> #ifdef CONFIG_SOC_IMX51
> ..
> #else
> # define cpu_is_mx51()          (mxc_cpu_type == MXC_CPU_MX51)
> #endif
> 
> can I remove cpu_is_mx53 definition?  because CONFIG_SOC_IMX53 is
> undefined yet. Dinh can add it back when he send out other commits.
yeap

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
