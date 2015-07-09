From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 9 Jul 2015 23:54:36 +0200
Subject: musb-hdrc: "Vbus off,
 timeout 1100 msec" message does not belong in sysfs
In-Reply-To: <20150709214610.GA20890@amd>
References: <20150709213922.GA32698@amd> <20150709214610.GA20890@amd>
Message-ID: <201507092354.36649@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 July 2015 23:46:10 Pavel Machek wrote:
> On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> > Hi!
> > 
> > sysfs should contain one value per file. This one has at least two,
> > with nice english sentence as a bonus.
> > 
> > root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/mu
> > sb-hdrc.0.auto# cat vbus
> > Vbus off, timeout 1100 msec
> > 
> > :-(.
> 
> Plus, documentation for this is nowhere to be seen:
> 
> pavel at amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> pavel at amd:/data/l/linux-n900$
> 
> ..which is a shame, because it is not really clear how to use this
> one:
> 
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# cat mode
> b_idle
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_suspend > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_host > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo b_host > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_idle > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo b_wait_acon > mode
> -bash: echo: write error: Invalid argument
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto#
> 
> 
> 									Pavel

Hi!

I remember that this file is used for switching between usb peripheral 
and host mode. But because n900 HW somehow broken, for usb host mode are 
needed couple of "hack" patches which workaround HW bugs... This is 
still not enough and "support" from userspace is needed for it too.

Kernel patches are part of Maemo kernel-power 2.6.28 version and with 
package usbmode http://maemo.org/packages/view/usbmode/ is it possible 
to enter usb host mode on n900 (and then connect e.g. usb stick).

And IIRC correct command is:

# echo host > mode
# echo peripheral > mode

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/4145c2fd/attachment.sig>
