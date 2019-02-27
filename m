Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3331C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907BF20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rXsz3W4X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j78GG+Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907BF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jm1ctLqtCPzx9kYUSiS+iGRpFFphDcWgVStNMD52fEA=; b=rXsz3W4XOLyCV7
	xvPaKUNq4ycrdfP7NeWL8aU9PbUx8c3pi4vhz8axurRFAUr3JNE/sRhlxyZ/6/DREM8tT1KWUZUsL
	SZHPCZdjPxEA809f308xzyYQy6Cp+lELpUd6NkX/RiPOUjEtPqVBrBzXp/xRAnlBxaZWuB5o3G6F/
	OZ/fvUxBy+qPmyeljtILlZJlLKP0uPSzPCrV/apyYOx9ugt4CYMPT1zWUGTDf5Fy0HF9tp0NezUjO
	UBaOToLhkavAnRPzGuEscixveayctySJUbcP/ORguNyfMyc4DHAiwp4lUd7VJPwmv+TcYrTCqL3RI
	tqaU6Qhe3zaAl76ur8Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6qj-0007EA-F9; Wed, 27 Feb 2019 21:34:45 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6qf-0007D8-K7
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 21:34:43 +0000
Received: by mail-ed1-x544.google.com with SMTP id b20so15185117edw.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 13:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
 b=j78GG+Lrn1m27fhQUz5AsdhDeKRuAcUJsYc2XG5rZ4ek5f1nzqDYYDs09/lGWkxmDR
 DGWCAwlGCU1kU/oArEaeCjpCKANvohSRctwMeKX7NASMiT99ct2TZLPoBFnY78sKeVzK
 UA4X5Ummsm0DWgvmhKg29vBsDo+1uR+a3KCQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
 b=DcMO2PBzJtW58WihIug2IxdXU/LDxNb+hqARVrDRY/+gTHTGazXQHyj3fBF3bn5XKZ
 lHhPasJEAhMSJWmaVDpg/4YfTWgBoihaLNmswEd8RgAjx0rdvIVXBUPfTClm5Fo3PrTB
 baIvTqmBlcrKCKhGAshc/pQvogCvvEnlDEUOqy1RoSL+H0vZXIlz27a7ueGNLFJ6CYHA
 tU8JrIt2upDv3T7NCuisA4TzqUpyMyxAKKdzICWywu4B+X0qGLodngdKv5cPbJ0KZn2L
 hjx4Hc0hWdCVQdF4cNKsfYptPq5IsQjU6JZHjbFgf7Nu/gnaP/YzQKlxGvSDCs9VtqSr
 Ek7A==
X-Gm-Message-State: AHQUAubZnVwCEjfRrkPi58ZUqVoHK5dqabNYJOdt8EwO9ZAQPj81IbPO
 JNnZVQMhWI+9ZpNepFvbNKW12LPDyZs=
X-Google-Smtp-Source: AHgI3IYBT7jZKfOvFLXZS0XBIOD0bbML2tSh9cr+d8JOtv1xKocJstDbnXhT+O/6T1LnyoRnCn0UZw==
X-Received: by 2002:a50:ad57:: with SMTP id z23mr3867048edc.223.1551303278315; 
 Wed, 27 Feb 2019 13:34:38 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50])
 by smtp.gmail.com with ESMTPSA id gr15sm2900214ejb.8.2019.02.27.13.34.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 13:34:36 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id f19so5817544eds.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 13:34:34 -0800 (PST)
X-Received: by 2002:a50:a3bc:: with SMTP id s57mr4018952edb.4.1551303274387;
 Wed, 27 Feb 2019 13:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20190222225345.69084-1-briannorris@chromium.org>
 <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
In-Reply-To: <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 27 Feb 2019 13:34:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible
 properties
To: Marcel Holtmann <marcel@holtmann.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_133441_662625_22DEDB94 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: devicetree <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marcel,

On Tue, Feb 26, 2019 at 11:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > We may need to specify a GPIO wake pin for this device, so add a
> > compatible property for it.
> >
> > There are at least to USB PID/VID variations of this chip: one with a
> > Lite-On ID and one with an Atheros ID.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > v2:
> > * drop leading zeroes from VID, per documented binding
> > ---
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
>
> all 3 patches have been applied to bluetooth-next tree.

Thanks! I failed to repeat my comment from v1:

"""
This patch is also required to make this stable, but since it's not
really tied to the device tree, and it's an existing bug, I sent it
separately:

  https://lore.kernel.org/patchwork/patch/1044896/
  Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
"""

Can you take this one too? Otherwise Scarlet will be less stable
(possible interrupt storm at boot).

Regards,
Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
