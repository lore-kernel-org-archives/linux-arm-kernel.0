From: eric@eukrea.com (Eric Benard)
Date: Wed, 23 Feb 2011 17:48:11 +0100
Subject: [PATCH v3] Add i.MX51/53 IPU framebuffer support
In-Reply-To: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D653A4B.4050405@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 16/02/2011 15:10, Sascha Hauer wrote:
> The following is the third version of the series adding ipu support
> for the i.MX51/53.
>
> Changes since last version:
>
> - The IPU core driver now sits in drivers/video instead of drivers/mfd.
>    It still needs mfd support, so it has a select on MFD_SUPPORT and
>    MFD_CORE.
> - The fb driver does not reallocate memory anymore. This is broken since
>    there is a risk that some userspace process still has the memory mapped
>    while we reallocate it which leads to bad results.
>
> Sascha Hauer (7):
>        Add a mfd IPUv3 driver
>        fb: export fb mode db table
>        Add i.MX5 framebuffer driver
>        ARM i.MX51: Add IPU device support
>        ARM i.MX5: Allow to increase max zone order
>        ARM i.MX5: increase dma consistent size for IPU support
>        ARM i.MX51 babbage: Add framebuffer support
>
for the whole serie except the last one concerning babbage :
Tested-by: Eric B?nard <eric@eukrea.com>

Eric
