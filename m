Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E65C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1FB20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lAfjxtup";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3BKKJLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1FB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TS0VIQPvaDLhzB4TosGD4oDDud6CzEtMsiLsaNCaRRU=; b=lAfjxtupHVynaz
	42V6eXCQPa7speeIOXf/e9g68LJObL8kGlnzNUf/EQm+Ml//t4yPJyorS8EsJtxkcUxqLWM8T94Cl
	rTGwczhfbHWoZaod+2kJjecmPGb8OJYEU9KgZqe8JgJ0JkekxOAUO/iOmd+XrDaDFfnJPf0ZbFIbt
	dEFd7m19T21z3B4rWb3ZGZbokOJwHuEW7EyiMO6N+qWjeDXwKhVE527XfyjALspFVLVlXH4Ibke1G
	l9FEnfHU7PgNcYm+0cMrLjVQudFR35Qrd4huX78/adzo8XnmoIhy1yvJZHzig9YTVMy66gsUg1DID
	7zJ82txVETePKrGL4Xlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCWc-0000ze-I8; Fri, 07 Dec 2018 09:34:22 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCRd-00039p-32
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 09:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JU+fM0aq4vlQlVnqZ1XE7HA0T3yCDkSB3wIq1pAfddw=; b=J3BKKJLi8kYaCPAa0OenqKmmi
 FF98+7w/nj/JT8LZHYTJYsLQG9iUiI+2h/qxv6EodqOl8ooDHVMb4uypjaWvpPZY4IkPNlHMIQ0Ij
 4LH+R3yJzlE4OituQZuqvoBTtDv3yK0O8Yl/cGfm7vGg1S5Sqz0NACE1PpfUdzZFo6IpkIU5CRjiY
 qRO97tTyxBrgnUO9ga6OWFsJdDwWCxDIMKsbu0giEsy9u4EsoulKN3ZXFtAyMQq2abriMAQPgc20T
 hzKWq4EN7+tDwleIrna/O7cURhl9n2LBDElRK07vr7jsxKsS2eCDrxoCkniCUwjRi6BPpaIfhLNC5
 BgaxP8vqQ==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCRa-0005mj-GT
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:29:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E1E2620D23; Fri,  7 Dec 2018 10:28:57 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
 by mail.bootlin.com (Postfix) with ESMTPSA id AEE9F20CC3;
 Fri,  7 Dec 2018 10:28:47 +0100 (CET)
Date: Fri, 7 Dec 2018 10:28:48 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: rtc: sun6i-rtc: Fix register range in example
Message-ID: <20181207092848.GF8952@piout.net>
References: <20181207084719.2009-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207084719.2009-1-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_042910_659709_59DFD1D5 
X-CRM114-Status: GOOD (  12.35  )
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
 Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07/12/2018 16:47:19+0800, Chen-Yu Tsai wrote:
> The register range for the RTC extends beyond 0x54.
> Use the size from the user manual's memory map instead.
> 
> Fixes: 9765d2d94309 ("rtc: sun6i: Add sun6i RTC driver")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
