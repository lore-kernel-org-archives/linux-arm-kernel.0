Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F695C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C2620666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCu4CbYs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iRvrG1nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C2620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qkg5nL3X7R2xKG12DN1SZ06jLiLK2XppPFj4EYyHsOQ=; b=sCu4CbYsOoUeKR
	G+TjCHCDzmzU7CQ1pWQUyQWWBl8r41qct2JsggUeZ+MS/b/LkYPOFjKlVgjIkX+UPQAjhQXVn9q99
	LzCdP9eJLUjH7kH1ekIRJ6DVz5RvHWLm9HzBku0H09YaDFKFuqzM9czxnVyhpuXHkKTSg9UsOKWbN
	1rR7oH19g6O1HxoPuFcerL48g7lRScCB2aWnMQ98n4YXJ6MakZO2anCd20RlFQ4vhZ74AP3lXbr4H
	V/2ofrh4Sw63zS2Edpz0m8FHY8LbaCUJ1W5DM/IXROAptBnHehoaPUCqVuf2jmjYklswzMA5+1RTc
	5pIIzkgXFBd+lOrDhLXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkky-0005sr-Pe; Mon, 03 Dec 2018 09:43:12 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkkn-0005iA-HE
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:43:02 +0000
Received: by mail-it1-x144.google.com with SMTP id b5so7599234iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FICbMrAKk/4QUbgjYyqeR5wy4ls3W8G0AZ8zJkO8kB0=;
 b=iRvrG1nwQOJtGIavT6yFNFhN9x6dm4SVhWzUfVQN+wQbxwtM6uLI30LYEMHlra6sTf
 l5Fx0i2LxjRShSnUasGCJ9r3fL+3Z8xAalktsgnehc0oT8RelefQN+6AfdyyQ1mdTshi
 X2+eWq53A8vX7tvsifHDnSAaehLX8CBy3t590=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FICbMrAKk/4QUbgjYyqeR5wy4ls3W8G0AZ8zJkO8kB0=;
 b=Id4OmbuA0PMVb732dOevjcpQlHBFgqr1VbKROfcMrxdqGMdI0HhfWJicG2m/5LYzQQ
 roUyU/BP6xdgNVGHizQDURw3TMK6o2rduh7wMAp1ploADAQq2KVEYCDBb1Zz4Pu+pzhh
 UY2mJJOmKxwFzWSGqSV5trezYFB7V6bywizdIM2wBWBt00MjQds89TZHvtFtvFSR3LxP
 eS/2ZXtZa44Efebf3TP3nv3BZy5Ela10QFyXDUTP3H9cZQbI3cq0DaLpfYckBeTEWa6S
 k4Sw8ethch6uHLC/7KcAacuNNzuSmC6jp7mr/wLuEE+wZFyx16HN4kEMhpbTF6rk5Bib
 FGpw==
X-Gm-Message-State: AA+aEWYwquqTC3/yk0iDzaEslwVNWZc3OGJV76qpmWzvBcrWVI/qg7Y/
 1iEDG4fr0YWfA9kTnevMNX3wbC0NMNVT1qWd4/SwXw==
X-Google-Smtp-Source: AFSGD/VIS48miG6cg4v4naJvPOyKOiD2zfO2ey2hcXviYpHoBb0otT1n3U2rT4aFo5dDGzt42NP9NJRzq+LA8ktHGM8=
X-Received: by 2002:a24:5411:: with SMTP id t17mr6868271ita.32.1543830170475; 
 Mon, 03 Dec 2018 01:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-3-wens@csie.org>
In-Reply-To: <20181130075849.16941-3-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 3 Dec 2018 15:12:39 +0530
Message-ID: <CAMty3ZBig1hJWgjF7LF52Z9vjJcqpNXLgdkru0S55fnrebT-ig@mail.gmail.com>
Subject: Re: [PATCH 2/6] media: sun6i: Add H3 compatible
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014301_567331_269969DD 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Add a compatible string entry for the H3.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
