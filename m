Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A106C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:39:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2688C20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GlRJ8XXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2688C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XY5GUSiJqz+rxg5CBR9JUF1Az/Nh0DLzVNf7mQTs+kw=; b=GlRJ8XXqzRas7l
	Sz6dmbo1hgSYo0deC5t2YQztpTCPvpVa/1eFdSlniGOP0ikmDsrmEHMbBrzdyMUKHigC+k7Et+cnL
	tm0kRiiCeY6qcE6vLymSRcd91abkNULlvSLlDUsmXOykncPeZGGAuwRQ5JMdccV5O/QsGelF6dh4e
	L04l0hXqM6z3r57Ighs/MzbekEp+PsjE0jMMn1jZYf2qvWdWynwSD4FlJGMCA2pS7WwsSWpnlR9B+
	nZYLHtTm4rJu71BBbkwr/6rbIExnBEJDHaaPcaPqnQnAUGAEVhtkv6bcOwJK829Ls1aCfOCBQpBi6
	IDNqqC046H0VZdhJG//w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZicU-0000iS-VO; Wed, 19 Dec 2018 20:39:06 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZicR-0000gZ-QJ; Wed, 19 Dec 2018 20:39:05 +0000
Received: by mail-oi1-f194.google.com with SMTP id a77so2724708oii.5;
 Wed, 19 Dec 2018 12:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=X9EDmUb25eCGRB3VLJKp5doexQ0zWLS4cH4s5eq7g5c=;
 b=Muj5yjPl4c3BsFH1v+q25wWtwUOGC9J49Zt9ggk/sayjV21swlWJpFQUxiTtM84y8/
 8Zanwm0zqVgZWH3s9CB6OD0EOHBCPmJI6BxAJkoqgfSBIJ3YUcN/uGzxRHgWYxfcynCN
 ABpsmwKuhpD2IORXk9Er/CiKkAT990f7tk8658JPwNB8/Id1l5KFoD6UEDiuF2+L+Ec/
 0wGhk0PaHHScOi3zfM9lzlRYlfztsSjt99k8WW4T1gahiqBZXLCcmevxN07z5mBmDxUV
 5bD7+35wYuV0m62dt8XELMR0OgLJFH7kXrHKYEia379b5NMPm6r1YihvPBgCAWj2GPAM
 g0Qw==
X-Gm-Message-State: AA+aEWaj46bG09cf/1/7q/FDZnq70Ux4pBq3JWFAJiJbs9pd3OGls6eG
 3yglIoBVvyqDVKNAmvjSXA==
X-Google-Smtp-Source: AFSGD/XvKotdNnZpmSD7TKdK4qZuEYF5GqjjNE66L1B4YLvKB4dvjRIVz19SZ5LxL8yHjtyc2M+2jQ==
X-Received: by 2002:aca:49cb:: with SMTP id w194mr240905oia.114.1545251932056; 
 Wed, 19 Dec 2018 12:38:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v20sm10399529otp.10.2018.12.19.12.38.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 12:38:51 -0800 (PST)
Date: Wed, 19 Dec 2018 14:38:50 -0600
From: Rob Herring <robh@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add support for MT7629
Message-ID: <20181219203850.GA31173@bogus>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-2-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544058553-10936-2-git-send-email-jianjun.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_123903_853898_180D2277 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Jianjun Wang <jianjun.wang@mediatek.com>, matthias.bgg@gmail.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 09:09:12 +0800, Jianjun Wang wrote:
> MT7629 is an arm platform Soc which has the same PCIe IP with MT7622.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
