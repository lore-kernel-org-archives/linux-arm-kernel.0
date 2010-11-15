From: archit@ti.com (Taneja, Archit)
Date: Mon, 15 Nov 2010 09:35:04 +0530
Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
In-Reply-To: <AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
	<AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C012B11@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

bryan.wu at canonical.com wrote:
> On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen

[snip]

>> 
>> For both panel power on and off some panels require some sleep times:
>> when powering on, the video interface has to be enabled for some time
>> before the panel can be enabled, and similarly when powering off the
>> video interface needs to be on for some time after the panel has been
>> disabled. 
>> 
> 
> Actually, in my previous version patches, I introduced
> .power_on_delay and .power_off_delay in panel_configs, which
> contains the sleep value for msleep(). But Archit told me
> this is not necessary, so I removed that.

I had asked you to remove it from omap_dss_device to a more
specific struct for the generic dpi driver :)

It should be in the 'panel_generic_dpi_data' struct now.

Regards,
Archit
