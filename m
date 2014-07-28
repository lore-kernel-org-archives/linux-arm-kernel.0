From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 28 Jul 2014 18:39:46 +0200
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <53D677B1.2000700@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <53D677B1.2000700@suse.de>
Message-ID: <53D67CD2.9040200@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 06:17 PM, Andreas F?rber wrote:
> Hi Lars-Peter,
>
> Am 25.07.2014 01:00, schrieb Andreas F?rber:
>> most notably I'm missing
>> ADI ADV7513 and AXI-HDMI support
> [...]
>> Cc: Lars-Peter Clausen <lars@metafoo.de> (HDMI)
>
> Could you please enlighten us what the status of upstreaming
> ADV7511/ADV7513 support is? It is declared "work in progress" here:
>
> http://wiki.analog.com/resources/tools-software/linux-drivers/drm/adv7511
>
> I see some adv7511 V4L bits in drivers/media/i2c/adv7511.c, but no
> drivers/gpu/drm/i2c/adv7511_{core,audio}.c as on the xcomm_zynq branch,
> nor any devicetree documentation. Patchwork doesn't show any recent
> submissions to LKML.
>
> Is any major rework needed for you to get the 3.14.12 based driver upstream?
>

It's complicated. The plan for the driver was to wait for the common display 
framework (CDF) and convert it to use CDF and then submit it upstream. The 
CDF has been rejected though. Meanwhile the V4L2 adv7511 driver has been 
merged. So now we are in the ugly situation that we have two different 
drivers for two different frameworks. To fix this we need to merge these two 
drivers while still exposing the interfaces to both frameworks.

> AXI SPDIF I found in 3.16, as you noticed; what about AXI HDMI? [*]
> Is there any work ongoing to get that upstream as well?

We need to teach the DMAengine framework about cyclic interleaved transfers 
before the AXI HDMI driver can be submitted upstream.

- Lars
