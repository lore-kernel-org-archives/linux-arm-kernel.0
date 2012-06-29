From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 19:47:16 +0800
Subject: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206291133.09379.marex@denx.de>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
 <20120629090602.GI5844@shlinux2.ap.freescale.net>
 <201206291133.09379.marex@denx.de>
Message-ID: <20120629114714.GE29197@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:33:09AM +0200, Marek Vasut wrote:
> > I did not check spec,
> > is it possible the supplied clock changed?
> 
> It's possible indeed ... Shawn?
> 
It's technically possible, but probably not practically.  The imx28 RM
does not mention i2c clock at all, and I was told by designer that i2c
always runs at the same frequency as apbx, which sources from ref_xtal
(always 24 MHz).  Though there is a divider for apbx clock, it seems
every single running system sets the divider as 1 all the time.  That
said, what I have seen is the i2c clock is always 24 MHz.

-- 
Regards,
Shawn
