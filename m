From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Apr 2013 14:48:08 +0300
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <1547536.Us4pVspuI2@avalon>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F7245.2050606@iki.fi> <201304301228.42245.arnd@arndb.de>
 <1547536.Us4pVspuI2@avalon>
Message-ID: <517FAF78.1010306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2013 02:42 PM, Laurent Pinchart wrote:
> On Tuesday 30 April 2013 12:28:42 Arnd Bergmann wrote:
>> On Tuesday 30 April 2013, Tomi Valkeinen wrote:
>>> The bootloader would init the display hardware, the bootfb would give an
>>> early /dev/fb0 for the kernel and userspace, and when the real display
>>> driver is loaded, the bootfb would be unbound and the real driver would
>>> take over.
> 
> This could be done with a KMS driver as well ;-)

Right, I forgot to mention that. I had it in mind also =).

DRM has the same problem as fbdev with multi-arch and lots of display
and panel drivers.

Probably the same bootfb could be used for DRM also. Or do you see any
benefit of having a "bootkms" driver, or such?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130430/8b4c0b7f/attachment.sig>
