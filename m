Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370E02087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BU02+R5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370E02087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qEN19A6STsMWJg6o6f0kX7a/SwkQCdxr/Cwj8ga7Zc0=; b=BU02+R5lkQ/SRx
	LVIeSlbk3Vj3cQB0vNxxKZEDdBu/Fk0LWqopDmQ+jrbuT3Tfo93viSPR3aNQ8TpM5lqhKDsJp/zJQ
	4aInRKN08VAFy4KqP63FdMCtHhoe5eZXuJwn61ns9qPS2GkyHPA6Ooddx2747q5rtnjzHuqDlD8QQ
	JlKbMvv+hr1sCT4rfT7Ts+gcp3SAc4TRG7uxempuPNYgZjg1CHIn9a+T9J77JPifb6c0y+2BM8JVg
	89le3/wuSUi/FLD7roa1STlKG6DZhibKmfCQZqOonJNScGZswgumrBTLixeoMcuK5bGG7TZdiswrw
	WNwGhylfd+0BorTx6VEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHe3-00055J-Mf; Mon, 25 Feb 2019 14:54:15 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHe0-00054J-18; Mon, 25 Feb 2019 14:54:13 +0000
Received: by mail-oi1-f196.google.com with SMTP id x187so7434520oia.7;
 Mon, 25 Feb 2019 06:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8Gl2EuzEqgGIyrDurt9KFiKnrmlZzEA+FdttOF+FPco=;
 b=azC5JyrYm39PfLaL/qQ9fWl9XD7WRRmP+RJW54/z3d+9GlM2z2ymW7qoB0G7ajCMqo
 s3RW7H+vjVmxNVGkgC8IhrfAr4gFOv1tcPqOx3YKYe9l2fBJ/JXM2dlc/1G9y+6iEf4J
 wVxfi2a04VV6Yu0oo6u2P8JkH1661UUh+kGZrUeOqyejyMRxj/zheri4T5HidNHQuR9z
 Mri0wC0A0WmZkT/eKo3ewIWg1l/RlLsmbTZ2vuZPHhm8EcUSe+BT2v1nYcf4FzgHRDrV
 WbfpKFLJ1x2RD9CJr4slAXbLe0ea1I2yu6dHt6uR9tEraCwvFzlgG3yRKfDrTcIt6xDd
 0Swg==
X-Gm-Message-State: AHQUAuYr1SwuH0H93wCAyf+9Z9W204hoCSa3AM1GLKQan1Ul7j+fkX/s
 LModE7sjFTG18xIZJd1WCg==
X-Google-Smtp-Source: AHgI3IZAIV1hZ83tg+08jkoMTdRqtz1QJp4uCHZK5C1W25F0+Rdub3PpfYNvkPnUzPyDhEI3JJXlfg==
X-Received: by 2002:aca:d403:: with SMTP id l3mr11345357oig.179.1551106450950; 
 Mon, 25 Feb 2019 06:54:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s21sm4541074ois.2.2019.02.25.06.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 06:54:10 -0800 (PST)
Date: Mon, 25 Feb 2019 08:54:09 -0600
From: Rob Herring <robh@kernel.org>
To: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
Message-ID: <20190225145409.GA724@bogus>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548839891-20932-3-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_065412_070575_90795473 
X-CRM114-Status: GOOD (  10.40  )
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
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 17:18:07 +0800, Hsin-Hsiung Wang wrote:
> This adds compatible for the MediaTek MT6358 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
