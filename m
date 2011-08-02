From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 2 Aug 2011 08:42:20 +0200
Subject: [PATCH] CSR: add missing sentinels to of_device_id tables
In-Reply-To: <1312229376-5982-1-git-send-email-jamie@jamieiles.com>
References: <1312229376-5982-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20023.40012.119095.724255@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jamie Iles writes:
> The of_device_id tables used for matching should be terminated with
> empty sentinel values.
> 
> Cc: Barry Song <baohua.song@csr.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/mach-prima2/clock.c |    1 +
>  arch/arm/mach-prima2/irq.c   |    1 +
>  arch/arm/mach-prima2/rstc.c  |    1 +
>  arch/arm/mach-prima2/timer.c |    1 +
>  4 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
> index f9a2aaf..615a4e7 100644
> --- a/arch/arm/mach-prima2/clock.c
> +++ b/arch/arm/mach-prima2/clock.c
> @@ -481,6 +481,7 @@ static void __init sirfsoc_clk_init(void)
>  
>  static struct of_device_id clkc_ids[] = {
>  	{ .compatible = "sirf,prima2-clkc" },
> +	{},
I would add a comment like '/* end of list sentinel */' inside the
'{}' to make it crystal clear that the empty braces are intentional.
I also would omit the comma since it would be an error adding more
entries after this one.



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
