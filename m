From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 27 Aug 2014 09:44:04 +0200
Subject: [PATCH 0/2 v2] Fix Exynos peach USB on kernels with USB Gadget
 support
In-Reply-To: <53FD3D97.3010002@suse.de>
References: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <53FD3D97.3010002@suse.de>
Message-ID: <1409125444.31096.44.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-08-27 at 04:08 +0200, Andreas F?rber wrote:
> Hi,
> 
> Am 26.08.2014 09:30, schrieb Sjoerd Simons:
> > I suspect other boards base using exynos5420/5800 might need the similar fixes
> > (Arndale Octa and Samsung SMDK5420) to their dts files, so would be great if
> > folks with those board could verify this.
> 
> usbdrd_dwc3_1 is indeed required for the Arndale Octa. Not sure about 0.
> 
> I tested my attaching a USB 3.0 disk - is there an easier way to tell?

That seems to be the easiest way to tell. In my testing when things
broke no USB host functionality would work, so USB 3 isn't a
requirement.  You can also build with USB_DWC3_DEBUG enabled and check
the mode file it generates in debugfs to see & set the controller mode
to see how it gets setup by default and change the mode without
rebuilding the dts.

>From looking at the board on the arndaleboard wiki[0], it looks like it
has one USB 3 host (which i guess is usbdrd_dwc3_1?) and a USB 2 OTG
port which might be usbdrd_dwc3_0 (in which case the default setting for
otg is correct). 


0: http://www.arndaleboard.org/wiki/index.php/O_WiKi#Detail_of_Arndale_Board

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/e7fd14cd/attachment.bin>
