From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 14 Dec 2009 13:12:30 -0500
Subject: GPIO support for HTC Dream
In-Reply-To: <1260813293.13078.15.camel@c-dwalke-linux.qualcomm.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<1260813293.13078.15.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200E9C6@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 14, 2009 10:55 AM, Daniel Walker wrote:
> On Mon, 2009-12-14 at 07:45 +0100, Pavel Machek wrote:
>> Hi!
>> 
>>> This looks MUCH better!
>> 
>> Thanks :-).
>> 
>>>> arch/arm/Kconfig                     |    1
>>>> arch/arm/mach-msm/board-dream-gpio.c |  327 +++++++++--------------------------
>> ...
>>> Please update (or remove) this diffstat.  It no longer matches the patch.
>> 
>> I was just showing differences to _previous_ version, not what I was sending.
>> 
>>> Ok.  The hardware still seems a bit strange. Is there any datasheet
>>> available?
>> 
>> I don't think there is one. Daniel, can you help here?
>
> I don't know if there is one or not (I'd guess not).. I can't release
> documents, but I could try to address specific questions or find people
> to answer specific questions.

Hello Daniel,

My specific question was about the gpio hardware registers.

>From Pavel's implementation it appears that the gpio's are organized as a
number of 8-bit ports.  Each of these ports only have one 8-bit register.
Writing a '1' to a bit in the register makes the associated pin a high-level
output.  Writing a '0' makes the pin a low-level output or an input pin.
Reading the port at this point will return the actual 'input' level of the pin.

The hardware seems a bit strange and I just wanted to verify that this is
correct.  If it is, this would explain the need to keep the 'shadow' contents
of the port in order to set the 'direction' of a pin.

I was also wondering if the initial 'shadow' value needs to be written to the
port at init in order to correctly establish the output value for specific
pins.

One other thing.  Are the gpio's handled by Pavel's driver actually from the
MSM chip or from an external CPLD?  The registers are all defined as:

+		.reg = reg_num + DREAM_CPLD_BASE,

If they are external from the MSM chip this driver should probably be renamed
to something more appropriate since it is probably dream specific and not
generic to the msm architecture.

Thanks for the help,
Hartley
