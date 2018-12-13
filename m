Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61502C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:40:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFD920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kd/lfio9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1Sc1ZIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFD920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JBYdVOJhJiM+G9LPRZff9iu1j8z+T42V3Au52d0x6Ps=; b=Kd/lfio9GJSBFz
	/JNlCEaqfeq6BApCIqcXaMNh3QE6730B3S6JLlIK4TQJM9aQPA8ejRP7hVl4z9LJk6J+AgJkS5v4p
	Yc+rXd4MIFPqIy549DkyX9FoPXabJdigeH4nXr9l9Vb3Bmco/b8vSy+Hn2dFL0ETDoTyeNbJs02hg
	nh7XipueMoX92rvk4aoDBo4nqeJp4hT5R5uExpSmpxKpNB6x61aGHpGbE97IZBHTyL+mOOErDsG98
	z2u2gtX/ueFE0YJpbe83Njc9+XOcrB27uSKNfmNaFGpkKobNninRAPmx4RsRudXeJ6GXaa3AVcxpS
	JqZwP1XgTo7PDNg2hdmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVuU-0007xY-0J; Thu, 13 Dec 2018 18:40:34 +0000
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVuQ-0007wl-4W
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:40:31 +0000
Received: by mail-vk1-xa42.google.com with SMTP id t132so690574vkc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WoBCC1fEUReKhH3+RvYGWGij3YwtCzU4rFxG6wuJ70A=;
 b=T1Sc1ZIZf+t2P8qmuTA/MgOY/038xTpXTluGOuUGK24BBqOwkU43SysVq9q8di3cLO
 Eo946+AgnFqw20vRRN5vAexb3e8UQpzOwBlarjMx4/0HayN5/9RMDTNkOWbAxKKzBc8m
 B3bRX22NI8yRfjdov/P/XacELotprzs0qPYPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WoBCC1fEUReKhH3+RvYGWGij3YwtCzU4rFxG6wuJ70A=;
 b=H5m30rTDDccgR47U/dxhkJ4YdQbYpRadN2UYuaTHz0FJKwKiYNm3snxIKNHCarH2eL
 UVagaC87u0OW7uP2HJuSZUQHnuWzdq+qdCfdmMC74cX16zuw0rlvSRoHk1ldRzlbcfVt
 54mVh6To1iPfl/YAW0QTh5CB3zpNPMiVleRibCZ6hpaITLo9IS4b0OSdrqSoUYnVRTHX
 wkCnhcw+c7Ky6tosEKlhui7JsgDESHJsLBfXZiPfyq/jDY3d5NEWlxBiTqAB8N+oj7UY
 3uDU7O/ejrxxACQ7wYAvoCjgncOMS6fQdzB97NyuO3w8djjhaBqng1jVdDjh7LTmweJF
 fdTg==
X-Gm-Message-State: AA+aEWY2UbHPiFcUzlgAQzmlOxUdFLtfPDhTOQC/oYbxVbRFJcFakfcF
 deTviyXXRWLMMR9qRb90zk1biVEhe6Y=
X-Google-Smtp-Source: AFSGD/WpkmGkIhGgN0Vn8sIZqjY/66gr3M1ly1UNjAsfyJ7DqRrH22dxLqLUTWWu+BjmQbKlpjnJHQ==
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr11466545vka.13.1544726418673; 
 Thu, 13 Dec 2018 10:40:18 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177])
 by smtp.gmail.com with ESMTPSA id p136sm730918vsc.18.2018.12.13.10.40.17
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 10:40:17 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id d201so695252vka.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:40:17 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr11284772vke.73.1544726417048; 
 Thu, 13 Dec 2018 10:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
In-Reply-To: <20181212211848.26768-3-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Dec 2018 10:40:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XRjOsStnfgS_P8Oh-aZpcx8eN+qfh9viVXw5BMyXEZ=g@mail.gmail.com>
Message-ID: <CAD=FV=XRjOsStnfgS_P8Oh-aZpcx8eN+qfh9viVXw5BMyXEZ=g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: jcrouse@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_104030_170268_3452EF6A 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 12, 2018 at 1:18 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add the nodes to describe the Adreno GPU and GMU devices.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 123 +++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 233a5898ebc2..a608afed502e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> @@ -1349,6 +1350,128 @@
>                         };
>                 };
>
> +
> +               gpu@5000000 {

nit that you're adding an extra blank line here that you don't need.
Given the quantity of outstanding dts patches though, it's almost
certain that Andy will need to manually resolve conflicts when
applying this patch so presumably he can fix up when he lands.

In any case, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
