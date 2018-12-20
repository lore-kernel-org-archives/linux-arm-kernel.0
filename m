Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3688AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CD6218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPsWwGlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CD6218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uhr/GBunR2rKp0i9278yKuBbwF+0jUVtqHe3/l5QD6Q=; b=jPsWwGlxmmCZHd
	hZrA81kb+B4vPBwdT3/ECN/zyqSCmXPcfVH4DDYHOqTum3epkcI2LxxT4x8kai12IPQ7+PCEXetLN
	2Y6qd/hgZsho8psrHl2JDJD34hTSZWGplgMRTCxYNxLwr/srLkYcmtoD14JWdzL12RFOTc10T+4yy
	MNjWdGNq/b+Y5e8hm1TqDAV5LfU3DVKxL636D1DBQsvu+ZRntzYBDy8/ogTmJdIuOc7iotDoT7wWW
	xzLNWYtScfuz4rcO8g9c3QlTdp4AzsJ7btAxxn64QzDzGuHQxEEpd8naQNzj82h5eKTtqzBTeghPE
	PNBCzihMjZfB1i8hk6ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5B1-0004Fs-Ec; Thu, 20 Dec 2018 20:44:15 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Ax-0004Cp-Rk; Thu, 20 Dec 2018 20:44:13 +0000
Received: by mail-ot1-f65.google.com with SMTP id a11so3162354otr.10;
 Thu, 20 Dec 2018 12:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EXWVS91ufBJJfiGUyJ5XnKh030tDRBDxANLyB1KtJw4=;
 b=ZlLY8EYWvSmW1sDlE/ljBxjOT4P5CIs7hjXvh9XAkO0TZCv2KTWdNTY905h38T+TT5
 lnF7gFwDxbXLO6fiUxdn/RFnLMYprReA9u0aritZrXqVzR8cBO+ujCcYp6qJTENRy4zd
 TeypRX2Mxl7Oa9ibOmmqKYPqg2wAGBA8cskj1Nm823JMJuVYxxYoN2mt4NfYJ23nVKH4
 veEGB5DW5rH2Wsz88dNXSmR+PxUWVFr6oWYhGOKB1N5ApCYu/XkBh0kx2HeNMtCULImh
 XQcCyVO2cU6JODw0sYN7VlZVxyqoO9CV+1z0k9IyyGUlCUDsUMY2e6onenqdlylHHtbH
 XQPg==
X-Gm-Message-State: AA+aEWaXuElhG4XqFh/RgCJ5owQjmHU0yniqXTPKCf2VECR8G0M8GD+S
 b5z9+61pHUkQlgDTR0S3oMMV4cE=
X-Google-Smtp-Source: AFSGD/VXe0MhHlsYdG17qfGX5cvIdirTzp/umiPaI7RmnuoamVBohj2bxUJpJOAUvGWmHALBR5IOyg==
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr19516975oth.338.1545338640975; 
 Thu, 20 Dec 2018 12:44:00 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id k11sm10648077oib.35.2018.12.20.12.44.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 12:44:00 -0800 (PST)
Date: Thu, 20 Dec 2018 14:43:59 -0600
From: Rob Herring <robh@kernel.org>
To: Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [resend PATCH v1 1/2] dt-bindings: clock: add clock for MT2712
Message-ID: <20181220204359.GA30122@bogus>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
 <20181214020417.2871-3-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214020417.2871-3-weiyi.lu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_124411_895077_212107B8 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 10:04:16 +0800, Weiyi Lu wrote:
> Add new clock according to 3rd ECO design change.
> It's the parent clock of audio clock mux.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2712-clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
