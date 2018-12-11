Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F28C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A5E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dgcjb+8t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wux8QDHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A5E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iObnKsSnnUnUOtSzJXNeLwz2+STHDe9toAb4C/49RRM=; b=Dgcjb+8tx2gAMN
	fGtxGvaJneKLGOLC0VGijiMkXkPeg/2ay8Q0I6TP4Tdncw4pZdUF3UVz+jtKwzgKDykDZSG+LwbXm
	l9eavOQHQ7s6Psz1OPBK3oK5vIZQlE9cG34ZdPrH+l/dyxTZaUAXdcVYFsviJ9xriq7eX83OMzBFJ
	qaH61/uihTy9FeOuaO6FP5vqvM2OdPoNmojlm4E8ECnlCzgofkDmZs5Q9Bm+ZQF//wF5VOzVwg30k
	ZyzxnUv+34PF7wxIO2SbVd9qCETmOj7tM1SCcnjUHHxRKwPvgwDPoGOoWFGYxI57j1gNfIA04v4za
	+k03teuZGuV+NuM0QawA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXXs-0001Mz-Qw; Tue, 11 Dec 2018 02:13:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXXp-0001M3-Qj
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:13:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 815F820672;
 Tue, 11 Dec 2018 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544494379;
 bh=1OSvtFaQq6P1XEzWAYQcCvidSvCuOqcP/zeyayT5R/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wux8QDHHAwXG7XertLHqx8AaFDNfDFGgirzfr1QUFIxq8I5pkfOw1gBdR0WCw/tD3
 q5nwhqqalXbW3MuBcOOeb5UqRswO9L8r9h3Th20hV3L8TL9OFrOpVzzIQ96xmt9CfD
 eNHzr0+68KHq4hY/Vp0vDhEa23Ku6n2uVT4uhBa4=
Date: Tue, 11 Dec 2018 10:12:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC/RFT 05/10] i2c: zx2967: use core helper to mark adapter
 suspended
Message-ID: <20181211021205.GS3987@dragon>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_181309_905417_8358743F 
X-CRM114-Status: UNSURE (   7.30  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-i2c@vger.kernel.org, Jun Nie <jun.nie@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:03:03PM +0100, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version
> and make sure resume mark is set after enabling clocks (not before).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
