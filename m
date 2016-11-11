From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 11 Nov 2016 18:24:48 +0200
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <20161111152700.GD1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <964260d7-af7f-fefb-2adb-0e10ff750883@ti.com>
 <20161111152700.GD1041@n2100.armlinux.org.uk>
Message-ID: <2f1bc473-1d78-b37a-0c1c-2b8c661477cf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/16 17:27, Russell King - ARM Linux wrote:
> On Fri, Nov 11, 2016 at 05:10:09PM +0200, Jyri Sarha wrote:
>> On 11/08/16 14:24, Russell King - ARM Linux wrote:
>>> As no one responded to the previous round, I'm not spending soo much
>>> time writing up a description of these changes again.  It's also been
>>> quite a long time, so I've forgotten all the details of the changes,
>>> so I'll do my best.
>>>
>>> Changes from the previous series include:
>>> - reorder the initial three patches
>>> - change the (now third patch)... I think to increase the size of the
>>>   locked region.
>>> - fix edid parsing for infoframe generation - as was pointed out for
>>>   dw-hdmi, parsing the EDID in get_modes() is incorrect, as that method
>>>   will not be called when an override-edid is in effect.  We need to
>>>   parse the override-edid.  Moreover, infoframe generation should not
>>>   be keyed to whether the monitor is HDMI or not, CEA-861B allows non-
>>>   HDMI to send infoframes.
>>> - only send audio if audio and infoframes are supported.
>>>
>>> Otherwise, these are very much like the previous posting of the series,
>>> except rebased upon the mali/hdlcd/tda998x change to remove the
>>> drm_connector_register() call.
>>>
>>> https://www.spinics.net/lists/dri-devel/msg121495.html
>>>
>>> It'd be nice to have other tda998x users ack and test these patches,
>>> I've tried to test on Juno, but the Juno situation seems to be a huge
>>> fail.  (HBI0282B completely fails with latest firmware - (a) FPGA image
>>> incompatibilities io_b118 causes all FPGA AMBA devices to vanish, (b)
>>> seems no way to get SCPI support on it - adding the BL0 executable
>>> start address in the SCC registers seems to be incompatible with the
>>> devchip, causing the PLLs to fail.  In discussion with Sudeep over
>>> these issues, but no idea where things are with it at the moment, other
>>> than Sudeep needs to investigate.  All Linaro firmware releases are
>>> broken on HBI0282B.)
>>>
>>>  drivers/gpu/drm/i2c/tda998x_drv.c | 826 ++++++++++++++++++++------------------
>>>  1 file changed, 429 insertions(+), 397 deletions(-)
>>>
>>
>> Reviewed-by: Jyri Sarha <jsarha@ti.com>
>>
>> For the whole series. I am also happy to test these patches if I can
>> fetch them from some git repo.
> 
> git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
> 
> The commit IDs are unstable, because I'll have to recommit them to add
> your r-by and any other tags you later give me. :)
> 

I tested the branch with my Beaglebone-black and couple of TVs. I played
audio on different sample-rates while plugging and unplugging the cable
to the TVs and changing video modes. Everything worked as it should. I
let you decide whether or not this adhoc testing qualifies:

Tested-by: Jyri Sarha <jsarha@ti.com>

Best regards,
Jyri
