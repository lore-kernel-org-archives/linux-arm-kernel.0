Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB16FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:07:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA90206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSEd2vQD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8ahD0fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA90206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=njQ1YZdyZ+44AbwlkL4JtPuLi6KFvk9sUugMii5yXVQ=; b=uSEd2vQDBBkCzd
	RsPBswqK2zniTkbsqaB4Zbrk3hWgPZm2xA/xlZQEHHCFN+71Mt7fBRtVuHj6SjwCaYlgpT1zmSJhJ
	u6Q6YiczYDfM3c+lCFoto12uBInFUTC31K0ybr/NNcEeYlTUMt074M0ttpbHNNihN6Agxqwmmr3wv
	l9IGivCOX1iYXoWs1YNoxj9tcKG2Wu8ijiD4ni6RPtgpnOD3Sp7ZSX/il+V31X161fWujics/a0Wc
	x+++ZmH8WoC6n1bEbBSXH03RD+PA8K4N2UNERuTMsTuc0kxyZlFEfiqYt+6k0l97IuTaPdab8cIZC
	vpPZ4lkIGZIdspMUWTDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp3o-0006G6-AG; Fri, 14 Dec 2018 15:07:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp3l-0006FH-DI
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:07:26 +0000
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9B41208C3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544800035;
 bh=fMbRbW/E9cuLnK+EugAhK6YSX8DI/CNVYoJux0dsYaI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=L8ahD0fe9SPvw9u3PFD8h2d/8iai03raGtTBRBTMyVQ63yQddG89zK19arrPMnbXE
 A51WusNABbso3hlkbb0Hr0wT7mrCNE56zt3biaThJtj9qK9/HZh1UVsKTaTIzizQm5
 RI65adY5zkdVJkDxjRkyUsfqcyLdRAQYq1QEFBOs=
Received: by mail-qk1-f174.google.com with SMTP id w204so3401004qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:07:14 -0800 (PST)
X-Gm-Message-State: AA+aEWYhFMbkF4Rk4X4g+eHDReUrfUnMT5TiU/uah9ErIuHv5Tpb8EOy
 gSkDIBEcWZ0WkWUbTNDZS/EuyspnZnoJbQE1TQ==
X-Google-Smtp-Source: AFSGD/VDmD2EauGOjdmVWNo3S9FJRdWOdNPkU0P3P0TepPOmM06PFcLhdLHyDIRYi3beWz0C20xZYKVEvTv89cfab4M=
X-Received: by 2002:a37:b646:: with SMTP id g67mr2933392qkf.326.1544800033909; 
 Fri, 14 Dec 2018 07:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <20181208170216.32555-6-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-6-georgi.djakov@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 14 Dec 2018 09:07:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrCBDegU5CpFfDrZeyfcbAAdhcn2AscrVA=uK7XqkvGw@mail.gmail.com>
Message-ID: <CAL_JsqJrCBDegU5CpFfDrZeyfcbAAdhcn2AscrVA=uK7XqkvGw@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To: Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_070725_483940_84CD469D 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, Evan Green <evgreen@chromium.org>,
 ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 11:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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

This and the binding header should have been a separate patch, but I'm
not going to tell you that now on v12.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 838 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1029 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
