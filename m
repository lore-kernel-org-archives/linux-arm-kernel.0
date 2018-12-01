Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46882C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A09F2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dMUDOYnK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STu6RK40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A09F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kxDJbWJRxBJeNQL89aVD6/a8dyUMpLKCtKBll+H2qgw=; b=dMUDOYnK2rr3rq
	1sop0rcIK0MQRcH6QiGWILzqToXBrafhPvK1ZBZk4DeW/noJU+6ybOVd4R3VNeRLMRs1CrzrQXY6/
	KgjKv0Le8p9I6f8v3ObZxesp9acIF+bTFBeWvewdw2xTW1IGCqpbXs43qn0MFcMRsZZIc9sOmfx+5
	3u/apvs368XB3duflLNvEgoI2lLrC+cAo+ZdIQC/MP6I7ecmUyCn7Wj7DJtxFoiNWdAn3vb7v3V8I
	hl13d0coGrH8vuoAjcyz+r5pYseI2dWATW67bSPFU5+y1hoYX5Z3AbXQbZPbx+vXHVfr/kLtwH7EL
	7C9lo9tcsb3ITlIOjo3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTC3x-0002tK-JJ; Sat, 01 Dec 2018 20:40:29 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTC3Z-0001GH-UU
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 20:40:07 +0000
Received: by mail-ot1-x343.google.com with SMTP id 32so8263474ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0PjY9AEfn+9IoaTQKpkZFe5HPq3jh+4UEbnaFE5w2xU=;
 b=STu6RK40aEVvqZT7AVfYuwNuYUiwjODn1AIn1EwkOBJtvblbq7oiwlYdgtZ6AA/ejY
 9o7mfrvRLFMEX3NiofGn9n1jG51iWdCokUAQvzxVFp7OaCvbncB5UBGOQFCPeJYneJ84
 pXi1JiwPvquV1Y3F4Beps4atQ6mcWpD4dQuQEGLZpk4Gtaa19xFAsErjRyNuLVKEfkrN
 UUOfcUBqCyw2tUGILRzj1nBC0hNc1m4YyQIunpDNRIj9fbHKfTHML5hf/cVgJsV0wYI+
 5ItYEFXc0evlL3g148d8OEcIFye2fRYvGVZTsajUmCzAs5mt62YoafqZKVYGHBP93n32
 2DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0PjY9AEfn+9IoaTQKpkZFe5HPq3jh+4UEbnaFE5w2xU=;
 b=mhuBKKmPeFpOpQOtpbZtfL1XkVEIvZl1X/xEewWMj/lMLV/Yh4XV0Ydjy4X2Klc+Wa
 kK5bt0j5/HdHRNMNV5YWaXpCTmanox4H43Em8cOzuVbrnMEPFIVRvmPlyY5zTs9g8s14
 axW1GDJJ2DlXy1EHqujEE9D+FEX8epZy8/WNMHC3RU3jrGbHWHav4usD0nCY8WI3zf8Q
 yX+3pbtBL1rbbUy0pRzfvQEHfbOpTqaABQHa7Poe6WBNYa9SZ3uZaHahEC4CnEbLkpEc
 PDKeRIJzW7ERBT8qC8u1dMis5OljSLcXZA8ls1T7X8eHfNoPw+ryg05CtIGA+pPA4FzR
 8hqw==
X-Gm-Message-State: AA+aEWbP+ug9X37fGHWmPUPnAO5Sr2x683ekrc/SFEdEH5M42POxegi3
 JD4iL1IlcDzpfr0njHIC8b8=
X-Google-Smtp-Source: AFSGD/VPMUHkXHDJYfV/Pul6ksJvaErE6wJICUiibB23pNXEvhQahAjWsniHsBr4ijy/wZ9/D3IjhQ==
X-Received: by 2002:a9d:7201:: with SMTP id u1mr6891192otj.365.1543696794780; 
 Sat, 01 Dec 2018 12:39:54 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id b12sm3140320otp.75.2018.12.01.12.39.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 12:39:53 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 3/4] Broadcom maintainers changes for 4.21
Date: Sat,  1 Dec 2018 12:39:41 -0800
Message-Id: <20181201203942.13376-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201203942.13376-1-f.fainelli@gmail.com>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_124005_983775_D55B5947 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 Jon Mason <jon.mason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 olof@lixom.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/maintainers

for you to fetch changes up to 7900f06c3feedbe74d79f28a0d062dbf11fd10bf:

  MAINTAINERS: Remove self from Broadcom SoCs (2018-11-05 10:41:44 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs MAINTAINERS file
updates for 4.21, please pull the following:

- Jon Mason has moved to a different company, remove him from the
  Northstar Plus entry

----------------------------------------------------------------
Jon Mason (1):
      MAINTAINERS: Remove self from Broadcom SoCs

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
