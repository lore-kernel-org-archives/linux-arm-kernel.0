Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6512D20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQ1pyD38";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGLdF5bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6512D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XUGVxG+Pau3ooL3NDJbxB0OOIkplek03O2gXY3Zw3vA=; b=ZQ1pyD380DMTsM
	/2GnerHYa6sgfN7i+bMvVNMIWbhENUsvIw/lyVAtgFRdf/QE0o8Y623Qu/bXYRa0fLpTsSRBmN76y
	U4jItWlImnAmeB4uG9lMOeyfqyI0fLIymgEsBFek16wFFuLmRErQRpU/PjYRk97alNoeOgG/Ojqmf
	60Kz8pOumzWhIfOh1FdXtxTB1hvx4LlbEyPvk0y+mRHkqJESe2CAPrjMA5ttRbUi6iCzrPDfxMle9
	XMJ9HqAF4XBjx1HldC/wioL4fMkFTlx9YSHbRK8cVRDg4wBIKjlCugUqZyMeBPYUJ9T0E1ApFDqbf
	ma9qXMNk5QrWFxM5n6wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUQd-0005cQ-G1; Tue, 29 Jan 2019 14:31:55 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUQZ-0005br-BH
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:31:53 +0000
Received: by mail-vs1-xe43.google.com with SMTP id n10so12023613vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SZM6OVgxv/IBmtJypwoYcCJZu0u9rAyQfSsjwtcLSkM=;
 b=dGLdF5bXTIm9Lr3os3sri+AADTTshoVLNLq3wu64hl7s5JVkNOxDHFNh/v1+O7/BOE
 e1xI/A4xH4KP/wGAbJalszKC2cmfAgIVFOc2YzBfK7MBygoGDTD5nmJVRgX0qxjtyurf
 0NNnBB6Wq5LyvrJ6EgDr25Sx0NO10Xc0Mto6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SZM6OVgxv/IBmtJypwoYcCJZu0u9rAyQfSsjwtcLSkM=;
 b=rHRcMkzPl0mu2HtbGftB8hmZAm73SQfD4arp5isU3IIiG+NBLUMB7WSUlCJhufiq4M
 OAMsShZeuLhnGau+/HTQfNhp1kKWFRHClpI4SMAZ3BZ7t10eUT5xkozUAonTjFJ1pc/s
 ksLt1A/ezdc2Ox7ThWfedtmbnboiRqBlMBGni18pe/0ZHx7NpDbmTEcTdE4Ue5A7r4vd
 mMEwjxYdx7qkMakPhW0VQWeb//oxzM11ce4XTygSJbI+ohDVZ7IUFNvpFYxF4GBBMWSv
 /hFP10VfwfL9kJWPXVCH0uakkH48OU5xVINnmOYZ7wJC9qrM0rpNL9BwawRqpt0aH7CQ
 sm1A==
X-Gm-Message-State: AJcUukc5Qgjof92U3eUNhZ7JmGzIgazLTa7Oz1xUVtR5AY58dBpaJKFa
 ublecXbvPmxRattBKC63yIMMq5SKvUZs+2xuwBVVLg==
X-Google-Smtp-Source: ALg8bN5SaNX6wpE3yPb8T94cks8htxcsY1y8H73reD0IgY6DGw6mMeWXRcn6W4aWJKWQuAHw2auvp0v0FgpK6g7XT3U=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10779714vsh.200.1548772309791; 
 Tue, 29 Jan 2019 06:31:49 -0800 (PST)
MIME-Version: 1.0
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Jan 2019 15:31:12 +0100
Message-ID: <CAPDyKFoqjNZXgAGQe+aT4xE=7Q69msowambNNM+6qGWjXa9Qmg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: mmci: send stop command to clear the dpsm
To: Ludovic Barre <ludovic.Barre@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_063151_394873_98352ACD 
X-CRM114-Status: GOOD (  26.61  )
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
> The current approach with sending a CMD12 (STOP_TRANSMISSION) to
> complete a data transfer request, either because of using the open
> ended transmission type or because of receiving an error during a data
> transfer, isn't sufficient for the STM32 sdmmc variant.
>
> More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine")
> needs to be cleared by sending a CMD12, also for the so called ADTC
> commands. For this reason, let the driver send a CMD12 to complete
> ADTC commands, in case it's set (depend of cmdreg_stop variant property).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  2 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e352f5a..4e5643d 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -58,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
>  #else
>  static inline void sdmmc_variant_init(struct mmci_host *host) {}
>  #endif
> +static void
> +mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
>
>  static unsigned int fmax = 515633;
>
> @@ -572,9 +574,37 @@ void mmci_dma_error(struct mmci_host *host)
>                 host->ops->dma_error(host);
>  }
>
> +static int mmci_stop_command(struct mmci_host *host, struct mmc_request *mrq)
> +{
> +       u32 dpsm;
> +
> +       /*
> +        * If an error happens on command or data transmission
> +        * the DPSM stay enabled. The CPSM required a stop command
> +        * to reinitialize the DPSM.
> +        */
> +       dpsm = readl_relaxed(host->base + MMCISTATUS);
> +       dpsm &= MCI_STM32_DPSMACTIVE;
> +
> +       if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
> +                    (mrq->data && mrq->data->error))) {
> +               mmci_start_command(host, &host->stop_abort, 0);
> +               return -EBUSY;
> +       }

Unless I have got it wrong, I think there are several problems with
the above code and how you call it.

1) We may be reading the MMCISTATUS register when we don't need to
(because there are no errors).

2) Nothing prevents keep sending the CMD12 over and over again, for
the same request. This could happen, as long as the
MCI_STM32_DPSMACTIVE remains set. I guess it simply shouldn't happen,
but I rather prevent this being possible altogether, as to avoid a
potential hang. It's better to propagate errors.

3) There is a scenario when the DPSM has been enabled, while we fail
with the "sbc" command, this isn't covered, but I think should, right?

4) host->stop_abort.error needs to be reset to zero, in-between
sending the internal CMD12 command. Otherwise, we may end up re-using
an error code from a failed CMD12 command, over and over again.

> +
> +       return 0;
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       /*
> +        * For variant with cmdstop bit, a stop command could be needed
> +        * to finish the request.
> +        */
> +       if (host->variant->cmdreg_stop && mmci_stop_command(host, mrq))
> +               return;
> +
>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1956,6 +1986,13 @@ static int mmci_probe(struct amba_device *dev,
>                 mmc->max_busy_timeout = 0;
>         }
>
> +       /* prepare the stop command, used to abort and reinitialized the DPSM */
> +       if (variant->cmdreg_stop) {
> +               host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
> +               host->stop_abort.arg = 0;
> +               host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
> +       }
> +
>         mmc->ops = &mmci_ops;
>
>         /* We support these PM capabilities. */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 2422909..35372cd 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -161,6 +161,7 @@
>  #define MCI_ST_CEATAEND                (1 << 23)
>  #define MCI_ST_CARDBUSY                (1 << 24)
>  /* Extended status bits for the STM32 variants */
> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>  #define MCI_STM32_BUSYD0       BIT(20)
>
>  #define MMCICLEAR              0x038
> @@ -377,6 +378,7 @@ struct mmci_host {
>         void __iomem            *base;
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
> +       struct mmc_command      stop_abort;
>         struct mmc_data         *data;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
> --
> 2.7.4
>

To fix the issues I pointed out above, I decided to try out something
myself. So, I will post a patch in a few minutes, can you please give
it try at your end?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
