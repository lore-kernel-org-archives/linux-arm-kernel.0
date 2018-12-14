Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBDAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BF520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oyo9szAV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9ybumqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BF520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Wj2chQ7A8R+JeAfJlmS7/8+q33wewovUzBY4OZ4Vu0=; b=Oyo9szAVq4byQs
	wYpU+CJOqXf/uw9+EjMOHpewHMYuNAXzncMNSLkdVdxg0zETPKjoR9DdueCZamf+EIMOWQLgBt3TF
	rTs3RM+qtmRmoTLx+c9u/2gnLbQKasDL2gUkfbuH1+cFP4rewB/yGt9RTwsUbDZv0SSjJj5shQKB6
	NnFvfDWWF51SqXHHBAsRfCMcjWOpoBQi74IoiM3Q0v3ug8n9KE2jtBriE7Sw49XObT/4x4W7taaWy
	Td+T8+EINBfyRu0PZUUHn58g2lvmgRE+1/j6+uumh3gi75K7003hVH3NWea8cHcDp72+5EsEW6MRH
	P9E9iIpRaJfXl+K4+W3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp19-00048W-IT; Fri, 14 Dec 2018 15:04:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp15-00047G-PR
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:04:41 +0000
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB2FD2086D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544799869;
 bh=3rvvYwC3KoBUNHXdC65+dArf+DJXLB5CK9AiCdUHf+s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Q9ybumqb3Q82CpWPF7PtQ06+6FTHAy0+1roaSLN9LYAK2OyBJEq4hNXBYemYmwSOT
 gbHDWTD90ic64FJQC8NWFIxT3a/jLFMAJI8U4E6BN2ZcmEx1PXqNXfXwrfhCgto37g
 KU/uKRoAcWdloRvfy8j0sE60PPt/VsJI38ZoNloY=
Received: by mail-qt1-f181.google.com with SMTP id t13so6494665qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:04:28 -0800 (PST)
X-Gm-Message-State: AA+aEWYOEIJ3bRVQb1DwVr32Wl7dw6xj8lgedQEp7d0nNOP8rMVv5qh4
 Oxz6ec2hERtijfICdJyKyIgFfSlw4Z4ari6JwQ==
X-Google-Smtp-Source: AFSGD/WZ0D+UHfc5Yk3vnIfpZ7wuDjoVQAfSYXBasUi7Z2msbx6SPvsVX3LP6jY8EORVANKvKB+/Z5M8mzOEzQabTRc=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr3229883qts.144.1544799867957; 
 Fri, 14 Dec 2018 07:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <20181208170216.32555-3-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-3-georgi.djakov@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 14 Dec 2018 09:04:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLG32ZE2Ljfkz5wC_yfs4NVWYA0VfQPaB9Q-3=vFjO4=Q@mail.gmail.com>
Message-ID: <CAL_JsqLG32ZE2Ljfkz5wC_yfs4NVWYA0VfQPaB9Q-3=vFjO4=Q@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] dt-bindings: Introduce interconnect binding
To: Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_070439_838405_0719383C 
X-CRM114-Status: GOOD (  12.19  )
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
> This binding is intended to represent the relations between interconnect
> controllers (providers) and consumer device nodes. It will allow creating
> links between consumers and interconnect paths (exposed by interconnect
> providers).
>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
