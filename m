From: jp.francois@cynove.com (jean-philippe francois)
Date: Fri, 17 May 2013 11:32:05 +0200
Subject: 3.9 regression : CAM_XCLKA wrong frequency setting.
Message-ID: <CAGGh5h2RB7OEOpGOe52eE8+LgdSmvDK5rPLueMzQMfVfOCuYHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Laurent, you are on the recipient list because the symptom is visible
throug your driver. I found the other name looking in the clock
related files. Please apologize if you are not concerned by this mail.

Symptom :
External clock CAM_XCLKA frequency is wrong with 3.9, it was ok until
3.6. Everything else is working fine, except the fps are higher, and
the image quality sucks because the input clock is out of spec.
Oscilloscope measured freq is around 30 MHz instead of the 24 MHz the
sensor is asking for.

Hardware :
dm3730, with 19.2 MHz crystal, running at OPP100

The register frequency settings seems to be ok, and they are the same
as in 3.6.11 :
CM_CLKSEL2_PLL : 0x04816807
        19, 2 * 360 / 8 = 864 MHz
         this value is already set when I look at it in u-boot

CM_CLKSEL_CAM : 0x5
        864 / 5 = 172,8 MHz
        this value is set through the clock framework by the omap3isp
driver code

ISP.TCTRL_CTRL : 0x7
        172,8 / 7 = 24,685... MHz
         this value is set by the omap3isp driver code

However, as stated before, the actual output frequency is NOT 24 MHz
but around 30.

If dpll4 frequency is wrong, what other clock would be affected ?
What can I do to debug this ?
Laurent, I believe you have a camera add-on board for the beagle xm,
could you test and report wether you can reproduce this bug ?

Attached is the boot log with 3.9, with some debugging messages activated.

Thank you for your help,
Regards,

Jean-Philippe Fran?ois
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 3.9dmesg
Type: application/octet-stream
Size: 28444 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/4fd9064f/attachment-0001.obj>
