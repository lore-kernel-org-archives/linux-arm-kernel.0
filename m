From: brendanhiggins@google.com (Brendan Higgins)
Date: Fri, 16 Mar 2018 05:52:14 +0000
Subject: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
In-Reply-To: <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
Message-ID: <CAFd5g44NOFRmQbDJfRLw_SwsHwVB-hxsUYMYSmkqeyRKmXqSqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Enable L2 Cache in Nuvoton NPCM7xx BMC.

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   arch/arm/mach-npcm/npcm7xx.c | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
> index 5f7cd88103ef..c5f77d854c4f 100644
> --- a/arch/arm/mach-npcm/npcm7xx.c
> +++ b/arch/arm/mach-npcm/npcm7xx.c
> @@ -17,4 +17,6 @@ static const char *const npcm7xx_dt_match[] = {
>   DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
>          .atag_offset    = 0x100,
>          .dt_compat      = npcm7xx_dt_match,
> +       .l2c_aux_val    = 0x0,
> +       .l2c_aux_mask   = ~0x0,

You need to limit this to the specific bit(s) you want to set and verify
that
the l2c driver does not already manage that bit appropriately and that it
can
not be specified via the dtsi.

We discussed this a little while ago with Rob here:
https://www.spinics.net/lists/arm-kernel/msg613372.html

>   MACHINE_END
> --
> 2.14.1


Cheers
