From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Sep 2016 09:34:45 +0200
Subject: [PATCH] ARM: dts: exynos: Add reboot reason support for Trats2
In-Reply-To: <87fuopvwjy.fsf@machinist.wiedmeyer.de>
References: <20160922205522.GA15917@kozik-lap>
 <87fuopvwjy.fsf@machinist.wiedmeyer.de>
Message-ID: <20160925073445.GA2469@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 11:04:49PM +0200, Wolfgang Wiedmeyer wrote:
> 
> Krzysztof Kozlowski writes:
> 
> > On Thu, Sep 22, 2016 at 08:59:03PM +0200, Wolfgang Wiedmeyer wrote:
> >> 
> >> Krzysztof Kozlowski writes:
> >> 
> >> > On Thu, Sep 22, 2016 at 06:48:35PM +0200, Wolfgang Wiedmeyer wrote:
> >> >> This allows to reboot the device into recovery mode and into the download
> >> >> mode of the bootloader.
> >> >
> >> > Which bootloader? Probably UBoot... or Samsung stock one? Could you put
> >> > that information here?
> >> 
> >> I'm only working with the stock one. I was under the impression that the
> >> stock bootloader cannot be replaced on a i9300 because there's a
> >> signature check. Is UBoot loaded after the stock one on Trats2 or how
> >> does this work? I didn't find information on that.
> >
> > +CC Marek,
> >
> > Trats2 is working with U-Boot. Just U-Boot. However I never converted S3
> > into Trats2 on my own. I always used targets prepared to be "Trats2"
> > type. 
> 
> It would be awesome to be able to run U-Boot on i9300. Is there a way to
> test this by not risking to brick the device, e.g. by booting from the
> SD card? Then I could send an updated version of the patch that is
> compatible with U-Boot :)

I don't think the stock bootloader supports chaining another bootloader
from SD card. There is a way of booting from SD card by shortening a
resistor but it is an emergency rescue procedure to overwrite existing
bootloader with data from SD card (to restore device). This thread might
be interesting:
http://forum.xda-developers.com/showpost.php?p=47234165&postcount=220
https://smyl.es/samsung-galaxy-iii-s3-gt-i9300-jtag-leaked-document-how-to-repair-soft-bricked-galaxy-s3/

On xda-developers you might find more data about this (including the
procedure for emergency restore from SD card). Somehow people flash and
unbrick their devices when playing with CyanogenMod...

Best regards,
Krzysztof
