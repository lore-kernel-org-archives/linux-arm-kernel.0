Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7423CC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F552080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JvcryS49";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYOm5N7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F552080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9g3lqtgpb1WAXjgcde/1ECFzU5mO9eJBcfRjcXFYsBk=; b=JvcryS49nvAZKf
	V8WYLMuaeluzXrLUdJcuJEBCkhRNYWtz1pk2TQ8I63qenQqF9e2GlArWGMU7DRC32w3+wCnrojxAH
	BRNHlaSJnKrMlHByPe5YInQzR4mmyHuul+paUXKKDRNyt/nF26YuH4D73Mcaj5Iv72gZo5BVgip4N
	4IyvNkTN3gks2tKzmVPPFL+uq+cT8/+ZCVGpEO5ReAv7v4xr0lJgq9rBh6QaZ2bhkeCHBQd/nZR7M
	xyA8yv74PJVJyF1QQwEGUGhWhH9Ck0ABQe4gbwqEWs2ZhliDbI2DvapMcbZVgyxKUCVR5zxyTVSJ9
	A+ztXTS4GH1iZGFPsPPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr03T-0003Sv-6l; Tue, 05 Feb 2019 12:42:23 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr02y-00033c-Qm
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:42:20 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so2716931lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PujTR3VNMLT5EVX/UqxbH2pEhEzBe1DF8UOx19PW8us=;
 b=XYOm5N7K+2gM6vgrKEvLrT+uS7LoA2euPbUNA9k2cE256s3MZjXdg1Ld1UjO+/+G+G
 lPIfJUQIUuOtcQ3XwImF3DgqtPhkiP14v8jZMSybH0JbI6no9y36Vgt/44hHdoxLwPh4
 B1dzeDKmR5QbFRXkdolp9O1bEJhyOPK9isk2VETBOoDRHThgyOYKL2bIhrGOArQGwQ8m
 gnUr300JQ6d6mre4/wPJAnGM810QiqKXoKWWMVb7fj7ypVH7hGR95RD7SNiubV3Cl2tH
 ty1alUY+g3MX3sQ7tth4ZA9boSzIXozzsxCy25Kliww8Tth1Ew8/2FIVPqgbC/9iECGI
 n3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PujTR3VNMLT5EVX/UqxbH2pEhEzBe1DF8UOx19PW8us=;
 b=sdOshlS/v+Da0eoDiO8GgcTHraE5gtCYd6g7DWSFnnw9GqNX1q7epzRgGCjfbXr78w
 2HgMyj6/NG6GsawDEiNCc9309jSUfepEfil35Xh6rPxN8KCfb3lRjV2TLxPXtcDY//E8
 pJTfesL2dm2znCTzdVLirpOl0HpWKS8o/nvGuGSy2NF3iarD/viwOyae4Op5x7RVpwpH
 tVZ6xxLlCYEQlw2mqBCzXrSywgZZCE9/tU46j48+YehrbmX2amOENG0gJw5IJPYJPQgy
 inUj3+b/UUiZvTNdXyARoWSN3895DcBmZx0akVHVh4FY9WorLE1X5EtZpPTFxSI6BkTC
 JvZA==
X-Gm-Message-State: AHQUAuY8yoGkO+md1pQkaoRDOltIMUrD/diXcxZH4Ht7OFzxMZ7yLKgw
 vGUasygdbzfawF0775NsgkfgMkHG0fpMeO7g5aUHFQ==
X-Google-Smtp-Source: AHgI3IZ5PbuTNMeGMxbQSI9dcS7UkvwYFjc7/+WprXGB6n0865mBoKl2ukg6NtRertzthtF9PQNG5xYzIXGf9G+w7aw=
X-Received: by 2002:a2e:131a:: with SMTP id
 26-v6mr2744142ljt.107.1549370510090; 
 Tue, 05 Feb 2019 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20190205094937.18645-1-brgl@bgdev.pl>
In-Reply-To: <20190205094937.18645-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Feb 2019 13:41:37 +0100
Message-ID: <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the
 legacy API
To: Bartosz Golaszewski <brgl@bgdev.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044153_599720_8A58F0E7 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Sekhar Nori <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 10:49 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> In order to drop the hard-coded GPIO base values from the davinci GPIO
> driver's platform data, we first need to get rid of all calls to the
> legacy GPIO functions. Convert the mdio configuration to hogging the
> relevant GPIO line in the da850-evm board file.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
