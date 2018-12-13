Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1260C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F53C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="slEEFAVf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="b5689v4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F53C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mW75zI/riJsHjl6kvHc7WVgMqIHZ+uzjw/LSpPabKUw=; b=slEEFAVfKu5VC3
	aS1qHE0x2tc7Xu5LUOYXEZM8ocF38t1k4YwGdW8DfxsZAV5Tij2q5QsMgxuRdpfFPsI8nwyqYT0+b
	U5YPxVd1Ficp6R1D6aP9knSG2NV9eqan/mNwg4LV3GY0snlnhhTV8gIH6uL3yiEtBdfAvnyPsWhhD
	2t4oMzL6zES6gOHckkJJRz0CX0NqbkWhY1QiGp9W0ZdS7+NK+Cj+cjniV0vRBrDLkn6K8jWr9mdJP
	iFTqZem/xtWKNNNsXckdC21vMTJawejA4CA/FLD6CSd+4CRZ3zoqOUOuJIPpu+KJnvQUnvdDxr9RE
	Gt32plhlnyLIx/Tgo5cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFQB-0002Wj-I1; Thu, 13 Dec 2018 01:04:11 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFQ7-0002Vj-Ps
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:04:09 +0000
Received: by mail-qk1-x744.google.com with SMTP id r71so191272qkr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 17:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQnSjrIxTixXwLTStkoYLZJT914baaGl9zND4iaAbc0=;
 b=b5689v4l7oJV3KVYE9at/KddQJFus/+9BLl2yZfFfmtabSB07o3GKXcpb46LVH5bGG
 xd5HphM88IhhlKgqkWmVMKTnAN9R3NUCdomcxHi4ODvgxmp4XAjt2rPGBI4+sOSGoCrq
 CeLmVXCNJHB2LPoLLtbXfLboNlLfWi5dP8yy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQnSjrIxTixXwLTStkoYLZJT914baaGl9zND4iaAbc0=;
 b=el4r75SdbmwLodmi+CBdbVZF+ILX4fYabQY641Vd5tqOewqwwTf61a4mc71l4pp7XN
 FV5FN4env+OsPnNuwZVD3cGCs0AN4/NkCfJAJHrr7wfoP+Bq1E/t6UH45q8qxpRldqud
 P3jq/RQx9XECnad2Tsg/iuv0ftYn3yHF60eCEZ0jG55AR2Ncf2HhO6gaf26oYny8d7tm
 lLEdSpRTgtEJ9+K5SuKJT+scdwdkeHlKXjyaKxz48s+3wzXffJgvF0UrJx9MZhY3YBXR
 5GXrnVZCIL8YiMuZpeHj15b9J/mpDWlFzwFchMFM59Lc0FA9COqtpFvGE/QyaolWSX9j
 1Rtw==
X-Gm-Message-State: AA+aEWZHXPwByRZZIMoY4ESMMXviiFpG6IOzkNf86fZ6r5FnAkBNWeql
 38OOSlVL7EyDqwVA3nDAZKfXhXHET7lvtdHYRhU=
X-Google-Smtp-Source: AFSGD/VCefxwXHN5No6O2mLto7MBnUhABIT6+dIL9Ok0vAnGUnMqbCJmeZY4LWnj3iMZOgniWVBpyn5o5gg5NZVr1dM=
X-Received: by 2002:a37:a391:: with SMTP id m139mr185981qke.11.1544663035966; 
 Wed, 12 Dec 2018 17:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20181212210352.1717617-1-vijaykhemka@fb.com>
In-Reply-To: <20181212210352.1717617-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Dec 2018 11:33:44 +1030
Message-ID: <CACPK8Xea5Q1c9ygvT+WtbwJN9p2Nn-bLo8Ea6U4KuFvFZXvkNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ARM: dts: aspeed: Add KCS & lpc ctrl for Facebook
To: vijaykhemka@fb.com, Andrew Jeffery <andrew@aj.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170407_841262_2660C215 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 07:34, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device and lpc ctrl device to enable LPC clock in Facebook
> Tiogapass device tree.

As we're going to re-spin, it's a good idea to have the KCS and LPC
changes in separate patches. I will take the KCS one straight away,
but the LPC one might need more work (see my comments below).

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index d9d7f208788a..9544fa2c1822 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,18 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               flash_memory: region@98000000 {
> +                       no-map;
> +                       reg = <0x98000000 0x04000000>; /* 64M */
> +               };

Are you using this to expose some RAM over LPC? If not, we don't want this here.

It is a flaw in the design of the driver that the reserved memory
region is required. We should change the driver to make it optional.

As a workaround, we could add this patch to the tiogapass device tree
but make it smaller so you're not losing 64MB of RAM.

> +       };
> +
>         iio-hwmon {
>                 compatible = "iio-hwmon";
>                 oemname0 = "MB_P3V3";
> @@ -62,6 +74,12 @@
>         };
>  };
>
> +&lpc_ctrl {
> +       status = "okay";
> +       memory-region = <&flash_memory>;
> +       flash = <&spi1>;
> +};
> +
>  &uart1 {
>         // Host Console
>         status = "okay";
> @@ -75,6 +93,18 @@
>         status = "okay";
>  };
>
> +&kcs2 {
> +       // BMC KCS channel 2
> +       status = "okay";
> +       kcs_addr = <0xca8>;
> +};
> +
> +&kcs3 {
> +       // BMC KCS channel 3
> +       status = "okay";
> +       kcs_addr = <0xca2>;
> +};
> +
>  &mac0 {
>         status = "okay";
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
