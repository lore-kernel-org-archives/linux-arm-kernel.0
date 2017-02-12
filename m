From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Feb 2017 13:02:52 +0100
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
In-Reply-To: <3faadfcb-5e0d-8f92-3e91-4bd745026644@tul.cz> (Petr Cvek's
 message of "Sun, 12 Feb 2017 02:15:43 +0100")
References: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
 <87shnt1sue.fsf@belgarion.home>
 <3faadfcb-5e0d-8f92-3e91-4bd745026644@tul.cz>
Message-ID: <8737fj1us3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Hi
>
> any news?

Yeah, I don't have the error on my mainstone, which kind of hinders my debug
capability.

I have tried your script, and this is what I get :
  - dmesg | tail
	random: crng init done
	gadgetfs: USB Gadget filesystem, version 24 Aug 2004
	configfs-gadget gadget: uvc_function_bind
	[DEBUG] opts->streaming_maxpacket=256
	====name: ep1in-int, mp=16
	====name: ep1in-int, mp=16
	====name: ep2in-int, mp=16
	====name: ep3out-int, mp=16
	====name: ep4in-iso, mp=256
  - lsmod
	Module                  Size  Used by    Not tainted
	usb_f_uvc              40752  6 
	libcomposite           38099 14 usb_f_uvc
	pxa27x_udc             21131  0 
	gadgetfs               16173  0 
	videobuf2_vmalloc       4659  1 usb_f_uvc
	videobuf2_memops        1421  1 videobuf2_vmalloc

This was tried on a mainstone board, upon mainline kernel v4.8-rc3 with your
patch. but without an actual camera nor the USB cable attached to a host USB.

Cheers.

-- 
Robert
