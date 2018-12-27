Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2751C2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPmuHXVu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlD7pH47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2751C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CYdkDhzn3JU2uedR56OsvLRtqBhnN4T9VH6FqYgxUbs=; b=ZPmuHXVuZRdsCI
	uFZQ0MFXDZh9/2/yhYj/S0B1otH2AI6IyOgZwNU8P31RE2XE8xETRDqrpzSZBGofeVj0dWjeHygZj
	2cp9D57wgcDUTYaITK4QDyd2ylgpo5z7F+VNN1oI/ETL/Y2uHClxI87P1NiBZFqipgeN/WWijjJjo
	/iUrUV2N50iE8BZnYXJmYvjsVLfbJYHLscpdfB+bC7bLv2n+fOOWM/cGlQCuh6HvXYmhuqG4u49Ji
	qTul+oE2Y1HfLByn9XsFjrrP8U2DOzEPDdZyINOS4Pmd+AvCWC1Sxy5I0sXIJeqoyO0A8uK3sSQKk
	Rvymw53tqxxX4TeuRFhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcSCq-0002Hv-EW; Thu, 27 Dec 2018 09:43:56 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcSCm-0002Ft-Js
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 09:43:53 +0000
Received: by mail-lj1-x243.google.com with SMTP id u89-v6so15822301lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
 b=DlD7pH47wSvQDgEQXAJI00aCiOzF7JZO5u36HnvpoXWeJwXddfamL8nkLz1Qh7RxBP
 xgcKjLdRZra2oZEUEoF6MAs/1UKrGgE8/E5BVNWfxLUkh+2p4GjMa/O2KmNrUPdL0jql
 zeP1Dch7bgDYzJhK+d3nwkeV5SZXsQcIC+eNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
 b=XacXHM4qN/4E7jwCc8i1rFbQOQogMJegxnrpAc2CKLDxb/d49XoYHlGOLiLCxa3ZTn
 xu4SzNwh0i/2OM4Z1oQOeIrAj4zd3Qtkea2a7ebRH2L8ww4Ex56beJyzfLo1gXi7+8mU
 7Os0s32XJkXTxqBtVnggwGtv6wAogOu5rNK6rYZOG+hNPWpxsyu7CPJj8FH+litICdI7
 0iMPfAki7lUrvPf0vsMZglvPREeC7Cw2OmBjbxDU7fWZD4dMDjG+pTdoaFyraQGT64UU
 7YIAiTWEtVw0L+f7DAMmu7fuRsA+dU+SUiFliL5e62h8wZAomikntvsky+xcNLYtj4Nt
 7O9A==
X-Gm-Message-State: AJcUukdsd0Ad6s6tpsV8Zoad0LCb7DOW0nnyg/HGp/VHjC7d94SA2RQy
 /VcjpeRSImgaLpWEpLsKakcAyh+OmUsheookGQjj/A==
X-Google-Smtp-Source: ALg8bN4AaiiRY0EtKBRNIFxYKF8TkcZwCTQwSQQMaTrAvzFGItE4nKgNeXW6cH24iYCyA7IT5/LCNd9SWQgKaC4G6J0=
X-Received: by 2002:a2e:9c7:: with SMTP id
 190-v6mr8447228ljj.120.1545903820308; 
 Thu, 27 Dec 2018 01:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20181226024333.72236-1-kjlu@umn.edu>
In-Reply-To: <20181226024333.72236-1-kjlu@umn.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Dec 2018 10:43:28 +0100
Message-ID: <CACRpkdacqJAuQoCad8L=k_R_Vz-WAc29J9DdV-7jbJDrb5ET=Q@mail.gmail.com>
Subject: Re: [PATCH] rtc: fix a missing check of clk_prepare
To: Kangjie Lu <kjlu@umn.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_014352_709735_6B9BD8FA 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 pakki001@umn.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 26, 2018 at 3:44 AM Kangjie Lu <kjlu@umn.edu> wrote:

> clk_prepare() could fail, so let's check its status and if it fails
> return its error code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
