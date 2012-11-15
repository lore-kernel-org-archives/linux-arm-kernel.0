From: b32955@freescale.com (Huang Shijie)
Date: Thu, 15 Nov 2012 11:20:35 +0800
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <50A21613.6030709@bluegiga.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
 <1351074456-25863-3-git-send-email-b32955@freescale.com>
 <50A21613.6030709@bluegiga.com>
Message-ID: <50A45F83.1010009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?11?13? 17:42, Lauri Hintsala ??:
> Hi Huang,
>
> DMA support doesn't work with latest stable v3.6.5 or development 
> 3.7-rc5 kernels. I get following error message when I open the serial 
> port /dev/ttyAPP0:
>
> [ 48.730000] mxs-auart 8006a000.serial: step 1 error
> [ 48.750000] mxs-auart 8006a000.serial: We can not start up the DMA.
>
I tested this patch set in imx28-evk board Rev C with linux-next-20121114.
it works fine.

Maybe you can try the linux-next code.

About the flow control:
If we do not enable the HW flow control, the data may lost. And I do not 
know how to handle with the Xon/Xoff when the DMA is supported.

Best Regards
Huang Shijie
