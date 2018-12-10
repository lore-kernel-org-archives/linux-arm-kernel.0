Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:24:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9142081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8BYm3qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9142081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ODNRwKpwRWnCKRSCjq2H0vYHTkk+eLz+nTcXVgkySDg=; b=I8BYm3qQ65oqJ1
	VIORBakf3gm3f0iFafZxPHmhvX1iaOr+R8JZitu6bLN/bjjBZdszjSNkZWA58Uc8e4dCDpgbejE7F
	/QHX7j7y+Gxvi9xGRLdxStsNL3X8nJnEINQ7ORa6wsHwRE5qY7uL/PLUk2PYwgmJgxmVK50PuzogE
	cQRfq8Wa4n3R3gaewbvYzw8aq6CvN/jBL+qBqDs7KmDEBg8V70GJao1HswrfEVncALdwaIV7kOeGW
	l+BOvm/FmSc7qNOSaH6/Jv6cff6/5TYv5SQaQ3eLMP870IDlQm8HJo2CLWufl7jA0Ny3GkPtWEClG
	uc13WgRAsyu+fK313kzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUum-0007WS-Fx; Mon, 10 Dec 2018 23:24:40 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUuj-0007V4-EW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:24:38 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so12253906otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KyIqd7jyECXOxDIXVZlg/O5Qa59I+DIa+Q5Wb+3up3I=;
 b=XC6u8SPeEnMZpR5fuXM5DyFFblMJuRvlDu/yRmImlmgaWx8OcjsAwR9oBDdkpe09Pn
 0b3+AWgMgOKLnBk3cxJFUodfNzCw45GEJvJnTohadoX8fy+coDjgV2/Js9obY4BhGSHK
 8v7n+oiiIoumViflfY1RKvPeko4Yh2h6WjBcJft+xJcKX7aiUhTbsWSqrMh2GSXTr2qT
 +asICfqFE5hdAFpdr3q8o6+/thcUDaW0eBCfzcUKYavpev4LBcPgtrdnpTdWGm+Tzk3K
 fQ6AHViTvZzundCzKNtXg1VOltOJ0wpVsnub4SUbnkvzWOtDAj5mBJdyu/ZFcAhycRcQ
 vHzg==
X-Gm-Message-State: AA+aEWaAGJI2C1txw/2O56nNo/iORuFR1+8Gtsq72YFu3SngzrBmV3lz
 nYddd9lZfBDYQZwZzq1+jA==
X-Google-Smtp-Source: AFSGD/Ws1YHh3olY3PBcXpCqOH7s/gd26/9gyrW0EEeawJnBMoQ0EKgDrzJAtlkAqPn9C3omeS4hsA==
X-Received: by 2002:a9d:6a41:: with SMTP id h1mr10187527otn.332.1544484263982; 
 Mon, 10 Dec 2018 15:24:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c22sm6165897otr.31.2018.12.10.15.24.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 15:24:23 -0800 (PST)
Date: Mon, 10 Dec 2018 17:24:23 -0600
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Message-ID: <20181210232423.GA13891@bogus>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
 <20181210115246.8188-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210115246.8188-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_152437_490183_C20627C5 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 17:22:41 +0530, Jagan Teki wrote:
> Allwinner A64 CSI has single channel time-multiplexed BT.656
> CMOS sensor interface like H3 but work by lowering clock than
> default mod clock.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
