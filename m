From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jan 2018 16:09:57 +0800
Subject: [linux-sunxi] [PATCH v4 3/6] clk: sunxi-ng: add support for
 Allwinner A64 DE2 CCU
In-Reply-To: <20171230113043.30237-4-icenowy@aosc.io>
References: <20171230113043.30237-1-icenowy@aosc.io>
 <20171230113043.30237-4-icenowy@aosc.io>
Message-ID: <CAGb2v65DiLg8QyT=BRHGJXUYLibP=wzYCj8ZW3hpWsF2miO2sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 30, 2017 at 7:30 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner A64's DE2 needs to claim a section of SRAM (SRAM C) to work.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Use a struct to maintain both ccu desc and quirks as Chen-Yu Tsai
>   suggested.

This made the patch slightly messy. Could you split it into two patches?
The first just adds the struct (without the sram_needed field) and migrates
everything to that. This patch should mention it is preperation for the
next patch, which adds the a field to the struct (otherwise it makes no
sense and just looks like churn.) The second patch will add the .sram_needed
field and support for the A64 DE2 CCU.


Thanks
ChenYu
