From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 05 Mar 2011 15:30:58 +0300
Subject: [PATCH 2/2] ARM: Enable TS-78XX features in unknown revisions
In-Reply-To: <1299299957-13018-2-git-send-email-mspang@csclub.uwaterloo.ca>
References: <1299299957-13018-1-git-send-email-mspang@csclub.uwaterloo.ca>
	<1299299957-13018-2-git-send-email-mspang@csclub.uwaterloo.ca>
Message-ID: <4D722D02.5090504@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-03-2011 7:39, Michael Spang wrote:

> When the manufacturer increases the revision number the platform
> devices for the RTC, NAND, and RNG disappear. We should assume
> new revisions have these devices instead of assuming they do not.

> Signed-off-by: Michael Spang<mspang@csclub.uwaterloo.ca>
> ---
>   arch/arm/mach-orion5x/ts78xx-setup.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 7bed418..13d1fc5 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -343,9 +343,11 @@ static void ts78xx_fpga_supports(void)
>   		ts78xx_fpga.supports.ts_rng.present = 1;
>   		break;
>   	default:
> -		ts78xx_fpga.supports.ts_rtc.present = 0;
> -		ts78xx_fpga.supports.ts_nand.present = 0;
> -		ts78xx_fpga.supports.ts_rng.present = 0;
> +		printk(KERN_WARN "Unrecognized TS-78XX FPGA ID 0x%02x",

    Use pr_warning() or pr_warn().

WBR, Sergei
