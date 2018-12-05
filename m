Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5635BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:15:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A3A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iC+SrWgj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCKzxAFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A3A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uGW5jf2e0ITDSJkC95hgDo3wk+Gd3CaiZLVXbieW9ls=; b=iC+SrWgjivptHD
	DGuA4gvAk8ppZuQqs4qk/3U1X7G+YpQXNjPFGEnIG0VD2Yf3+bWMv2hhUQ+IF2TfPUpobu681yB7z
	JG2vwY5dSxcdRU6pgx8KdQJgr4uG3Dj4NISS03vGllA43fQ0D6d4yTqS+6gcdHHnUS/0YNc4B5sVX
	QtdNMbqSLDCv82pPkujBkeO7sue3Daz8qOb+EvJeINAeF9VTFin0pkBWrM+ZCqEZSiizqcW4pV7ex
	j9S6W6ICP0nqwZgQyiLoBhotXhMsjf+URYzHpA5fOP8Vj52nGJHNggX0CJACOSHjzF51rzQG3PiP3
	aHs+tf7/ik1awSO55GxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOaQ-0007OL-In; Wed, 05 Dec 2018 04:14:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOaO-0007Ng-7Z
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:14:57 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5C172081C;
 Wed,  5 Dec 2018 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543983284;
 bh=hG+6UeTnf4E0BQ4Ur/XgHY3gOM42BDplu8YYp4K9Kwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FCKzxAFj6MI6UBoL0AUhzmqBUIexQvri4AKXiPOerfGDcFPFyCq6cLvRBDJ2j0/yj
 3jmt+/NS/1K9SIdueyNUZ87pyHJYDphOh90pWSUWf+4pVfaLDP59vrvAG7ECUP4YsO
 XD0ejeQKii6Es6nYsUQaR1vko7K2RVRGjN6xe5Yg=
Date: Wed, 5 Dec 2018 12:14:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
Message-ID: <20181205041404.GM3987@dragon>
References: <1543858820-3354-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543858820-3354-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_201456_454505_0D41ABF7 
X-CRM114-Status: UNSURE (   9.35  )
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
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com, liviu.dudau@arm.com,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:40:19PM -0200, Fabio Estevam wrote:
> The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
> number of CPU cores the interrupt controller is wired to.
> 
> i.MX6UL contains a single Cortex-A7, hence the second interrupt specifier
> cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".
> 
> Tested on a imx6ul-evk.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Dropped RFC patches (shouldn't be applied at all, sorry), and applied
these two.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
