From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:00:39 +0800
Subject: [PATCH 09/22] regulator: Change db8500-prcmu match names to
 reflect Device Tree
In-Reply-To: <1338353260-10097-10-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbJe_P==QOPiRi0rZ58aCwyOD8zhxjTX8Do5g_8EFHVGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> ?static struct of_regulator_match db8500_regulator_matches[] = {
> - ? ? ? { .name = "db8500-vape", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VAPE, },
> - ? ? ? { .name = "db8500-varm", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VARM, },
> - ? ? ? { .name = "db8500-vmodem", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VMODEM, },
> - ? ? ? { .name = "db8500-vpll", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VPLL, },
> - ? ? ? { .name = "db8500-vsmps1", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
> - ? ? ? { .name = "db8500-vsmps2", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
> - ? ? ? { .name = "db8500-vsmps3", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
> - ? ? ? { .name = "db8500-vrf1", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VRF1, },
> - ? ? ? { .name = "db8500-sva-mmdsp", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
> - ? ? ? { .name = "db8500-sva-mmdsp-ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
> - ? ? ? { .name = "db8500-sva-pipe", ? ? ?.driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
> - ? ? ? { .name = "db8500-sia-mmdsp", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
> - ? ? ? { .name = "db8500-sia-mmdsp-ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
> - ? ? ? { .name = "db8500-sia-pipe", ? ? ?.driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
> - ? ? ? { .name = "db8500-sga", ? ? ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
> - ? ? ? { .name = "db8500-b2r2-mcde", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
> - ? ? ? { .name = "db8500-esram12", ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
> - ? ? ? { .name = "db8500-esram12-ret", ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
> - ? ? ? { .name = "db8500-esram34", ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
> - ? ? ? { .name = "db8500-esram34-ret", ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },
> + ? ? ? { .name = "db8500_vape", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VAPE, },
> + ? ? ? { .name = "db8500_varm", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VARM, },
> + ? ? ? { .name = "db8500_vmodem", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VMODEM, },
> + ? ? ? { .name = "db8500_vpll", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VPLL, },
> + ? ? ? { .name = "db8500_vsmps1", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
> + ? ? ? { .name = "db8500_vsmps2", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
> + ? ? ? { .name = "db8500_vsmps3", ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
> + ? ? ? { .name = "db8500_vrf1", ? ? ? ? ?.driver_data = (void *) DB8500_REGULATOR_VRF1, },
> + ? ? ? { .name = "db8500_sva_mmdsp", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
> + ? ? ? { .name = "db8500_sva_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
> + ? ? ? { .name = "db8500_sva_pipe", ? ? ?.driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
> + ? ? ? { .name = "db8500_sia_mmdsp", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
> + ? ? ? { .name = "db8500_sia_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
> + ? ? ? { .name = "db8500_sia_pipe", ? ? ?.driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
> + ? ? ? { .name = "db8500_sga", ? ? ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
> + ? ? ? { .name = "db8500_b2r2_mcde", ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
> + ? ? ? { .name = "db8500_esram12", ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
> + ? ? ? { .name = "db8500_esram12_ret", ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
> + ? ? ? { .name = "db8500_esram34", ? ? ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
> + ? ? ? { .name = "db8500_esram34_ret", ? .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },

So again what is the rationale for changing the names, and
again the strings are in several places in this file.

Yours,
Linus Walleij
