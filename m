From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 8 Jan 2012 11:32:40 +0800
Subject: MX28 fec clock frequency
In-Reply-To: <4F06D643.6080602@prolan.hu>
References: <4F06D643.6080602@prolan.hu>
Message-ID: <20120108033238.GA19721@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Jan 06, 2012 at 12:08:51PM +0100, Peter Rusko wrote:
> Hi all,
> 
> I'm trying to get the fec clock frequency on the i.MX28 processor. I0
> need it for a PTP clock and it seems that I get a wrong value:
> clk_get_rate returns 151578947.
> 

The ptp clock (CLK_ENET_TIME) was missed from the initial imx28 clock
support.  The fec_clk which is one child of hbus_clk (151 MHz) is
taken as MDIO clock in fec driver.

-- 
Regards,
Shawn
