Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCBDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C47821908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aq9N5s3P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hlZz8aa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C47821908
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R2QAYV7sQgRFhv+PlC3aNLfeuGEN1guIUUwy9pB6l9o=; b=Aq9N5s3Ptig82j
	1MPL2DAdmSDrM+uG/3Uq7SUiGcgMVetIcVCLvzB5KwDEvWksstCP07h4MnPo4mMBH1Ve+dkk9P/IL
	gJipFi/v5eCOgACjfFW146AGU0pmgEF+C0xR75zMltoRzBV6eLO4qmokWnujF7fjaaYIcxWllNFYp
	HFLN3Ja0fzgO6ihQNP13X6S0Kl/cilTMwU1rJpM5NR5Stpp/kfUBfdFsbtNescB6IidwG8yjdK98j
	Z5u/EXfaKggSYfJk4zhxl+bjdTcaQ0U0mPNx19Amlz7wq/Oq9oHj5K0/SxxxI548aBpBJkTpk1Sks
	eubpckS+hLViJI65Zj/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGEE-0008Ta-68; Sat, 09 Feb 2019 00:10:42 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGEA-0008Sf-E0; Sat, 09 Feb 2019 00:10:39 +0000
Received: by mail-ot1-x344.google.com with SMTP id 32so8787171ota.12;
 Fri, 08 Feb 2019 16:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6WKgZeMxEaINbTBOzkZUeDkqTpOtQlFXaqrcFdu2ZY=;
 b=hlZz8aa77STNBi+Rg1ezvuj3hxsnoBIKfRl1P1/pIw0ug70LOMk3+C+ryL1o30JCHX
 hnB5q4DRhPXiJqIgPr25TONKF3+JIJyU7PxcKNamdQwp7i2qF0iSwAMxwbRdNmWnBMMY
 JsK7DhaPGV7TIMBVCwEVFopHyx9zneALBDiMq7cauOSEw28GTPdGozIg8Ic9dxAS80dB
 aUiufdN/OLjZ2n6V1PEMi53vw4AT4ctqk73F+9y7FzAusJ89gU0rxx6BSgFXuEiQQPik
 8hja2xL5+MpOX9ibXEZ5RIyN0hjGhTKiPeJXripnSrPf6nmcYbctkB1aO29dOUQ1M6Ni
 E74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6WKgZeMxEaINbTBOzkZUeDkqTpOtQlFXaqrcFdu2ZY=;
 b=fRBrytnLC1KFl3Hyv6U6n1qhZq3/85vCOS25xfbqyTcXqWyYYYt7tD0iPSJiV4Idru
 yy6nDtOB9SAzY/Whh4rqA8qZAk/umKtOGL14nq+K79rNNWybnWEoJjMaeTbs1ISXxkGp
 M6D447rZNY8OuyTxFJw9kKIi1QFkHh3MevFEO0vpthVntwjobVepzaJqWA3Men7DvoaU
 1+BDt/RoD97rDsaUnDIIRr8pMo79aRcihxo/xFYkKCou7dEtaZXB+7WVHnCCBMfDXQI4
 9sE3KpfRHiJE5HKdywWCKYcsKGHPs7bPiQcqVENVVB8tFxakppbcJIZw5Oo1uolb2TOc
 i/dQ==
X-Gm-Message-State: AHQUAubQe7ZJNSem7cnnq4LtVk5KGD/2a7AyvygNROGYinV3UkYjKZSi
 faOvM1I3CcsiK9QC8HSqiPxLPsJrceilIcnQQ3Tuig==
X-Google-Smtp-Source: AHgI3IZDtAaNNot/GDW3p1K+BBxlqA8EqCYrGQ8qdj5RNl973F1xE7BDIi44a/pEBvhVDltspqVcYYgUuqTld4ni+gs=
X-Received: by 2002:a05:6830:1387:: with SMTP id
 d7mr5250231otq.148.1549671037132; 
 Fri, 08 Feb 2019 16:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
 <20190206223057.GB4719@piout.net>
In-Reply-To: <20190206223057.GB4719@piout.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 9 Feb 2019 01:10:26 +0100
Message-ID: <CAFBinCDwLyuPh-2t8LuOUf+5cpS2Tbft=4qX6uq4WsEFtvPhCw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: rtc: add device-tree bindings for the
 Amlogic Meson RTC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_161038_503265_CD9A49C4 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Feb 6, 2019 at 11:31 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 19/01/2019 15:43:31+0100, Martin Blumenstingl wrote:
> > The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
> > have a built-in RTC block.
> > It has the following inputs:
> > - an 32.768kHz crystal oscillator
> > - an interrupt line
> > - a reset line
> > - 0.9V voltage input
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > [resurrected patches from Ben after 2 years]
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> > new file mode 100644
> > index 000000000000..23df3cf2dd73
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> > @@ -0,0 +1,32 @@
> > +* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
> > +
> > +Required properties:
> > +- compatible: should be one of the following describing the hardware:
> > +     * "amlogic,meson6-rtc"
> > +     * "amlogic,meson8-rtc"
> > +     * "amlogic,meson8b-rtc"
> > +     * "amlogic,meson8m2-rtc"
> > +
> > +- reg: physical register space for the controller's memory mapped registers.
> > +- interrupts: the interrupt line of the RTC block.
> > +- clocks: reference to the external 32.768kHz crystal oscillator.
> > +- vdd-supply: reference to the power supply of the RTC block.
> > +- resets: reset controller reference to allow reset of the controller
> > +
> > +Optional properties:
> > +- #address-cells: should be 1 to address the internal non-volatile memory
> > +- #address-cells: should be 1 to reference the internal non-volatile memory
>
> Shouldn't that one be #size-cells ?
indeed, thanks for spotting!


Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
