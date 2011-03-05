From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 05 Mar 2011 15:36:11 +0300
Subject: [PATCH] [ARM] orion5x: fix compiler cast warnings in
	ts78xx-setup.c
In-Reply-To: <20110305113104.GB22117@chipmunk>
References: <20110305113104.GB22117@chipmunk>
Message-ID: <4D722E3B.8000608@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-03-2011 14:31, Alexander Clouter wrote:

> Signed-off-by: Alexander Clouter<alex@digriz.org.uk>
> ---
>   arch/arm/mach-orion5x/ts78xx-setup.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 82e57a6..78e3b9a 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -200,7 +200,7 @@ static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
>   	int sz;
>
>   	if (off) {
> -		sz = min(4 - off, len);
> +		sz = min((int) (4 - off), len);

    Maybe:

		sz = min_t(int, 4 - off, len);

WBR, Sergei
