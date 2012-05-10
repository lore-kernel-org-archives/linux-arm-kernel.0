From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 May 2012 08:56:15 +0200
Subject: [PATCH] ARM: imx: Modify IMX_IO_P2V macro
In-Reply-To: <1336609457-25502-1-git-send-email-rob.lee@linaro.org>
References: <1336609457-25502-1-git-send-email-rob.lee@linaro.org>
Message-ID: <20120510065614.GE31844@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robert,

On Wed, May 09, 2012 at 07:24:17PM -0500, Robert Lee wrote:
> A change is needed in the IMX_IO_P2V macro to allow all imx5 platforms
> to use common definitions when accessing registers of peripherals on
> the AIPS2 bus.
> 
> This change was tested for mapping conflicts using the iop2v script
> found at git://git.pengutronix.de/git/ukl/imx-iop2v.git and by
> performing a bootup of a default build using imx_v6_v7_defconfig
> on a imx51 babbage board and imx53 loco board.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
It took me some time to understand your goal. With your change you
achieve that

	IMX_IO_P2V(MX50_AIPS2_BASE_ADDR) ==
	IMX_IO_P2V(MX51_AIPS2_BASE_ADDR) ==
	IMX_IO_P2V(MX53_AIPS2_BASE_ADDR)

(which IMHO is more than "allowing ... to use common definitions [for
the] AIPS2 bus).

I can confirm that my imx-iop2v script doesn't find a conflict with your
change. Having said that I didn't check that the memory regions listed
in the script still match the regions that are statically mapped on imx.

And I wonder why do you need to have the aips2 bus mapped to the same
address on all imx5 machines. The future is that the base addresses of
the various devices are determined via dt and then the static mappings
go away. Do I miss something?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
