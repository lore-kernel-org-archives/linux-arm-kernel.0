From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Fri, 19 Jan 2018 00:11:39 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.01.2018 13:34, Fabio Estevam wrote:
> Currently the kernel hangs when USB Host1 is enabled due to the lack of
> support for controlling the USB hub clock and GPIO reset line.
> 
> Peter Chen has made several attempts to fix this problem, but his series
> has not been applied yet, so better disable USB host1 for now to avoid
> the kernel hang.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Hmm, did you get reports or checked that it actually hangs?

As far as I remember last time I ran a kernel without Peter's power
sequence library on this board it only wasn't able to communicate with
the on-board USB hub (and devices behind it), but besides this was
able to boot successfully.
But my memory may be wrong since it was some time ago.

Maciej
