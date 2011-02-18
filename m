From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 18 Feb 2011 15:11:11 +0100
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <20110217181849.GV20795@atomide.com>
References: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
	<4D5D44AF.5050805@ti.com> <20110217162000.GP20795@atomide.com>
	<20110217162209.GA13425@legolas.emea.dhcp.ti.com>
	<20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com>
	<20110217171747.GC14574@legolas.emea.dhcp.ti.com>
	<4D5D59E5.6020307@ti.com>
	<20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
Message-ID: <4D5E7DFF.7020609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

On 2/17/2011 7:18 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110217 09:45]:
>>
>> Done, boot tested, and that does remove the warning about the
>> missing opt clock you had with the previous data.
>>
>> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
>>
>> Just let me know if it does break anything else.
> 
> Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
> and devel-mcspi branches.

McSPI OMAP4 hwmod data are missing a couple of flags that break the boot for the moment.

Govindraj should rebase on the omap4_hwmod_data branch and add the missing rev and dev_attr for the McSPI.

Unfortunately, even with that patch omap-for-linus boot hangs after the following trace:

[    0.875091] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
[    0.886657] usbcore: registered new interface driver usbfs
[    0.892822] usbcore: registered new interface driver hub
[    0.898681] usbcore: registered new device driver usb
[    0.904815] omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz


Regards,
Benoit
