Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F6AC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A08206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RT0PHTY6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmkpmZUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A08206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gG34P11JGTg2+4zrbl67UbX4nD5G4bcNG3Of3VX++oQ=; b=RT0PHTY6VcyEaZ
	XNxFXH0QoePkx8zdPqF3EY7L2mxCX34GjGtPmVBkaBWclmYDpPkb6ETb1IZH6rXEBAnZDD0j1te/n
	tklw1L5pZmwNyvcYCeBlYjBEfXPmzJMc8UB9D1t/s+jb9Ci1FfuA5BD3S0Dr9lxBwPYI3xc/QSVHX
	LdFpoqUBCnNsormFk8CPr45MlbdcGCZhyXhGUbXOZUW7iAdfkfnRk5fBB8qjV0Hah67jCOy4uuJ8F
	I0PZ1aExvY8McoU2a+da2VcZ6yC+QEJ3kQ52d4obdrPWYFYHAS1TuDB30AQG1wEVE/RRIZazQCPeL
	zwAlGcmhuI+1do28Vayg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8EZ-00021L-CR; Fri, 22 Feb 2019 10:39:11 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8EW-0001zH-FD
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:39:10 +0000
Received: by mail-qt1-x844.google.com with SMTP id v10so1887565qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Ycd7F6cSiLogdbx9zRwsP3cV/l35t97ZLFFQbqW0ZY=;
 b=QmkpmZUiBTbZ9js+DH1S5VXOUAULuAZLuoblV0v5GDDP8QKc/2qBF5QRoA0o/FFWAz
 3bL3NDQsR6+GvMRWf6Ie4uXz7E6nFW8STIGANrpojGfO9FMKmvc/m8QYfPkArk7o+/RO
 VV6PeDdL4GccW0ZhsrpKl1UARJCLKHkrZr4/79GXkEKLKfhBiiRIkqmhC/BYdA8jaPJT
 /x8seq3Z19RbpG2VQiMSJTaFzBvjBUa9g8emCTfnkLbhAD7VmBgCRT31WTgqiYNLSRzx
 LJwPCe4snAZD57HLfztU41cAiqw45/onngw+tJKzTBe4zr1VM2wLyKbxho96GCtqdnwc
 snIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Ycd7F6cSiLogdbx9zRwsP3cV/l35t97ZLFFQbqW0ZY=;
 b=tF1IRqo9jKTYsOoJ/MecWa5kZmcYMbUdi6EJ/MifSo7db5PMwLRY9kA7qAVCmVGodn
 u7ZdiB9NvSKTQ7+Fwq5HEaGXSBVc9EQIMdcPnBpZuc0zwIJDXWkqQy0ZUXLa1NPgQi+v
 pMUG5y9QOoIEE45YOHlE5NPzedMf3XYMTlvwEO5VLe3V6RmAKEnTvq2aRYou2k8LogoZ
 8AzH31Qxcuunv7vwUJJvTW29kq7zuNCF/f0BG4rR+aRP//FXNdXjwxbUDfxbz8oAdseh
 O0MJdqnfAszzz4C/2LJ0nVEZwbS4bwsl5XtapPbEF4JqmComkrFzNWinsD1yPo/mcjCs
 VCVQ==
X-Gm-Message-State: AHQUAuazy7nr/Ue66EZOn0TVSwV5UK3HCUplv9B0qIid6oGokO/sjvEb
 b9h+7mkNGf0qOb6B8vRU7LqOFe1Lrb8ZEC8E8p6X9A==
X-Google-Smtp-Source: AHgI3IYPBeQReZrHfmtjIx01G+WbY+Szt8b2nB4hFiiHfak6YeCCIGdM8WMPfhyRAx41LlrRr8ETqmxczH1Ks6eGhQ4=
X-Received: by 2002:ac8:1bf7:: with SMTP id m52mr2568003qtk.200.1550831947420; 
 Fri, 22 Feb 2019 02:39:07 -0800 (PST)
MIME-Version: 1.0
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Feb 2019 11:38:53 +0100
Message-ID: <CACRpkdYwkNrLk-GuV7gaOKYFOeBd0=DLN1wsgrYxeXOHuwtz+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: dsa: fix a leaked reference by adding a missing
 of_node_put
To: Wen Yang <wen.yang99@zte.com.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_023908_662630_3CBABBD1 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: wang.yi59@zte.com.cn, Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, netdev <netdev@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, anirudh@xilinx.com,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, UNGLinuxDriver@microchip.com,
 John Linn <John.Linn@xilinx.com>, Vivien Didelot <vivien.didelot@gmail.com>,
 Kalle Valo <kvalo@codeaurora.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 8:15 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/net/dsa/rtl8366rb.c:510:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:518:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:540:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:548:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:556:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
> ./drivers/net/dsa/rtl8366rb.c:561:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 501, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vivien Didelot <vivien.didelot@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
