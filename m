Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5800C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9208421920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LE6lcRjK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUn8FI27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9208421920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:In-Reply-To:
	From:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJ6Pm1cB27eMixkJGRhzARxsNZ2Se+jcom1/NDSb9GA=; b=LE6lcRjKFUs4Oa
	3z3Hdj5JpNanqjGsrGukDn1XNFBjT/5kSZAlZz7Zle8cCiR9zi9qBZk8I7ioRDJtXwho5a7e3bC8q
	LayL3oC66xLxjD2Qj9y/pCR6Yd3DQuSj/DYZfGQZcEpBZZWIGfq6Y52LYCra5pgJ3s5jmG7bQTAYK
	uJVWypHWx7Dz474t5R3PItpFtVTWDlsJwkBQryd/betsJm2rIqnhhq92vodbeBEpB4FHhCvtuawqm
	mKN8uXKQPXFzazRxqxXgVN5c4w99Wb2lKfGdDWKRmrJRSMrg/OyAlLort3TCqptXlHhY0D9Z4+j8z
	38kowh/VHjwv6VywasCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaSWz-0001pw-EE; Fri, 21 Dec 2018 21:40:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaSWw-0001oz-Gl
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 21:40:28 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96DF621920;
 Fri, 21 Dec 2018 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545428413;
 bh=hynrE5OrFjQ3nV3qTSBh0BJ5Job7ybFJw0px9idDxFY=;
 h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
 b=oUn8FI27tZekiibrHxHLuiNDXnJYWggEiiIiibygl9qAqBTcOYwz+SOJTpId+kJIw
 /4EP8gtwMKknlSlEwhaXyWoae068b0Ysg4/QOnBsb48HMhvOMQ4JNFoqbT+czTOtOU
 zDwiHTv7RcMAk9X+rR/m2+cgzBP9/Men5VfzY81g=
MIME-Version: 1.0
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
 <20181221192823.GA9704@minitux>
 <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
Message-ID: <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
Date: Fri, 21 Dec 2018 13:40:12 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_134026_578372_B0BBEBAF 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez (2018-12-21 11:45:28)
> On 12/21/18 20:28, Bjorn Andersson wrote:
> >
> > Perhaps there's a better way to define that this particular clock
> > hardware can change rate, but in this implementation it must not?
> 
> the initialization for this particular PLL on this particular platform 
> is wrong
> as the interface does not apply to the platform needs even though it is an
> alpha_pll
> 
> if the VCO is not an option -even though it reflects the platform 
> constrains-
> I would suggest nullifying the alpha_pll_ops that do not apply to this 
> platform:
> ie: set_rate, round_rate set to null in the probe.
> 
> allowing the interface calls (ops) to go through to later on make them fail
> based on some setting would be fundamentally wrong IMO
> 

We have clk_alpha_pll_postdiv_ro_ops so maybe just add another set of
those for the alpha_pll itself? 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
