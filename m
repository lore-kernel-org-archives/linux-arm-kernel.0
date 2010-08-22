From: ccross@google.com (Colin Cross)
Date: Sat, 21 Aug 2010 18:04:43 -0700
Subject: [PATCH] arm: tegra: fix compilation of board-harmony.c
In-Reply-To: <20100818061843.GA32043@lixom.net>
References: <20100818061843.GA32043@lixom.net>
Message-ID: <AANLkTimHs97r-HAG-kCom30yYT1AeoV=E0OsQzQP17Xf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 11:18 PM, Olof Johansson <olof@lixom.net> wrote:
> The patch "ARM: Remove DISCONTIGMEM support" removed the node id from
> the meminfo struct and the PHYS_TO_NID macro, causing compilation errors:
>
> arch/arm/mach-tegra/board-harmony.c: In function 'tegra_harmony_fixup':
> arch/arm/mach-tegra/board-harmony.c:94: error: 'struct membank' has no member named 'node'
> arch/arm/mach-tegra/board-harmony.c:94: error: implicit declaration of function 'PHYS_TO_NID'
> arch/arm/mach-tegra/board-harmony.c:97: error: 'struct membank' has no member named 'node'
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> ?arch/arm/mach-tegra/board-harmony.c | ? ?2 --
> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 05e78dd..9e305de 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -91,10 +91,8 @@ static void __init tegra_harmony_fixup(struct machine_desc *desc,
> ?{
> ? ? ? ?mi->nr_banks = 2;
> ? ? ? ?mi->bank[0].start = PHYS_OFFSET;
> - ? ? ? mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> ? ? ? ?mi->bank[0].size = 448 * SZ_1M;
> ? ? ? ?mi->bank[1].start = SZ_512M;
> - ? ? ? mi->bank[1].node = PHYS_TO_NID(SZ_512M);
> ? ? ? ?mi->bank[1].size = SZ_512M;
> ?}
>
> --
> 1.5.6.5
>
>

Ack, queued for an rc pull request
