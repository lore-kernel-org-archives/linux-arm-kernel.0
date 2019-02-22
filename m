Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE522070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWLtL9ar";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kDQ28QEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE522070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J7kSgQBcRU0/QCVhwL+0nRCLNSN6UdBDvxhxma/NbUQ=; b=dWLtL9arxW53ia
	ekyj7ISqdy7dsbijgOGXgv4JR9knaonv43d28Ktr8HBo5UjvKYS6y8t1/NP915Gd4HL85XGXYA+se
	o5xjcwh7HhVH+aSHtSl/TysyYlg69aLTysk5HRpF/lhn8qgPGNV2+aXcLxxq8tN9X3gJDrTxT7tNw
	Vy1Sl7QMMudMVmzVVKnaTDAp86IS3kB6Vps46tSq/8Chj84BTUYGugImgxnRfLdQRYbu8TgMtLd8J
	0Brvpl1LvOWVGTSb6qj4sh9ANgOaswlBfeEIG7pygIZlHFLm+xdPCo7eTL1R+hT7h0rZrY375YcwT
	l+uj5MGv4bnhqTJYis7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGTd-0000V5-BT; Fri, 22 Feb 2019 19:27:17 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGTZ-0000UD-Pl
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:27:16 +0000
Received: by mail-it1-x141.google.com with SMTP id i2so4805888ite.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VFGMjvNm3dSJncI1twNm9IeVFhElnEWmN/QP375Qlfo=;
 b=kDQ28QEiycP5fJraKtvWqkepqHFwJPug/JnT3JkDQIk9YaPifxmLNPD36hrEGse/zH
 T2wnIMVXvIG+cw8Wr+8GwD4NVAxeCeFHhbM6PZ9CoAv2loR7KWk2EQHCI7198ahNAhKX
 iuMxgrO5gP6Lh9xh7Oo/hP9HejQtti/7SEdSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VFGMjvNm3dSJncI1twNm9IeVFhElnEWmN/QP375Qlfo=;
 b=CeAguYNVlnWyDsXOG5U69hXVtAgPdEj3Xq5qt+dyyiWC6CIqmCuB808BZ5RNVgFzMk
 Z86cYcAwVU25ngbcPlFkXEzGWGSvtBIotYCRL1BiaCXZJWMYo7zrfTvN8K0D+xM+oEu0
 f+2yMglqriIU0GmosIkyqK/eFZXMXvKm64IdbwyTp9bT00JtpcjgC9G35dloeEGusR7f
 pEU8P1Eo32AMhdMlFkSiMrM6aI8YmjpkoXJx0pBPm4c/pcB2NsoCi1N+l7qk2l2NdAGR
 tn85VI46eUclGDdu80/KZ6wDKqHkiMf9WcQmPoTJxcsoIrQsyPZtHOBDOfLgj1MTt3MW
 HdhQ==
X-Gm-Message-State: AHQUAuY80aMgwcoZtTkviswsOPw3spLEZBngUSrMU3sXLuwVzb3vZOHT
 2NWXzSspN8hg+CpWgSKAiEvB6ePXKmjimxk/XFNbTA==
X-Google-Smtp-Source: AHgI3Ia/hbwrzcs7wSnL5+bKXUAAe9xNwNFFvbuH8TBFqRhVKCPLU6gyHIhF7/D+ypv+XBt9K12zcHhFqZB6PERhF6w=
X-Received: by 2002:a05:660c:252:: with SMTP id
 t18mr3324313itk.173.1550863632174; 
 Fri, 22 Feb 2019 11:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20190212112744.2332-1-jagan@amarulasolutions.com>
In-Reply-To: <20190212112744.2332-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sat, 23 Feb 2019 00:56:57 +0530
Message-ID: <CAMty3ZCSAAYmMn6x2jTpUWtY94fhX8HRAOydedFjjWNfKQoJsg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Add vendor prefix for techstar
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_112714_342369_2E930925 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rob,

On Tue, Feb 12, 2019 at 4:57 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add vendor prefix for techstar, known as
> Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - rebase for master
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7eae7a95ab2a..a5ad57eaee20 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -397,6 +397,7 @@ tcl Toby Churchill Ltd.
>  technexion     TechNexion
>  technologic    Technologic Systems
>  tempo  Tempo Semiconductor
> +techstar       Shenzhen Techstar Electronics Co., Ltd.
>  terasic        Terasic Inc.
>  thine  THine Electronics, Inc.
>  ti     Texas Instruments
> --

Can you apply this, the relevant driver is mainline already. [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=849b2e3ff9698226ab91e034d52cbb1da92a5b4c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
