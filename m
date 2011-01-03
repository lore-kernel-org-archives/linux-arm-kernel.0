From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 03 Jan 2011 14:33:21 -0800
Subject: [PATCH v5] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs From: Sudhakar Rajashekhara
	<sudhakar.raj@ti.com>
In-Reply-To: <1294059807-2723-1-git-send-email-michael.williamson@criticallink.com>
	(Michael Williamson's message of "Mon, 3 Jan 2011 08:03:27 -0500")
References: <1294059807-2723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <87ipy5d3da.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

I'm assuming the 'From:' line currently in the subject was supposed to
go here?

Kevin

> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
> In addition, the variant code for the AM-1808 SoC appears to match
> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
> these chips.
>
> This patch is originally from a patch on the arago project, here:
> http://arago-project.org/git/projects/?p=linux-omapl1.git;a=commit;h=6157618435e313a444cdf059702bd34036a6e2b7
>
> Further information related to the need for this patch can be located at
> http://e2e.ti.com/support/embedded/f/354/p/67290/248486.aspx
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-November/021224.html
>
> This patch was tested using an AM-1808 SoC on a MityARM-1808 SoM card.  It
> was also tested using a Rev 1.0 silicon OMAP-L138 on a MityDSP-L138F card.
>
> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
> Reported-by: Nicolas Luna <luna.id@gmail.com>
> ---
> Built against linux-davinci tree.
>
> Changes since v4.
>
>  - removed am18x code from 0 variant per Sekhar's request.
>
>  arch/arm/mach-davinci/da850.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 78b5ae2..1550ac3 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -764,6 +764,13 @@ static struct davinci_id da850_ids[] = {
>  		.cpu_id		= DAVINCI_CPU_ID_DA850,
>  		.name		= "da850/omap-l138",
>  	},
> +	{
> +		.variant	= 0x1,
> +		.part_no	= 0xb7d1,
> +		.manufacturer	= 0x017,	/* 0x02f >> 1 */
> +		.cpu_id		= DAVINCI_CPU_ID_DA850,
> +		.name		= "da850/omap-l138/am18x",
> +	},
>  };
>  
>  static struct davinci_timer_instance da850_timer_instance[4] = {
