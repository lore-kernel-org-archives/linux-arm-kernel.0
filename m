Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC081C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7856120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gt4S7X3+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1cJ0dLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7856120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WjNY4zJ++UHAUV+Y/e8pqnnP5KD4+KYM+3GZ0rAVIXs=; b=Gt4S7X3+IgD9Ox
	d8RCptw2OMmo8mQP/yIWKlsp5yXr3Xo00UgPIFpk85kXrQyz3EK7UFLyDADmlFaETS4+WBro9xV2J
	qUsGiifiCsgtYpkJVRgTiFFFdFVnLXpreFAa1PQLRoqB6GB9jyxz7GY69cXoEpvp4jKt+lJX3qNk3
	FzQ0aawRnsIB0QVbMkTLEtqHx2Ky4YulgxJjUsvlDct2E7Y1bgpfZEsZ045uxYQOy3nVBmMvDu7dA
	YAvwneFTaMzsb7RWurRein3M7vELVBclu69EjEh4DvFHi6SQ2l8OFh6GJ5H3CTiezfSguMaysJVIv
	gmrpQlkTQ8X2OqwyPSnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWedx-0004Gd-Gw; Tue, 11 Dec 2018 09:47:57 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWedu-0004FY-NP
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:47:56 +0000
Received: by mail-vk1-xa44.google.com with SMTP id w72so3232347vkd.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=esOMjB9RbrmiA97RLnUMN0xYUZzOcq1giJGVXbJM8sQ=;
 b=G1cJ0dLSQBe6sKgCzWcn77cBRRitjwDsHZuNo5KyDTzwvIz0TkU9w59i5qMikgrtlN
 ZjPOlM1CYfEamIsqoDmCHTmjbBEjxKZh6VcgoK7pHSp4qAXV5UqkvdP9ljHQiqpYazo6
 zPWdYAFeBhrfRGeQLJm6T/eJZECczez0N8EgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=esOMjB9RbrmiA97RLnUMN0xYUZzOcq1giJGVXbJM8sQ=;
 b=GXZx45PZyl9LYphDKqF22mVB5lxMCjm8KVxDOzBTu7FZ93gOFNImB5hEw0IO/hi8I1
 SZxNaTu0Tee9810E9i2P4t66frtEUgG7PHP2dkiC43vy8+BSyB1Zq6H8FLQKmyKSWbw7
 xvWcJwzeWzVFvyM+n1tq47DQOxkCIyFoDvsPz2frhp4s+HTrYvxp1gjJM+RAN+PPxaLb
 gMklOCmuUuyhFdfJPSiLCg4bzAGL8gMilAngz/ikY8RoFN1RGsE2QqzmwTB+XjxSSK4m
 ZzMGaIm0wOynwmSg50+LK+m3VenGNr5YTBvO/16o114+XxJItLOknT7dwZK2fJOa6EhE
 WnaQ==
X-Gm-Message-State: AA+aEWb70pN1+OI4Drc/dUKCNra5DOBctuQbx2CiTpbIzOs5PQ9Q2GVz
 go59bIHGXFiAvcKkHLFaNrgTNQ4JYQpLf5Y1lk4bGg==
X-Google-Smtp-Source: AFSGD/XpIAPaPsECI6d8kvTPWYA2S2QWtq898MBKkAfa/VHuwWDabNRHupOf+NfhBstJfujXge8uuGw0gZDY3RYLhyk=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr6628383vka.4.1544521663017; 
 Tue, 11 Dec 2018 01:47:43 -0800 (PST)
MIME-Version: 1.0
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Dec 2018 10:47:07 +0100
Message-ID: <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] mmc: mmci: add variant property to set command
 stop bit
To: Ludovic Barre <ludovic.Barre@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_014754_800757_C6979586 
X-CRM114-Status: GOOD (  17.52  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
> cmdstop bit in command register. The CPSM ("Command Path State Machine")
> treats the command as a Stop Transmission command and signals
> abort to the DPSM ("Data Path State Machine").
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Withholding patch2 for a while, as I need some more time to review it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 6 ++++++
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 13fa640..e352f5a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/highmem.h>
>  #include <linux/log2.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>         .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>         .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>         .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>         .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>         .datactrl_first         = true,
> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 mmci_reg_delay(host);
>         }
>
> +       if (host->variant->cmdreg_stop &&
> +           cmd->opcode == MMC_STOP_TRANSMISSION)
> +               c |= host->variant->cmdreg_stop;
> +
>         c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 550dd39..2422909 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -264,6 +264,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -316,6 +317,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
