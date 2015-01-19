From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 14:01:16 +0100
Subject: [PATCH fix for 3.19] ARM: dts: sun4i: Add simplefb node with
 de_fe0-de_be0-lcd0-hdmi pipeline
Message-ID: <1421672477-12978-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

As I already mailed you about yesterday as a headsup here is a fix for
the simplefb dt nodes introduced for sunxi in 3.19, I would like to get
this into 3.19 to avoid the need for carrying compatibility code for the old
nodes in u-boot (as 3.19 is going to be the first kernel release with sunxi
simplefb support).

>From the commit message of the attached patch:

###

Testing has shown that on sun4i the display backend engine does not have
deep enough fifo-s causing flickering / tearing in full-hd mode due to
fifo underruns. This can be avoided by letting the display frontend engine
do the dma from memory, and then letting it feed the data directly into
the backend unmodified, as the frontend does have deep enough fifo-s.

Note since u-boot-v2015.01 has been released using the de_be0-lcd0-hdmi
pipeline on sun4i, we need to keep that one around too (unfortunately).

###

I've send a patch to the u-boot mailinglist this morning to make u-boot
v2015.04 (and later) use a de_fe0-de_be0-lcd0-hdmi pipeline on sun4i thus
fixing the tearing / flickering.

Can you please queue this patch up as a fix for 3.19 ?

Thanks & Regards,

Hans
