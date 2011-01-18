From: claudiu.covaci@gmail.com (Claudiu Covaci)
Date: Tue, 18 Jan 2011 14:33:30 +0100
Subject: camera on Freescale i.MX51
Message-ID: <AANLkTi=jDE3=J67c1KRQ7XxWY2Q2itaump1JWvLwFkET@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm have trouble receiving a video stream on the Freescale i.MX51
processor. I've tried everything I could think, so I'm trying my luck
here.

I'm using a 2.6.31 kernel with some modifications: the camera capture
driver [1] and the IPU (Image Processing Unit) driver [2] from the
Freescale BSP 2010.11.

I'm at a point where I can open the /dev/video0 device and can (at
least try to) read frames, but it fails at dequeueing the video
buffers (VIDIOC_DQBUF) with the message:
<3>ERROR: v4l2 capture: mxc_v4l_dqueue timeout enc_counter 0
Unable to dequeue buffer (62).

- I've double-checked the IPU registers and they seem properly
configured, but I don't get any interrupt (at end-of-frame).
- The relevant IOMUX pins are also configured.
- the video signal appears at the i.MX pins (so it gets there)
- I've also tried activating the internal picture generator, but still
nothing happens.

Is there anything I overlooked? Is there a way to find out where the
problem is? Any hints will be greatly appreciated.

Thanks!
Claudiu

[1] http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=drivers/media/video/mxc/capture/mxc_v4l2_capture.c;h=8133d202304eea22e94bbd8eaaa215002b2dc675;hb=0fae922f451a5bde63595a2e0c2cd7079f083440

[2] http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=tree;f=drivers/mxc/ipu3;h=288c21f88aa650d16d843dccec2b04ba9f1462f7;hb=0fae922f451a5bde63595a2e0c2cd7079f083440
