Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B87C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:24:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09D321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="syi5yky5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAV7IaKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09D321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=um0E3ZZIUaOKfoVDJX2QpF7KagPBtnkxSatUqA17mnA=; b=syi5yky5QAjfJm
	g24FhgxwIskgIsHRFR02zFFtu+bV6XsrPh7q3I8e5N8UZx8FizH7uC5d9Bl5UiT/4oKpWaMc5o9N5
	aVd41zWeh5cpfYvgm5MuppYlKe/SIGUESYaVbzWZ7ztIVL51IKU0IKZh6W4LylwSb7rRMStEh6tOd
	UDHAEmLlFG89dd76LFfvYZn+4tw98PjAnEcPxp8uD4bU/V0yO3dfyr3gVgVu2jJTRyVqvRWVovqER
	9EyRaJQY9vX3LZrTFAvz/SiVnzgj9qfM4pdVcXv0htChIiHU9EjEIKk6dDzChlVvcadshdKb/leC6
	Ad0Vgl5Ti8SeWgXulJBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqOw-0006a0-48; Mon, 18 Feb 2019 21:24:34 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqOs-0006YJ-Ay
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:24:31 +0000
Received: by mail-ot1-x344.google.com with SMTP id t7so14305302otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=terCZ80LXxA3PBiAEs/Mo83x6p3OLzTXSdBC5o4MSuc=;
 b=mAV7IaKgmHppncLgCyXV0iacWwMeFxBzJuEEkm1Htp2xc2u8nD/zNXSc3U4amdVtHW
 0QDRZpacLpOFWaeox1+99V97K1NrRbxAr66xn7pICzQvhpPVzii3H2TDucFzDDjJQ6dh
 XjgVnCdCBr2fMg8m0pNE3QijIZi/rwlRZqYJLermzMNY5tHX2WQAITb4IweIQ0HHDpaN
 5G5IOegV8R16jxDKe6NoL5mPUKCnE1wS00oy2h/14nmkXEhW0MYL5An/tgklZHaku07s
 nIYeIvktuzLA2Xnz89a0CuhgOxSuatfjZj0EOrf4+zAZfYsFrxMIcpJ6oydWjCEX7gyY
 bveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=terCZ80LXxA3PBiAEs/Mo83x6p3OLzTXSdBC5o4MSuc=;
 b=jvdYl0nOiBwn75bgysg6Md8xh52fppaxYziw1lRI/4GKlYN0693cwxK+0BpliFTbgb
 QLQpYQxz+bB949T7LoRjGlI+UpTF7puoIuWLmgfUcyjmnd2zRb65CFWlNCbsXskrBVQ1
 yvFm0tXhBz2pqEz0DhGgywiOvhJDuWuJAbPZ537YMfcFGJxrHbzJ9fHp0g0179Ksip6u
 JeSqzlIk5FJAXWpVZc5I3F7Jv9rMGNGI+w1clV07r0SOkxNwsyRyhstT+zyKw5zlyKEn
 b9sqOYQZY7edfgNF1D3JawifrW4vsVnfqX6+5/OrLhuihJKSNE4r0k1gjsAe1VthMtfA
 /Qtg==
X-Gm-Message-State: AHQUAuY9FFGVd+vPieMPXlSBVWxUVvcgRXtVEzDRFYbC1Q0Svv4LU09y
 3ApYBF4JsNMqWbIfupsCGp6T594duCrpBOQfVn4=
X-Google-Smtp-Source: AHgI3IZ9tYltrd7oxavWl94369EvsyvagdqvhhFtZDEex9gjRs04HZLQ3MXARmAm1kNNKVBhj3eDJpaXVD72nKK2WGs=
X-Received: by 2002:a05:6830:1193:: with SMTP id
 u19mr14303938otq.221.1550525069011; 
 Mon, 18 Feb 2019 13:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
In-Reply-To: <20190218211035.GA28145@bogus>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 18 Feb 2019 13:24:02 -0800
Message-ID: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132430_380333_C917363E 
X-CRM114-Status: GOOD (  17.11  )
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
 devicetree <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >
> > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > new file mode 100644
> > index 000000000000..8357f242ae4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > @@ -0,0 +1,35 @@
> > +RTL8723BS/RTL8723CS Bluetooth
> > +---------------------
> > +
> > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > +to upload firmware and change module speed.
> > +
> > +Required properties:
> > +
> > + - compatible: should be one of the following:
> > +   * "realtek,rtl8723bs-bt"
> > +   * "realtek,rtl8723cs-bt"
> > +Optional properties:
> > +
> > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > + - firmware-postfix: firmware postfix to be used for firmware config
>
> How is this used?

rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
another is firmware config which is specific to the board. If
firmware-postfix is specified, driver appends it to the name of config
and requests board-specific config while loading firmware. I.e. if
'pine64' is specified as firmware-postfix driver will load
rtl8723bs_config-pine64.bin.

> Rob
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
