From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Thu, 7 Dec 2017 22:23:18 +0530
Subject: [PATCH] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
In-Reply-To: <20171207133409.cpp7wxx4yflkgavp@flea.lan>
References: <1512644748-14491-1-git-send-email-jagan@amarulasolutions.com>
 <20171207133409.cpp7wxx4yflkgavp@flea.lan>
Message-ID: <CAD6G_RQkBWth6iygyGfBX_rROEM7XUh3BmvoXfsxm8=po+kksQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 7:04 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Dec 07, 2017 at 04:35:48PM +0530, Jagan Teki wrote:
>> Add usb otg support for orangepi-zero-plus2 board:
>> - Add usb_otg node with dr_mode as 'otg'
>> - USB0-IDDET connected to PA21
>> - VBUS connected through DCIN which always on
>>
>> Tested mass storage function.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Did you test the OTG or peripheral modes?

dr_mode with otg and I've tested mas storage gadget with mmc disk emulation.

>
>> Note: Anyone please check vbus connection [1]
>> Since it is connected through DCIN of vcc-5v, I've added vcc-5v0
>> regulator for the same and attached to usb0_vbus-supply but it is
>> disabling during kernel boot.
>> [    1.887854] vcc5v0: disabling
>
> VBUS is the power line that is provided on the USB connector. In
> peripheral, that power is provided by the host, therefore it needs to
> be shutdown on the peripheral end. This is the expected behaviour.

So, in my test with 'otg' host drive the vbus so-it is disabling at
target end is it?

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
