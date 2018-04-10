From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Apr 2018 11:11:43 +0200
Subject: A200 driver submission for Linux mainline kernel
In-Reply-To: <01f5f95e-d957-bc32-b8a8-94784523d095@gmail.com>
References: <01f5f95e-d957-bc32-b8a8-94784523d095@gmail.com>
Message-ID: <1523351503.4981.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhijit,

Am Dienstag, den 10.04.2018, 13:28 +0530 schrieb abhijit:
> Hi All,
> 
> I have tested A200/Z430 3D driver for Freescale IMX535/537 SoC by using?
> port from freedreno. I wanted to submit driver patch to linux 4.14.1 for?
> mainlining A200 driver support
> 
> Currently w.r.t 4.14.1 kernel, the patch has, 109 files changes, 279170?
> insertions, 60 deletions
> 
> Major part of the code is taken from A200 support from Freescale Linux?
> (2.6.35,?
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/?h=imx_2.6.35)
> 
> My question was, can I submit the patch for Linux 4.14.1 kernel for?
> mainlining purpose instead of linux-next?
> 
> Please point me to any case-study where such huge enhancements were?
> mainlined in the past.
> 
> Any suggestions for optimizing the mainlining process?

The downstream driver will not be acceptable to mainline. It's not just
the size of the driver itself, but it's just full of cruft and doesn't
integrate with any of the modern kernel frameworks.

If you are going to mainline this driver, it likely needs a full
rewrite as a proper DRM driver, with a userspace interface sanctioned
by the Linux DRM community.

Regards,
Lucas
