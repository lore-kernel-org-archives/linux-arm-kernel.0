From: rick@efn.org (Rick Bronson)
Date: Fri, 19 Oct 2012 11:07:14 -0700
Subject: imx-sdma.c broken on imx53 for sound
Message-ID: <39c8a3f022e86d3eae0fb7b6e48049f1.squirrel@webmail.efn.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  On the iMX53, the sound chip sgtl5000 seems to get SDMA channel 0, but
this code in drivers/dma/imx-sdma.c:

	/* not interested in channel 0 interrupts */
	if (sdmac->channel == 0)
		return;

 causes the DMA to be ignored.  If I comment out the above, I still get no
sound...

  Anyone have any ideas?

  Thanks much for any help.

  Rick
