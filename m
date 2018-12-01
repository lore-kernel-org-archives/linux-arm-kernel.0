Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914802145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2K15oEr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIZxmPfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914802145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6efMRyU+Q5ZSewErugM97f+/nrliBHw2yy827lhFFJ8=; b=q2K15oErvUY2gP
	O5ygtCbi89bvvM+Ym4kXOIqwo1ro62JjyGrjt/vXRlenNkKER7zLe0oddi/FJdBDLSO5AT/AGIysn
	0Lr58JysL8/MqG9ce8zqeG5JZU0BUOfu64IMDUUxrmRpop1M3HFn/qXZ62v8yQBQ507JkG+IjkpbI
	7qIlAT5eTSGvqKK4m3aUYs27ufgdPFFeU/5A10H+JiNw/bDOk32mB7UaVfmfnszkt0G8i+SABqDiP
	+bYEc8weStjxIFnUxY9koc5xsUhNMEOhxoHNOCxKSuGpvTuAu5cRxTh0DkG/+XsQeCbv2Wg7yP/mi
	hQDlntPdurnZI4R0BEww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStPe-0000Sh-Jg; Sat, 01 Dec 2018 00:45:38 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStPK-00082G-9B
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:45:22 +0000
Received: by mail-lf1-x142.google.com with SMTP id p6so5384997lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mhmAcOfQHba7jsByZTi1TgDT9pcdTkIHC+NZgrhuRHg=;
 b=TIZxmPfJFbaNypWYoxkmT7u0IVQMKTmwtE7J+QMhCk/Z+8baz4+ZF51fWhiwYwp5mf
 2QxIOGE3EmUWTZxW8NXE3rek2uH5buBY2CNYhAzhOBit4GItPdfAM0NmB+LDyV7olbrM
 aWaLNAeZrx3dGsUR2SxQoc1Zgj7L+hdF+6RmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mhmAcOfQHba7jsByZTi1TgDT9pcdTkIHC+NZgrhuRHg=;
 b=TbEbUotk9Eqb1MFD87FwSkv8j1qrJMl7uvfpBIxyj3XFmcPrXnfxsMSL/Z2yfnLjW9
 o9P+kK9GekY7NsyDP6pXw9rowsbtu3xCv4IV+dKc7N7vUd0+zZ3q7wM8W6KvukoWxKmH
 y+0Ld+gE2/wDkCIGnf5SesWiIcRiYHjNr5wLid4aEeIyI7S+dEkGCHzBtcrUM9yhDc7S
 W0hiSoeW7vUeYZPL2GS4OBRv6gnWVcyUV0uPdoRfKxgBtm6ytCCZPuQ1fIFL6Dy+k9II
 NTequEPbP3EETcD59Ke+Gm1gDhC6S+k96jQnQeXkOUkzy8dA33QFvQCt+ZdwQ3oV8M/a
 ym0Q==
X-Gm-Message-State: AA+aEWZofsem9lOWw7M9uPpmF9996WY+AP8LDJoH/KjT9qxIXGqDBd9d
 VSV7rTmcvwiocy5mTzXMWWtPLkGt07I=
X-Google-Smtp-Source: AFSGD/XGck5rdMNwCIAdwL3IPcgG5A06K4gcfVOP1xO+mgQ8NuVyoZbtD8E2PrWoMJWxIl6IKhphzg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr4901864lfb.72.1543625106319;
 Fri, 30 Nov 2018 16:45:06 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id r27-v6sm1070815lja.65.2018.11.30.16.45.06
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 16:45:06 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id u18so5358573lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:45:06 -0800 (PST)
X-Received: by 2002:a19:1bca:: with SMTP id b193mr4641734lfb.153.1543624776451; 
 Fri, 30 Nov 2018 16:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-6-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-6-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 30 Nov 2018 16:39:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Message-ID: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To: georgi.djakov@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_164519_076559_06683E86 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1027 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> new file mode 100644
> index 000000000000..d45150e99665
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> @@ -0,0 +1,24 @@
> +Qualcomm SDM845 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +SDM845 interconnect providers support system bandwidth requirements through
> +RPMh hardware accelerators known as Bus Clock Manager(BCM). The provider is able
> +to communicate with the BCM through the Resource State Coordinator(RSC)
> +associated with each execution environment. Provider nodes must reside within
> +an RPMh device node pertaining to their RSC and each provider maps to
> +a single RPMh resource.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,sdm845-rsc-hlos"

I wonder if maybe hlos isn't necessary. Unless you somehow imagine
secure mode would have a device tree entry in here as well? Probably
not.

> +- #interconnect-cells : should contain 1
> +
> +Examples:
> +
> +apps_rsc: rsc {
> +               qnoc: qnoc-rsc-hlos {
> +                       compatible = "qcom,sdm845-rsc-hlos";
> +                       #interconnect-cells = <1>;
> +               };
> +};
> +
...
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 000000000000..1678de91ca52
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -0,0 +1,836 @@
...
> +
> +static void tcs_list_gen(struct list_head *bcm_list,
> +                        struct tcs_cmd *tcs_list, int *n)

We could make the prototype of this function be:

static void tcs_list_gen(struct list_head *bcm_list,
        struct tcs_cmd tcs_list[SDM845_MAX_VCD], int n[SDM845_MAX_VCD])

which would catch errors if somebody later passed in an array that
wasn't the right size, since we blindly memset below.

> +{
> +       struct qcom_icc_bcm *bcm;
> +       bool commit;
> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
> +
> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
> +
> +       list_for_each_entry(bcm, bcm_list, list) {
> +               commit = false;
> +               cur_vcd_size++;
> +               if ((list_is_last(&bcm->list, bcm_list)) ||
> +                   bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
> +                       commit = true;
> +                       cur_vcd_size = 0;
> +               }
> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
> +                           bcm->addr, commit);
> +               idx++;
> +               n[batch]++;
> +               /*
> +                * Batch the BCMs in such a way that we do not split them in
> +                * multiple payloads when they are under the same VCD. This is
> +                * to ensure that every BCM is committed since we only set the
> +                * commit bit on the last BCM request of every VCD.
> +                */
> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
> +                       if (!commit) {
> +                               n[batch] -= cur_vcd_size;
> +                               n[batch + 1] = cur_vcd_size;
> +                       }
> +                       batch++;
> +               }
> +       }
> +}
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
