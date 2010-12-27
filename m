From: claude.youn@gmail.com (Seungwhan Youn)
Date: Mon, 27 Dec 2010 10:31:09 +0900
Subject: [alsa-devel] [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio
	configuration
In-Reply-To: <20101224114904.GA15926@opensource.wolfsonmicro.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172938-23615-1-git-send-email-sw.youn@samsung.com>
	<20101224114904.GA15926@opensource.wolfsonmicro.com>
Message-ID: <AANLkTimPj554qSkpydNQWWbkX71qpZ9CwNfU+EmUATWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 8:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 24, 2010 at 03:42:18PM +0900, Seungwhan Youn wrote:
>
>> ? ? ? select S3C_DEV_HSMMC
>> + ? ? select SMDK_HAS_WM9710_AC97 if ASOC_SAMSUNG
>> ? ? ? help
>
> There's no need for the ifs here - since the actual machine driver is a
> user visible control and the SMDK_HAS_ are just dependencies for that
> it's more normal to just select the symbol.

The 'if' seems to be necessary, otherwise we get 'unmet direct
dependency' warning message and the menuconfig shows messed up.
