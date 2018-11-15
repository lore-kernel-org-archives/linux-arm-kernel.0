From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 15 Nov 2018 14:04:00 +0100
Subject: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
 <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
 <20181105165321.7ea2b45f@bbrezillon>
 <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
 <20181106102851.61deb97a@bbrezillon>
 <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
 <20181106112206.65a70a81@bbrezillon>
 <20181112171351.4ac3506b@xps13>
 <20181112175416.247e3203@bbrezillon>
 <20181112184518.6c02ac6d@bbrezillon>
 <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
Message-ID: <20181115140400.3934effe@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liang,

Liang Yang <liang.yang@amlogic.com> wrote on Thu, 15 Nov 2018 19:25:07
+0800:

> Hi Boris,
> 
> I have implemented dma access base on these helpers you provided below.
> we prepare to send v7 version now, so when will these helpers be pushed?

Thanks for your work. You can send the v7 so we will have a look at the
overall driver; but since we raised the DMA buffers issue we had a
discussion with Boris about how to handle them and I think we are going
to adopt the same solution as Wolfram in the I2C subsystem: manual
flagging. Sadly, this is probably the best we can do to ensure proper
DMA support.

There is nothing set is stone yet but I started a small rework to
handle MTD operations differently (and add a DMA_SAFE flag), you can
have a look there [1]. Don't base your work on it for now as it is just
a preliminary version, subject to big changes.

[1] https://github.com/miquelraynal/linux/commits/dma-safe-buffers

Thanks,
Miqu?l
