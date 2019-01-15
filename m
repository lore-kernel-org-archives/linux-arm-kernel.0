Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B83C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FF720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+sLpdqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FF720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmOPg2CNYg+8/MaUOzZuDj/89zMxGikpJLZ9fUYwA2A=; b=A+sLpdqwLKT0RD
	diSmiAZBba9BsJjI6VVU2xrPrRwNAj67ZtAEBnCW2Z7RnZt4O31EI9arFVUgZxB/yMe+1iBYQgZF8
	S/ycDcepPbG/lcw2jBgk8MpdjVhtLFh6qRATrH5dzTW4jvVIq9RxlS/IB9I6pA0Wrjm5DYfT5jn0G
	j+8dyxseW65lt98s1FYRRs+FnPpogyAszhlIdopiMaQM5PPLC214PP/nK8dzhPudk/hDvNzlNW4QB
	GDTtJNK0BAj4Ft1jXVP+hJ5S2WGvBCkTlsFxma4OejzsgKgrHtMHBhOqKj/gTUcJEnVlGRVzF234H
	shZqXvsHn8bJjVLI8ENg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLnH-0001pC-Pj; Tue, 15 Jan 2019 10:18:03 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLnE-0001op-65
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 10:18:01 +0000
Received: from [192.168.178.52] ([109.104.49.44]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MG9c2-1gSoT50hVE-00GZaX; Tue, 15 Jan 2019 11:17:51 +0100
Subject: Re: [PATCH 0/3] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7ca64f1d-8649-79a3-4c48-5242a68a837b@i2se.com>
Date: Tue, 15 Jan 2019 11:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-Provags-ID: V03:K1:wNw7y2HNzZPH27bE/DRvZQ4Yz8I1sjjKuWN7sqhkjjdfhn685gq
 RUhr4XUJYH1KjmAwHvU6rs70xz0oWjSd9rFDJkgflhJ1F5eJOST+AMXMuDmtRB7dLhkdZcK
 Zd9l+/GD0zZ6Rc9lbfmSn3+tKt3wjRU8bYkhhz1GkRuoOukWcSyaI6WZWZmOxwci1waEKqc
 Hy/amKbIjrrllSf0MGHlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FcfsDcX7APg=:L68TgTHEpzveMY4FeNJrKa
 GuaiueJUeK/Jj0pDEDbtNMn4Erogefpl8TvgHgmFT7t/OHDkdXquYnLrbD3IA/RGOl14tnUJP
 e1OICxO9ew7DWYyBr3DhbNr4983wUVnxOALa22NFKeaVgLN1+bxunpItWOWAd6XRsWqNVzEc9
 +pKjjMd0Vnhe9eKiZvmdjFyB41SQou0dKq31noYeWpYw2c/GAF7dPlaBoo2C1Mi43C4ntp5DY
 sFHCyQO9XPirBxdRrooNNZYIQGQgiHxxwxvABt7VWCe6wER12bDRKUyRRxq7jNWo0yrMpiZzk
 GlzOC0ZW6cyPEkUfFzBY7evmYO7pLedEMO50U2ExUAYuyEPnu8g41FkgrXDOgf4krQr3Y3C9M
 iJDP5K4KPPlGBE82n7+Kc+xBYioKF63mp+lm+RypBGK/DWKaCDPmziCpGUPacDcqxjrLSI7Cu
 sBCPN5Qg4wMTmuinz7xFxckfkAJqERVOy5UlsAawkXUxRoi0T6kEatVGD8/JQDednymaes8LO
 CDC32Dy5xRaEo8MxCZPRnivL71zMD/J6biEwE3/ya3bc/owISaV8xfLtUArPq7rWFXRCA8yz8
 Ygx+aYCRDMDKNO6WXFQJhO9QXuM9roTxgZ5brhYpGNs3NmzuvqMoPPKoJGpPqns50lFuuxSgi
 j3qj9hA4a6255vw7Wm73yOK4fD8eYY360W10Zw2a4MLer9NnVPWWf+JYOwP6i7VBbyRYlhV5k
 u6qny49tTLCGVQobd5JV/qdMk0rAQ07n2pEtzTXUvhHgxn2rL73Vg0TacbU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_021800_530900_E46898C2 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,
hi Srinivas,

Am 11.12.18 um 14:51 schrieb Stefan Wahren:
> According to the reference manuals for i.MX6ULL and i.MX6ULZ both SoCs
> only support 8 OTP banks instead of 16. So we can't use the compatible
> string of i.MX6UL.
>
> Stefan Wahren (3):
>   dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
>   nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
>   ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible
>
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  arch/arm/boot/dts/imx6ull.dtsi                        | 4 ++++
>  drivers/nvmem/imx-ocotp.c                             | 7 +++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
Rob already gave his Reviewed-By for the binding. Are you fine with the rest of the series?

Regards
Stefan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
