Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C46C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D3820645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a3Mew7Ra";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEfErM1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Bq5LdmrYFFPzvt1j4e4rD+5qGMHQzMLFJpXm12E4IYg=; b=a3M
	ew7RaOcGpc7Mehyw71pSayTqEZ3NX0dGBemfGKhencIiwOZXq6U7pNKf/WIWMAZKy900teiB3J98p
	BLtalY9xsxETy6hucWkA3ostr/uwoD0Qw3T886Bsr+aLLWUT7XD8C9JuwVL4r3BZHZox4CJAIBGVD
	ztI6VjCCFJu4rUmRS9zMO4YfHPw0f60hDm0/ZYpTQB2NYS6tLGYplCu5shEWHZJiShIO/qgU7Rs4B
	s5C10KUJrvZbdaX6w8V6TOUTCsRjwxwLeswoyLz2H65eenzY4PMlbcs/WVZQ4z3yxRB/kisIyJzNO
	gWR+bS7fz+VSxjJePw0ErcRzS/MmwdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyKS8-0001S5-N5; Mon, 25 Feb 2019 17:54:08 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyKS4-0001RT-J2
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:54:05 +0000
Received: by mail-pg1-x543.google.com with SMTP id h11so4841548pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=3XI+XUQ8UUQ37nasSjVG4chk8ABNuDIm23u0on6K8ZA=;
 b=NEfErM1Gn3uwU2RIklyUpLTFroChcMNjWeeIFMZuDDz9bvFjFbntdSSXaf1wDAUxrZ
 6fPzO3LEJL1/YD6cMeBUWjYhnVURNQEK2XVaaEmdEUUCrOsFgpRVwyaD1bCR8XoZ3aoh
 EzHAVEiFCtar+F6kn2mx28Gjx3KiuHcud5ELjBPLtk6LERD1KYUnLcgDflUy0YiTwL5C
 NFOtubUpOwRMSN92aW3IFq61q+IfnsWGtUsJY3dG22EWu6MXxZx3sfmHt9IFARVtfmM2
 Cw2lo/+k5+rvEEnm+Y6bULqeLGTX4Afy2x3v63yvTAxbqDBEn/yvVMgfYDh3708CcybX
 PQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3XI+XUQ8UUQ37nasSjVG4chk8ABNuDIm23u0on6K8ZA=;
 b=UUgyq5JzzinXlUaqgzPp/QzLGqVCijQdY9pk9Ife09+4ObncJB/LX9qpolDLVwMub/
 weHydCsPjhZQ6uYZHZq5VhaoDttZ0Xyr2wEuXZ2cBV4P/gKtGzYPwCKM8FFIw6EHCanO
 lE8C2UWQYNnY6cIkCF36xJgPGkJRp65aiLB8ySlDi4OKYSSNTQbaNpd493cw5C1slXOz
 the6zviJGal/hbBcMFqLCb5C7TbpOgjhJXECmk6xbYxFZU2cEyTPhDy2EHoz41afTmYa
 VdSpOzCTOxET5/pGKAa8XOYnyfrZKPFXwCl+i7jnuWN5bn8vyT9cuL2FhJrFIA427wFI
 GzTA==
X-Gm-Message-State: AHQUAuZjD7s0muFpYMFZ2ZDjrI03yoHxgJgc7e+iCMdnPOmMcB7F7d10
 JmLx+adJ41UZIH5EYczfOe5tbg==
X-Google-Smtp-Source: AHgI3IZEsrWvdl9iHG93Ff46gxUSicyNpMXkWVl607fsM0/1qJVJlap6fJ5Bmp6KUoLuEaCidS3Dlw==
X-Received: by 2002:a62:204f:: with SMTP id g76mr22206879pfg.100.1551117243066; 
 Mon, 25 Feb 2019 09:54:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm15398997pfg.144.2019.02.25.09.54.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 09:54:02 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 0/1] coresight: next v5.0-rc8
Date: Mon, 25 Feb 2019 10:54:00 -0700
Message-Id: <20190225175401.26467-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_095404_657058_472FEF82 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good morning,

It is a little late in the cycle but the change is small and confined to
CoreSight - please consider for the coming merge window.

Regards,
Mathieu

Sai Prakash Ranjan (1):
  coresight: etm4x: Add support to enable ETMv4.2

 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
