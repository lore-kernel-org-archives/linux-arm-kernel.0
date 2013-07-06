From: r65037@freescale.com (Zhu Richard-R65037)
Date: Sat, 6 Jul 2013 02:03:30 +0000
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130705174305.GA28088@mtj.dyndns.org>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>,
 <20130705174305.GA28088@mtj.dyndns.org>
Message-ID: <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun:
Thanks for your comments.

Best Regards
Richard Zhu
________________________________________
From: linux-ide-owner@vger.kernel.org [linux-ide-owner at vger.kernel.org] on behalf of Tejun Heo [tj at kernel.org]
Sent: Saturday, July 06, 2013 1:43 AM
To: Richard Zhu
Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; avorontsov at ru.mvista.com; rob.herring at calxeda.com; s.hauer at pengutronix.de; linux-ide at vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms

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
[Richard] Just like what we dicussed in the previous v1/v2 patch-set.
Shawn has the concerns that the IP speicific codes shouldn't be put in the platform level.
So he suggested that setup a stand-alone driver, contained the imx6q ahci sata specific
codes, and re-use the generic ahci_platform driver as much as possible.
This imx6q standalone ahci sata driver just registers the platform data, and the others would be handled
by ahci_platform driver.

Thanks.

--
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
