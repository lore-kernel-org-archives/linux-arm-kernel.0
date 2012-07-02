From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 2 Jul 2012 12:36:46 +0200
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <20120620143336.GE2253@S2101-09.ap.freescale.net>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
 <20120619181717.GE28394@pengutronix.de>
 <CACKLOr1zCp2NfLjBrHjtXpmsFMHqhoHFPpghN=Tyf3YAcyRrYg@mail.gmail.com>
 <20120620090126.GO28394@pengutronix.de>
 <20120620100015.GA30243@sirena.org.uk>
 <20120620130941.GB2253@S2101-09.ap.freescale.net>
 <CACKLOr28vm9n08VSOim=riB54os665be1CHdUqFXk+3MqPqtWQ@mail.gmail.com>
 <20120620143336.GE2253@S2101-09.ap.freescale.net>
Message-ID: <CACKLOr1oZZPZBNv+p9p3Vf5oY4K8K65_dJ5qkJO6NqeP2=2unw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
I almost have a final version ready which includes multi-instance
support (not tested though) [1]. As I stated, we assumed the extra
effort of looking at your code in [2] in order to provide a mechanism
that preserves compatibility between VPUs in i.MX21, i.MX51 and
i.MX53. This is the only thing left in order to send the driver for
mainline submission.

While I was reading your code I found out that you keep the following
formats for v1 (codadx6-i.MX27) codec:

static int vpu_v1_codecs[VPU_CODEC_MAX] = {
	[VPU_CODEC_AVC_DEC] = 2,
	[VPU_CODEC_VC1_DEC] = -1,
	[VPU_CODEC_MP2_DEC] = -1,
	[VPU_CODEC_DV3_DEC] = -1,
	[VPU_CODEC_RV_DEC] = -1,
	[VPU_CODEC_MJPG_DEC] = 0x82,
	[VPU_CODEC_AVC_ENC] = 3,
	[VPU_CODEC_MP4_ENC] = 1,
	[VPU_CODEC_MJPG_ENC] = 0x83,
};

As I understand, this means the following operations are supported:

1- H264 decoding.
2- H264 encoding
3- MP4 encoding.
4- MJPG  decoding.
5- MJPG encoding.

I totally agree with MP4 and H264 formats but, are you sure about
MJPG? I have a i.MX27 v1 codec (codadx6) but I didn't know that this
codec supported MJPG. Have you tested this code with an i.MX27 and
MJPG? Where did you find out that it supports this format? Are you
using firmware version 2.2.4 for v1 codecs?

Regards.

[1] git://github.com/jmartinc/video_visstrim.git
[2] git://git.pengutronix.de/git/imx/gst-plugins-fsl-vpu.git
[3] http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=i.MX27&nodeId=018rH3ZrDR66AF&fpsp=1&tab=Design_Tools_Tab

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
