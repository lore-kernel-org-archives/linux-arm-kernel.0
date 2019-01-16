Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:00:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3B22082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="do3iWsrT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ar6p7weB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3B22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HB/ZJe2ISItHfALa2bsAdB8Yt/dC0Gq6uajR1/BndDg=; b=do3iWsrT1bztLB
	N0JOvRtfSYfS86FtZtzUW6QcYEkC3Jgn8CyyXnQ6bldEGMvt8Jt8Eu/ZOCs30sBO0UiydZojDynyM
	C3ljODbApdTd9k7Kbf8Vzpdz9PPPin3t0n3n2DzsAWxZcGeRAZWdfoQVlkX1KWFJwjnLC8Mdhvuqb
	6X2SQKK+KTg6JRCguzyVEllK0MrsRbgw9gPY0NVGa7CMpFdOraoGpzM2NULl2XQES8neaab6fpuYX
	ibqEgiV8XHaQeQFdyNoPEL5aaWX2eHI0dV4t/4/1asDAJvcdwnHPuTXzzq/hj+1YQ2BpDP+INAdNr
	9FjD5XY6KMxfsZlXJ10g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjcNU-0002R5-IU; Wed, 16 Jan 2019 04:00:32 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjcNR-0002Pc-Mq
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 04:00:31 +0000
Received: by mail-ed1-x541.google.com with SMTP id d39so4272626edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WQnr2H9f9doStI1cKUtvCnMkv0ljT07NkyfmA7ZWKe8=;
 b=Ar6p7weB9RZopepSoyo34BOhaBPP8Pot7J0K3KGRj5wTes9uyiG314HfTpGmcIVshV
 yPhWLKrjq5TyxA0D/otTnzcvRl0v0Ak/+FjWmR5K+BSenpvmMsgMFICTYtcrKC2CPsBW
 58W0EQodyhc0OcNTHlB/La+mvGxyRoe8L/8X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WQnr2H9f9doStI1cKUtvCnMkv0ljT07NkyfmA7ZWKe8=;
 b=R///Kj8f10fFvoGf+WXrXFyqnknuKXx+yf/Tu1puxFYQMeFpusKdy85vJm0T4P/F9z
 fvKiY0m7giu+SQz6ZDmudmK8HEixIMhPwOCkIvYGNqRbviJTGXsf3YclmW6IqA2lZuRb
 GAoZ40VRI+Ey+CwUk6O32vDbMpM9Szpa+o1UQFOCXbL16HQyO5TNtqcemAp0PFivxUgr
 FPkOQmd6v5eqh+/81MukYSFCZXJ99dSGfGnwBVh9DCXeSnGEy/NLRTR6sQiPy6gGC0Mz
 PzOkoVn5CJ0GUoE1UEiAaYcan8AAZmmyqxhG/J6yzBgbB54xmZEYCKaApbTNMCFG3hXc
 38zg==
X-Gm-Message-State: AJcUukdHEmXx9vF/DJ1VivzQWPQhZ2PKWJIjSA43nGH/J6VtYAeSLVxu
 puY69mn+o24smAincwluX3LI6X5EupK5t+V5D9UuoA==
X-Google-Smtp-Source: ALg8bN4mqCVseqlEIClIf6z9udEqVEoRZq363UxSJn4G5jOFP3x8u6D7LCvaXQiwDNa9jLY0sz0xDBh/98LXYmcP9NU=
X-Received: by 2002:a17:906:6298:: with SMTP id
 t24-v6mr5416344ejk.58.1547611227383; 
 Tue, 15 Jan 2019 20:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20190108052606.59426-1-pihsun@chromium.org>
 <20190108052606.59426-2-pihsun@chromium.org>
 <20190115203448.GA32546@bogus>
In-Reply-To: <20190115203448.GA32546@bogus>
From: Peter Shih <pihsun@chromium.org>
Date: Wed, 16 Jan 2019 12:00:16 +0800
Message-ID: <CANdKZ0fbP1Nm3GkO1ujeuaj4zAOQCdJ3MPowDQ-fJCUZ42a3dA@mail.gmail.com>
Subject: Re: [RFC v2 1/6] dt-bindings: Add a binding for Mediatek SCP
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_200029_769445_2752CC93 
X-CRM114-Status: GOOD (  20.96  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 4:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 08, 2019 at 01:26:01PM +0800, Pi-Hsun Shih wrote:
> > From: Erin Lo <erin.lo@mediatek.com>
> >
> > Add a DT binding documentation of SCP for the
> > MT8183 SoC from Mediatek.
> >
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> > Changes from v1:
> >  - no change
>
> No answer to my question on v1?
>

Sorry I missed the last mail.

Yes there would be additional optional properties. For the current patch
series, the "cros-ec-rpmsg" entry would not be listed in the device tree, but
there would be a "mediatek,mt8183-rpmsg" under this node.

Would update this in v3.

> > ---
> >  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > new file mode 100644
> > index 00000000000000..b07e5c4ca9af1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > @@ -0,0 +1,10 @@
> > +Mediatek SCP Bindings
> > +----------------------------------------
> > +
> > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > +Mediatek SoCs.
> > +
> > +Required properties:
> > +- compatible         Should be "mediatek,mt8183-scp"
> > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +
> > --
> > 2.20.1.97.g81188d93c3-goog
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
