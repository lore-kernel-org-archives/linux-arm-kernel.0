From: r65037@freescale.com (Zhu Richard-R65037)
Date: Mon, 1 Jul 2013 14:58:52 +0000
Subject: [v2 4/4] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130701133611.GB11408@mtj.dyndns.org>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>,
 <20130701133611.GB11408@mtj.dyndns.org>
Message-ID: <0E83723C55F66F43A6041464FE31119D30C323@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun, Girish and all:
Yes, I understand what you said.
In the first version, based on the ahci_platform driver, I used to put the imx ahci differrence into
 the platform level, and re-use ahci_platform driver.

Shawn has some concerns about that, just like he said.
So I re-orgnized imx ahci driver, and re-send it in the version2 around.

Let's have the discussions here, and figure out a most proper method to do the right thing.
Any comments and suggetsions are apppreciated.
thanks again.

Best Regards
Richard Zhu
________________________________________
From: Tejun Heo [htejun at gmail.com] on behalf of Tejun Heo [tj at kernel.org]
Sent: Monday, July 01, 2013 9:36 PM
To: Richard Zhu
Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; avorontsov at ru.mvista.com; rob.herring at calxeda.com; s.hauer at pengutronix.de; linux-ide at vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms

On Mon, Jul 01, 2013 at 06:02:55PM +0800, Richard Zhu wrote:
> imx6q contains one Synopsys AHCI SATA controller,
> But it can't shares ahci_platform driver with other
> controllers.
> Because there are some misalignments of the bits
> definitions of the HBA registers and the Vendor
> Specific registers
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.

If these are the only differences, can't you make ahci_platform deal
with different variants?  That's how we deal with subtly different
variants of about the same controllers.

Thanks.

--
tejun
