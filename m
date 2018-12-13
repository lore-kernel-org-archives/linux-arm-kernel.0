Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662592087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E9RfLCwK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RNlpNHwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662592087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ju0rgupWFHos4+TI3KbkDmrbnuVRBvk3Tw7+VSP7jAQ=; b=E9RfLCwKz1WdwQ
	ZnrCSjIy7NwmgZZkShiSjtSR9CiidcBvllT+MBGOYMySI2RLiRfsCQdIKGjJT2AgdO+i4ebo9FNvV
	M0DGqS/FZ1i0AWV6bqc+yi3Zhd+OqtVXZf5L6xVDQ5I8FVNv232p7A7I3Y6lcwYTBXor+QOWO4Z6b
	1bADQGLmR7ePwGkfIZtiJPHWmgKB38W4R6at0ejEJkdBorlqRaTKp6sZs7iJsD9h+KT8y4g4zaLM7
	CNpsAhdZCc2u/XrRmdP3YOhLqG/Vn1MKkup/bVhl7Pbrlue7RbxyUVFbcornGaKmuyVNFnzCVMF+1
	WN1MowlTF159+sAi6xNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKqV-00046W-Hh; Thu, 13 Dec 2018 06:51:43 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqR-00045b-KG
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:41 +0000
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so781668lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Pd6tHbQst91EQZ2Y5QS5QhJdiC/L7CkDcFsCNyMkDgE=;
 b=RNlpNHwjZVW3XHSQJ2CVcrPmulZZwYm0XPx44b0dp57jf4W6SORMuoL59N8Jd1Eupa
 dy/DrJJ3YVCeImAq/Ub97pMTTEH5zzTaqK8yL0vVJaFdXyT64hMVDiSt8PfvUrcoOF6A
 IN4WVKQbEpT1UPeiGrJ1zP3CH8T2fUIpOKPUm5OXHFIrARii3dZ7DUo1tOASyJup0fVZ
 M09/FljPHvtKvvIpteUajHGfhJqSGP+KmZ/hYoBqaoOJ2isI62fU9vkE2InaxbPWy1Oj
 g4x5stBSZhVISqG6lq3n1kMcNz8WUOUrFzqgIkVpOsBCaGzI5kOJ8h8HECdDhuYhWt21
 yrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Pd6tHbQst91EQZ2Y5QS5QhJdiC/L7CkDcFsCNyMkDgE=;
 b=FL7GGAJ+O3SL0GoRr1myUdbNUDHQCSrDEthvqiDjR0wMNN5pLZwbfd09yxr4eNb8XC
 au2ESnLh65BkIysaJgJAjvgW6jK1FBAtOQyo70cUgRAyktdl0uKfpn1J8T3C4+7y7EbF
 5ST45sZD6VH+DZl5khKibno+Ol1KAe3yQnu1+0cGNUz4WejxBVchFUGvdDfeK6Y9D4CC
 y064Xq8QuuEtTCqnVRyq37lWWq/N5IMRl0fSEkf/TKNH0RjHOMdSdRygHQD1NjWexsrW
 Zq72N540pQdwrjR5TxO4nUvnH8sAnRshRlTZd7WFkNoPQDT43w0ZZ3r+GxS8thCgqB3b
 XbeA==
X-Gm-Message-State: AA+aEWZUwE4F2FPZVL3YqIw12JC4R0zBayAGulr+p0hqMXTaqyHcbXd/
 nO/YWp20j2lGmONjayWFHHb4BQ==
X-Google-Smtp-Source: AFSGD/WJ5j3QRWj9SpWrk58QqfhxK43zcDi9DDIhR8Xj7GFcBzqwQrPgR3+dE7RkwBkked34mdxbCw==
X-Received: by 2002:a2e:b1ca:: with SMTP id
 e10-v6mr15390969lja.16.1544683887500; 
 Wed, 12 Dec 2018 22:51:27 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r26-v6sm156142lji.25.2018.12.12.22.51.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:25 -0800 (PST)
Date: Wed, 12 Dec 2018 18:09:23 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 1/9] arm64: defconfig: Regenerate for v4.20
Message-ID: <20181213020923.zf7juagqy7ukvylp@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <359ddf7d-be3f-a957-0b21-9fdc86120855@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <359ddf7d-be3f-a957-0b21-9fdc86120855@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225139_717456_BE4E4E1D 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 01:56:44AM +0100, Marc Gonzalez wrote:
> Run the platform defconfig through kbuild, and handle the trivial case
> where options merely move around.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Applied, which in reality meant that I had to redo what you did and commit
that, but that's fine. :)


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
