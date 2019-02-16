Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC42C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28B0222E1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+LzfEGN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxRrEZ0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28B0222E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=erpoRHp68lOq6G+QLeHju3Es+nU3GZbNtNmK8Cd+JU8=; b=K+LzfEGNzMeRoa
	csaxGpaanB1+sfJBuUa0EMBBPkFjYHCHv8H7EXx+Ui86IyOqbN6VzQzjC8xpK0Q0ANECX1WTKRe+2
	ehAzHXx6NIWLuv+XRO5CanwbosKFszACW+bsxKv5DZKZvMMCBdxPanuL+61n4MGtZ7oXKGD3aI9Kc
	y8mrEc+Vs2lww71V1Tk4QwzORJm6YYVLZl+u43Zxrtjm/9wW/hlMgbRkrcjjD85wLwirKAs4w6NXH
	Q26A+IYzZIM6cXwDyMrZ6oUugvEnraWmh1e/ix6NFRCzXrVVA0eXva/ZQL/T4IjE6meQbiTD+o2ME
	/5qqrLz1lkW+EKnpCaMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunlK-0002Wy-Hc; Sat, 16 Feb 2019 00:23:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunlH-0002WV-BX
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 00:23:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C0440222DD;
 Sat, 16 Feb 2019 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550276598;
 bh=RDep05NNM48QYOuQkir2sacr0fY8B+cKvWlXp4ZcV7M=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=fxRrEZ0tHGIOmo9pA33oJnrolP37Z0hrbqZoGapJfdUlZUVhc6KbUsYhrVodz+rMd
 8JvV8PntbJqpFTDtcsQgvNwFqKP6ZS5Oe2hY9sf1LSXt+Sp9t5Y0XIxNzJoLn0yh1W
 Q6X9bJ9SDxUD+dZZFiv0jfo1A6jX6StkN7XZNV50=
MIME-Version: 1.0
To: Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux@armlinux.org.uk, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org
In-Reply-To: <1550159642-26878-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 6/8] ARM: at91: pm: add ULP1 support for SAM9X60
Message-ID: <155027659793.115909.12085192701261043595@swboyd.mtv.corp.google.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
 <1550159642-26878-7-git-send-email-claudiu.beznea@microchip.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 16:23:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_162319_409550_30338335 
X-CRM114-Status: UNSURE (   8.01  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Claudiu.Beznea@microchip.com (2019-02-14 07:54:57)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add ULP1 support for SAM9X60. In pm_suspend.S enable RC oscillator in
> PMC if it is not enabled. At resume the state before suspend is
> restored.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/linux/clk/at91_pmc.h    |  1 +

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
