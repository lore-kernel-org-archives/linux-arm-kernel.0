From: tj@kernel.org (Tejun Heo)
Date: Fri, 5 Jul 2013 10:43:05 -0700
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20130705174305.GA28088@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jul 05, 2013 at 05:52:22PM +0800, Richard Zhu wrote:
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
>  - Configurations of the AHCI PHY clock, and the signal
>  parameters of the GPR13

Can't you just add a platform specific init callback to ahci_platform?
I don't see how these small differences in init sequence justify a
separate driver.

Thanks.

-- 
tejun
