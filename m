Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F8C222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMIs9mB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F8C222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Py2VuBsBeYM6cSU0LhRtHlNj63YecBhsGPkGxO+jmPM=; b=bMIs9mB2DgFE3n
	AC11QTzOYEEWTBe4ko4vG7ww7L/1vl95xu9+jIRDxK36dlgaAuAHgkp7eGFTKqX1qfmnuMxVHAdFc
	pePNV5USCVNdseZgq5/WtJ+id8x+CyTH5kE3pz0Agnkub4docbbzIpIqHhmifjvWSdRfXE0OJ7O+D
	Z2+JEIN2rU0T0nxbeqtg9uUpBGbDoBiih89VhG2z3kmVb6ybwYhxDKqXEBphU/ejzGb0kxuGMVa4W
	0TnDtnHbhuza7Uu3sEF1t3aVL2Xcm0tenjmwgxAO3m5M1g/MxONokrwZWz3kn0vo052RFD4+oGpRP
	3aJZpqLSgWJoa/Ed6JuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2K9-0006rk-O3; Wed, 13 Feb 2019 21:44:09 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2K6-0006rJ-L2
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:44:07 +0000
Received: by mail-ot1-f65.google.com with SMTP id z19so7016718otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mygatE5L9ejlXqXxs6EaFwk2QDg+CnmV7Nl6A1YYc7o=;
 b=MWMeSxPHg1EiXHD5t0g3hCubGbYIKpYfuoJz4W/Y1W361Lrh4x1N5v3F3AuHIYAz2Q
 FGwFPra2Ex04dr5jIfl1EP90bJAOkWtPNGEAc967rrnOggDOEoB5dru3wd+Fzeswc/kb
 Q/VrmF6eOsaW5l1uOHmd6sDLbTq/nzm0zug8OuF3A2IcvB/oRRF2iOyClLSK3zGqvKQ+
 OXHU+n5FkqRoLeOcb9mOER2F3yEBMeO44mYgil8vQ2ivZ9yDUyun8j4BfXkdmwUpOCPP
 Ty3lRKMuS3HWDCBCoGN38uz/ldX3ETeSbcKymjgmT5stBJCLrAy9rrXG3QFRZnz3Zbtx
 Qilw==
X-Gm-Message-State: AHQUAuaI6qsFvQZgiGOa3sHBH+VzsYnL/qTpRVnLPpb0+fOshVIhnWPO
 AQSnlxoo0FFb9QGdVlMV/w==
X-Google-Smtp-Source: AHgI3IZVrOROshWm3fTiMOtFrTM/5eUhqBt6NxNGsZ42wVKdMKKywd4ctRkdwHu8S4XlSlmlofrYfg==
X-Received: by 2002:aca:6cc9:: with SMTP id h192mr194265oic.161.1550094245638; 
 Wed, 13 Feb 2019 13:44:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u24sm403446otj.44.2019.02.13.13.44.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:44:04 -0800 (PST)
Date: Wed, 13 Feb 2019 15:44:04 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: remove qcom-dwc3-usb-phy
Message-ID: <20190213214404.GA31302@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134406_683634_E22DCFFA 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, kishon@ti.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, swboyd@chromium.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu,  7 Feb 2019 12:17:31 +0100, Jorge Ramirez-Ortiz wrote:
> This binding is not used by any driver.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
>  1 file changed, 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
