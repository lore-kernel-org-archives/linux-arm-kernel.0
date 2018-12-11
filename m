Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F32C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E525820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mNhgvDD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a05EkF0KFmDwZMS/tnhR/d7DiCthoqyBTM0DWOJDRDg=; b=mNhgvDD05hiwj2
	gG/yXRce/YKRBTYEfQX7rKsvH0HJBPTpt9WQ/+l/jzhKpnhbzArBVHP67h/77l7mCZJL7+HmgvBwp
	GJgexQtKuxomkjOxmNczH2G4ss0mX/Ywfte6jUGVp0reUXkzv/HElOPtfHUcWan0ha35CS2ARr2K6
	zuQb5u9jaFBPeAo2NVtNZSKU/BDu9NF4xUg03ljjD191eKu1/YQCZQ9576boVt2fIoz4/23aSQAry
	cvtqvDQUBT53Orj2DhFJcGA1inlRCS8TM4wyVY7Wte63zq3yN+Z55ufQLzkXyIwBgtKiSI+I1W+7K
	a1LYx1+VKJrNeijXow1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWql2-0004cu-Ti; Tue, 11 Dec 2018 22:44:04 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqkz-0004ap-Pa
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:44:03 +0000
Received: by mail-ot1-f66.google.com with SMTP id e12so15763571otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r6UDmpXPkRar1OXJqQs+UpFXCk7geFte4T5MJecLED4=;
 b=iilBgp6XrzC4p4mTxHqwFAVBAq4AgwlYdecihVmWToeVq3sCNoTlmxbtn1KhHIqWv9
 yiikzpSB/lISb0Hj1BtgbPhmrRuV3sNuq7h+LMoQk0UcVROd4fMcxRYDCibeip+/XeP9
 2VjPax0VF0cFbJJrO3g5u1gImwMPD1FSPvYmQapw5MKVTaHaRxjvRt01MN/zV78HkadH
 tllmio+WNMJYDupwfQN+tiONkGD8doDx2FOuMyO2yccDMOholpZweEDEwIPELQFrmnnQ
 8peT3Ieu69UMoUzqsn+PUMy4M4QCH3U+hY/lLUacRZwCm8qkX8d+6RMv4H8iQhu7ODUX
 61UA==
X-Gm-Message-State: AA+aEWZ4ND7X8CS1Bu9YwZkeUdnJJKsrxHmKr14k/kjYo/Lg3/8mwnkG
 AGVN/euXuNw1gYp8ZdNZNQ==
X-Google-Smtp-Source: AFSGD/X7EZ4yij7EiDpQCj3IRqYplM/BN1inzMbIONTln+zA/M6MV+xhsBRPYapP3kuD9jMloIjK1w==
X-Received: by 2002:a9d:6197:: with SMTP id g23mr12193917otk.324.1544568230718; 
 Tue, 11 Dec 2018 14:43:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i22sm6633807otp.7.2018.12.11.14.43.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 14:43:50 -0800 (PST)
Date: Tue, 11 Dec 2018 16:43:49 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 2/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
Message-ID: <20181211224349.GA30397@bogus>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
 <20181128043738.12714-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128043738.12714-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_144401_830228_CA24EF38 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, p.zabel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 08:37:37PM -0800, Andrey Smirnov wrote:
> Add bits and pieces needed to support IP block variant found on
> i.MX8MQ SoCs.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/reset/Kconfig                    |   2 +-
>  drivers/reset/reset-imx7.c               | 106 +++++++++++++++++++++++
>  include/dt-bindings/reset/imx8mq-reset.h |  64 ++++++++++++++

This goes in the binding patch.

>  3 files changed, 171 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
