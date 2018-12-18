Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2059C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FB1218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fKUeHc24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FB1218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AybFKIPZhyiohFo1G3LwfL0BfemvOxdqWTsRWLnHpsI=; b=fKUeHc24jMcr2Z
	91ouhdAHaMmasqgUqPZQRIJVedwXAX2fX4YfYU87VwRsWfx98UyQl92EwbDEKDHPNck6nydOFaaOa
	LaRCjXJ2CECZe7r8EpzhYA2t5bs91X7T+0dJpsmSYRrox7+gcGx/r8692+67apnC9leHlO/7PLOn8
	7gLMFRCnUT9e0bSLkkN+xIHcT5e7vTePkmktVni6+/swOBCOtu11XbAsrLzSIqrznrUx4BG8cXhbg
	/J7wBE2qvIlzUukdbSkkdj3pnHpjn4LT052sHMoQruxx5kSngfihsRx1NpblkUVXLFAgesAbDc9F9
	WoHiKl5fzsuG1zLH3Wtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGpx-000667-0v; Tue, 18 Dec 2018 14:59:09 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGpu-00064H-3w
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:59:07 +0000
Received: by mail-oi1-f196.google.com with SMTP id h25so2184795oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 06:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xMKIC/TFpjstl7gS63RAHtvskE1SAito/HGCHDVeMWU=;
 b=LfEzbuoVV7buuHveS5AW62xblHnumd1iNAkWYFkabxoSOzJuJ8HFae/WMfkOU83Q9C
 yBhFX/7RkRgQBlJG7GvCFhw8W8gjXBJz5ZrxievEZrU9+53Hhc42Sl7mGRZ3JtMvpB0Z
 3v1I4ly7v5+60XMgwXsOZd/wPLi2Zy9ypuHC48+XVNgzxlFviPQ7/yMj3tGrcTOjxqQK
 cofbHhxWic8E/7WbFl7AkFgyLvc8owg1F76dpZ+sDGkRXUSoJ//5arz6gEJmH++W5K0y
 bRaIftglsB8xvKyYfx9LjGCx6p5C8bzOluI9X/E33PfISktQ3HNz5OArd+9brnrNjaNh
 ZGTQ==
X-Gm-Message-State: AA+aEWaGxIqph/wXihW+p/x2PqwE6wthUkZEogv/HRJkK53utYbnkBab
 2YZnLU5Q7yV0VWkBe5v/jA==
X-Google-Smtp-Source: AFSGD/XGP+JU60it0YNWQdTGPfnr50QxT8/W8wmBFXDK3hJLi5oo0qCbNqbBKaefLOB/XZ85CxyEpw==
X-Received: by 2002:aca:d905:: with SMTP id q5mr8365041oig.0.1545145134920;
 Tue, 18 Dec 2018 06:58:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r17sm7234955otn.0.2018.12.18.06.58.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 06:58:54 -0800 (PST)
Date: Tue, 18 Dec 2018 08:58:53 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: net: broadcom-bluetooth: Fix
 external clock names
Message-ID: <20181218145853.GA15352@bogus>
References: <20181217040449.31437-1-wens@csie.org>
 <20181217040449.31437-2-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217040449.31437-2-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_065906_257720_C7F6CF5A 
X-CRM114-Status: GOOD (  16.18  )
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
 Ondrej Jirman <megous@megous.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 12:04:35 +0800, Chen-Yu Tsai wrote:
> The Broadcom Bluetooth controllers can take up to two external clocks:
> an external frequency reference, substituting the main crystal, and a
> LPO clock at 32.768 kHz substituting the internal LPO clock.
> 
> In particular, the external LPO clock must be used when the controller
> does not have NVRAM connected, and the main reference frequency is not
> the default 20 MHz. This is described in detail in the datasheet.
> 
> The original "extclk" clock name is ambiguous as to which of these it
> refers to, and some designs might even require both.
> 
> This patch deprecates the existing name, and adds "txco" and "lpo".
> 
> Tested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
