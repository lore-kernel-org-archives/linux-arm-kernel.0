From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 23 Sep 2014 16:10:34 +0200
Subject: [PATCH] [media] s5p-mfc: Use decode status instead of display
 status on MFCv5
In-Reply-To: <085901cfd736$6ae349c0$40a9dd40$%debski@samsung.com>
References: <1411390322-25212-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <085901cfd736$6ae349c0$40a9dd40$%debski@samsung.com>
Message-ID: <1411481434.4050.16.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kamil,


On Tue, 2014-09-23 at 15:58 +0200, Kamil Debski wrote:
> > Commit 90c0ae50097 changed how the frame_type of a decoded frame
> > gets determined, by switching from the get_dec_frame_type to
> > get_disp_frame_type operation. Unfortunately it seems that on MFC v5
> > the
> > result of get_disp_frame_type is always 0 (no display) when decoding
> > (tested with H264), resulting in no frame ever being output from the
> > decoder.
> 
> Could you tell me which firmware version do you use (date)?

I'm using the firmware version as included in
http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/

Unfortunately there is no specific version information included about
the firmware. The commit that added it is fb5cda9c70277f6 dated Nov 28
17:43:06 2012 +0530, so that at least gives some information about the
time-frame.


-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140923/5cc9f3ec/attachment-0001.bin>
