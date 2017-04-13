From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Apr 2017 16:18:10 -0300
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
Message-ID: <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 4:03 PM, Tyler Baker <tyler.baker@linaro.org> wrote:

> I've been testing your GPC/PCIe patch sets against v4.11-rc5 on my
> imx7d-cl-som-imx7, but hit a bit of a wall. When gpc is set as the
> interrupt-parent for the soc, the kernel seems to hang and not produce
> any output on the serial port[0]. I tried to enable earlyprintk, but
> no luck getting a trace. Reversing this change, gets the board
> booting[1], but obviously isn't using the gpc which is needed for PCIe
> support as I understand it. I assume you've tested these changes on a
> imx7d-sdb and are not seeing a similar issue? You can find the patches
> I've picked on top of v4.11-rc5 here[2], any idea what might be the
> issue?

Thanks for the report.

It seems this series depends on the drivers/soc/imx/gpcv2.c patches
that landed into linux-next.

In this case, it would be better to re-send this series after
4.12-rc11 is out to avoid the breakage.
