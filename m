Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D300E218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bGlgHHB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D300E218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Thu041m+tFe+w4tNiHhZKAsiQgvoG2X5PnEnK/C0gVs=; b=bGlgHHB8dbODjH
	9cWhuDriyKAuf8xRtudP3mCTh3+mRE0pRlSwTaJKEtIuECr26p6YwliA/QgLWCOBY0i2p6IzFoX77
	+tBTn16BJBf62ADIXAt/sbM0vXmv1hTqflNtV4vZhOk06KdYV1nYLyUZDdYoKxoANqwGzLXFdv+D9
	8gV5WItbZDGFrXXzKqpg9rykIaiqkRE11WAl/awuRHrv3g20HBVBJJXHN/2XiQeiUmmGzg5+OWxX+
	/z2xTA/Z3nNRRX0h3s7K4Qp99E1q3kHtrillkP3INzOJHmaralsRzX+WddhqOiyETX19LcAdlxAcy
	qrU1BS5ioucclM3hkwGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga61E-0000AK-HE; Thu, 20 Dec 2018 21:38:12 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga619-0008QB-Or; Thu, 20 Dec 2018 21:38:09 +0000
Received: by mail-ot1-f68.google.com with SMTP id f18so3292044otl.11;
 Thu, 20 Dec 2018 13:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=M1Mb5ZZmqRzVXpJFEwetW2OU5YkngUp0rn8ckubybWs=;
 b=IS45KQmgAldOubZeIZFZJsype1zna9f1r6x8haLpthn+PXwKN5ou4el8KTLju5nDwj
 rQ9JdHQRdCreg14wlfNcGKK5i4ChRzZSze2rmh4eQP8tlxOcDIrCvD91+9mtWX5ISZTP
 8W7kNDrfFTmnZ3Dj2E4COjYJRKUu1Tk2CtHgFfQqmsPO7IRWo6nM4JNmmyLETTCbPskg
 mo+qoFa/AGc2CTKxSaexQQqV7AXezI7BckL3AwYw8a/ozciPoMbZ8deOVtFdb4U4Bj4p
 RDnob3N7nn70zZI0JXdbsr2Nw3H4uVCVEzxijkqribRFtkyV3s0B1G+Kj+pJ9K/W/Vhh
 L2Mg==
X-Gm-Message-State: AA+aEWZ2p2XiuvZafm8LNWLOOmSoWFa7VHcDO+8weStn/LDSsR4uZTGb
 ZBptJX0KmetcJPW0JPzn4Splg64=
X-Google-Smtp-Source: AFSGD/XtvXqt0oZftKijt7Iu2VHOaj9Kmnis9QGu52DgirVpVQcxypA9sO9TGYxerZRR6BmUPL+OBg==
X-Received: by 2002:a9d:245:: with SMTP id 63mr18963313otb.135.1545341876746; 
 Thu, 20 Dec 2018 13:37:56 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id x4sm10324225otk.37.2018.12.20.13.37.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:37:56 -0800 (PST)
Date: Thu, 20 Dec 2018 15:37:54 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 02/15] clk: rockchip: add clock id 24m dsi clock on rk3368
Message-ID: <20181220213754.GA10095@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-3-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_133807_869842_94A98836 
X-CRM114-Status: GOOD (  10.56  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, hjc@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 13:36:37 +0100, Heiko Stuebner wrote:
> Needed as input for the dsi controller.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3368-cru.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
