From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 14:13:05 +0200
Subject: [PATCH v7 17/22] mfd: omap-usb-host: clean up omap_usbhs_init()
In-Reply-To: <20130117114804.GG18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-18-git-send-email-rogerq@ti.com>
 <20130117114804.GG18978@arwen.pp.htv.fi>
Message-ID: <50F7EAD1.8050107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 01:48 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jan 17, 2013 at 01:30:26PM +0200, Roger Quadros wrote:
>> +	if (is_omap_usbhs_rev1(omap))
>> +		reg = omap_usbhs_rev1_hostconfig(omap, reg);
>> +	else if (is_omap_usbhs_rev2(omap))
>> +		reg = omap_usbhs_rev2_hostconfig(omap, reg);
> 
> Any way you could maybe:
> 
> rev = omap_usbhs_revision(omap)
> switch(rev) {
> case REV1:
> 	foo();
> 	break;
> case REV2:
> 	bar();
> 	break;
> default:	/* highest revision */
> 	baz();
> }
> 
> could be done in a later patch however.
> 
I'll fix it in this series.

--
cheers,
-roger
