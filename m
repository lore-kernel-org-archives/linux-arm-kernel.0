From: horms@verge.net.au (Simon Horman)
Date: Sat, 31 Jan 2015 13:17:34 +0900
Subject: [PATCH] ARM: shmobile: alt dts: Drop console= bootargs parameter
In-Reply-To: <54CBFC63.4070808@cogentembedded.com>
References: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
 <54CBFC63.4070808@cogentembedded.com>
Message-ID: <20150131041731.GA7605@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sat, Jan 31, 2015 at 12:49:23AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/04/2014 07:23 AM, Simon Horman wrote:
> 
> >Alt is booted from DT, so chosen/stdout-path is
> >always used, and we can drop the "console=" parameter from chosen/bootargs.
> 
> >This change has a side-effect of changing the console speed from 38400
> >to 115200. This is intentional as 115200 is consistently used on
> >all other shmobile boards.
> 
>    I'd say it's not very practical to change the console's baud rate from
> U-Boot's default

It is consistent with the handling of all other boards with
renesas SoCs that are present in mainline.

> (AFAIR changing baud rate in U-Boot didn't work)...

Perhaps that relates to the version of built of uboot.
On the board I have access to I see:

ver=U-Boot 2013.01.01-g5df9446 (Oct 01 2014 - 14:59:23)

And the following setting altered the baud rate of u-boot (IIRC).

baudrate=115200

> >Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >Cc: devicetree at vger.kernel.org
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> >index 8aec512..f2cf757 100644
> >--- a/arch/arm/boot/dts/r8a7794-alt.dts
> >+++ b/arch/arm/boot/dts/r8a7794-alt.dts
> >@@ -20,7 +20,7 @@
> >  	};
> >
> >  	chosen {
> >-		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> >+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> 
>    Hm, does this even work as intended? I've tried to boot another R8A7794
> based board and I couldn't get any output with alike command line. Booting
> with 'earlyprintk=serial' has shown that tty0 was enabled as a console which
> is not what we wanted.

If you are backporting this change then I believe it has some dependencies
that I can follow up on if it is useful to you.

If you are using mainline (e.g. next or renesas-next) then yes,
it works. I have tested it numerous times since the patch was merged.
