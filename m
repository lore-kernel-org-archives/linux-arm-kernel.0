From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Oct 2017 12:19:05 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026120130.dicanunwcdmjntnb@earth>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth>
Message-ID: <20171027101905.GA4287@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

So I got it to work; here are my notes from debugging. I put them on
https://elinux.org/N950 , too.

If someone knows how to fix the backlight, it would still be useful.

Best regards,
								Pavel
								

Run your kernels with something like:

# power off your phone
sudo ../maemo/0xffff/src/0xFFFF -l -m kernel:arch/arm/boot/$IMG -b
# plug in the phone.
Your usually get an error here:

Waiting for ASIC ID...
Error: Invalid size of ASIC ID
Error: Reading ASIC ID failed
Error: No device detected
^C

Hit ^c, and restart 0xFFFF. You should get

Sending image...
  100% [#################################################################]
Done

now.

You should get /!\ Warning! screen now. Some bootloader versions way
for ~10 seconds, some don't. Some bootloader versions power off
immediately if you attempt to supply command line arguments.

Watch the screen. It will go dark. If it blinks, it is a good
sign. You may want to check with flashlight, maybe there's almost
invisible text there.

Ignore the notification LED. It seems to blink even without kernel involvement.

Keyboard "debug enabled" LED can be used for debugging.




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/9a0f765d/attachment-0001.sig>
