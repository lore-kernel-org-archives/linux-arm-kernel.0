From: andre@bluewatersys.com (Andre Renaud)
Date: Thu, 02 Jun 2011 10:41:02 +1200
Subject: [Solved] Re: Freescale i.mx25 SDIO/Libertas issue
In-Reply-To: <4DE5E97D.90705@gmail.com>
References: <4DE2F84D.8080907@bluewatersys.com>	<4DE44F16.8050407@bluewatersys.com>
	<4DE5E97D.90705@gmail.com>
Message-ID: <4DE6BFFE.6000101@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Zamek,

> 05/31/2011 04:14 AM keltez?ssel, Andre Renaud ?rta:
>> If I enable the libertas debugging details, I get some more information:
>>
>> This seems to imply that the unit is correctly loading the firmware, and
>> then when it determines that the firmware has loaded, and tries to issue
>> the CMD_FUNC_INIT command, this times out.
>>
>> Can anyone explain how I can begin debugging this, or confirm if they've
>> had this operate on the sdhci-esdhc-imx controller present in the i.MX25?
>>
> I got same errors with 2.6.31 kernel. As I suggested earlier use 2.6.35
> from Freescale.
> 
> git clone http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
> cd linux-2.6-imx
> git checkout rel_imx_2.6.35_11.04.01
> copy .config from your 2.6.31
> make ARCH=arm oldconfig
> make ARCH=arm menuconfig
> 
> It works for me well.
> Is your wifi card hard wired or plugined?
> 

Thanks for that information - using that kernel branch I have had it all
working properly, on both an 8686 and 8688 Marvell SDIO device. These
are both external (plugged in).

I was hoping to do a git bisect to determine where the fault lay,
however it seems that the imx tree uses a completely different SDIO
driver. I have validated the Libertas driver on a different CPU (atmel)
from the same kernel, so I'm assuming at this stage that the fault lies
in the SDIO driver in the current Linux mainline.

Regards,
Andre

-- 
Bluewater Systems - An Aiotec Company

Andre Renaud        		
andre at bluewatersys.com          5 Amuri Park, 404 Barbadoes St
www.bluewatersys.com            PO Box 13 889, Christchurch 8013
www.aiotec.co.nz                New Zealand
Phone: +64 3 3779127            Freecall: Australia 1800 148 751
Fax:   +64 3 3779135            USA 1800 261 2934
