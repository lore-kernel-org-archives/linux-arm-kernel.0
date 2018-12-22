Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CAFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:40:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B2721BF4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZIaompV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e+7Uvhb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B2721BF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iIGreYVen4FUk2mPiSShaDDBiRIR05UGia9t5QA4d58=; b=QZIaompVuGNuqL
	gbv4WSoPmCkNNn+D1otwSTtCSgeLSMc6DxDf8GmoZ3nTfzyhEUbnOLb869e/YuPNoCiuH4WzZcnfU
	1m00t0heUeXVQJi0DeNBBi8UWkca0p+elTOVonY+tbVHY5jHdo1nLgmLbEfxpfCZKegTSkCTeMxGP
	dtjAaV3jQYay+u1TZivF6l4BUZ6tyWoMH6scXSySWzp7LnrD31zP+vclxrd77DGYnXGcDR0wvvFEP
	7mNLaJHg83OK4oniQaqU6Qf/pFLE3z2N1dLk+moFPKydBgRqYozQnMc0G7FtgCGt83WG9enejbXPC
	duC7W0R6EbHAGm4MHOeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gakKO-0007vJ-Vs; Sat, 22 Dec 2018 16:40:40 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gakKK-0007tu-4E; Sat, 22 Dec 2018 16:40:37 +0000
Received: by mail-ot1-x344.google.com with SMTP id a11so7858433otr.10;
 Sat, 22 Dec 2018 08:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SF7xyu4fCnTh+e7yI/0mKZxwEQs8lVUbTod0dt+3ZXg=;
 b=e+7Uvhb6X6jzdebn7JAit5kR/N6zDqk2Wp2L46gKEweCd4V1ZFCRBE8MTe11E9q2yB
 HLmbAuK87LgQ6xTkuJ0q7lH8n1AWZzbWmsM36z3QSxdGX23QbbOAbMroYC/OvDGC0gGh
 YFN+x4Ofb7t7Y1ooiMQmJ7T3mLiU7lNlwun+FAX/h3eAJ7bGOjBxxJDwScwyZZDyIPvH
 hA6XdRA/m7cJ/K1KlM3r3YYmeFl+6GF7b/jeu4extGMDC4rc+pLsSI6+Co7ndyJAN8mx
 685ncRvQVLhDekjIdNlXaD/XSCqhSDvxUt3ihdfUPiol+TeGVUAv8Mm1Wp/C4tTuo62x
 ljAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SF7xyu4fCnTh+e7yI/0mKZxwEQs8lVUbTod0dt+3ZXg=;
 b=dOfZSBvyb/TVhqlbyi5+Qz/lY8IODWcYzetic9UevPxr+FcYUUWscZY6hH++NTUMt2
 IV8VhsQLDd6l+rkTLrI7+DoWrBNiVCkZPZ7FURyJiArDL6xRPOKB/NZ/irabrreJGWxn
 096oIy1NrcKeshGeeHFLjFslhDXoNHCgGgiXNBR7kspYIZ1iNDT8wZabNdrt/Lkc/S+J
 ceN6vdB1/m3Umj9/S7dcN7gWXmPVR+zIxd3y0jHNlSGR77r6D5bVU6z8ilUDmWAdAMsD
 z+tZIA5nQKOVIh7vvCLfPkGsdQaQdcoh11AQ40fxqr+kkVMP5Cq5q1x6fVaCJUfz8Xpe
 y8dQ==
X-Gm-Message-State: AJcUukeY164FIxpt4CgEcH8I9c7gauq4SRDlgO+eYlsWTIaaUFcATgia
 66OvVTHgHsBFnHL40SDO8JeqvNiJykTAcgqKTjQ=
X-Google-Smtp-Source: ALg8bN6CwTIZgaGgkkEwFFQwoewl2Q7WjaZer4pY+Nv9N/T2Q6bhsXk9ZxS9QnQd4qpHiPxW97ifIWSALtU6U/FIAvA=
X-Received: by 2002:a05:6830:2115:: with SMTP id
 i21mr2920587otc.237.1545496822342; 
 Sat, 22 Dec 2018 08:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20181219233519.35287-1-khilman@baylibre.com>
In-Reply-To: <20181219233519.35287-1-khilman@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 22 Dec 2018 17:40:11 +0100
Message-ID: <CAFBinCBUm+Js1-ZabP9bSmYE0qG9Z9gYr-ua+ayDyPOdXUsEyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_084036_198536_2EDDC227 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Thu, Dec 20, 2018 at 12:35 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Add new vendor for amediatech, and initial board: x96-max
as we have seen there is no "amediatech" branding anywhere on the board itself
however, FCC gave us a clue about the manufacturer: [0]
can you please add this info to the patch description when re-sending?

> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(with the two comments below)

>  Documentation/devicetree/bindings/arm/amlogic.txt     | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
if Rob is fine with vendor-prefixes.txt being updated together with
adding a new board then I'm as well :)

>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 8dbc259081e4..c50b084b6c59 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -99,6 +99,7 @@ Board compatible values (alphabetically, grouped by SoC):
>    - "amlogic,p281" (Meson gxl s905w)
>    - "oranth,tx3-mini" (Meson gxl s905w)
>
> +  - "amediatech,x96-max" (Meson gxm s912)
I assume that you'll not only fix the SoC here (G12A) as reported by
Chris Moore but also the ordering


Regards
Martin


[0] https://fccid.io/2AI6D-X96MAX

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
