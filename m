From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 09:12:43 +0800
Subject: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <20130111125059.GA12715@arwen.pp.htv.fi>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111125059.GA12715@arwen.pp.htv.fi>
Message-ID: <20130114011241.GC24575@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Balbi,

On Fri, Jan 11, 2013 at 02:50:59PM +0200, Felipe Balbi wrote:
> As I said before, this patch is too big for -rc and is unnecessary
> considering patch I wrote above. Note that there is no problems in
> checking if ULPI PHY clk is 60MHz on all arches and, for the workaround,
> you already have a runtime check.
> 
Ok, I did not have these facts on my mind.  If these are true, the
cpu_is_xxx() shouldn't be necessary there from the beginning, and we
can simply remove them then.

> Shawn, it can be broken down into smaller pieces because you can *FIX
> THE COMPILE BREAKAGE* with a very small patch as above (only issue now
> is usage of MX32_IO_ADDRESS()).
> 
The MX35_IO_ADDRESS() also seems unnecessary, since as Peter's patch
suggested that pdata->regs can be used instead.

Shawn
