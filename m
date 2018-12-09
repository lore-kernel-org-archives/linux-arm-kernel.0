Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8846C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BAC20865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TeVjo71j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4bSF/5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BAC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/2Cr9GWyoajqV2eTuugPGNPRvWNCCfEBG/kvQkBN30=; b=TeVjo71j/1rV58
	yxUX7FYxIIqadg6j2We4jBPXy76XIZJRZp3zRyTcPBM0uyomX/gUEtP8cgtB7Wj3HJMfjcjxWy4EB
	+8oEB4ybi20NnZ6nxzLqw3zcAOxG7JWacHHeRppWUoHW6Z8SWkVO8BaIHM2YgOJA/JFaDR04JoWGc
	nnB0lDFuaAbGz/gYC+uny7LO2RBUiMHB7Tsh/XoiVSbyBIiAKBCh+6FHVV/jqLwMzkVyYd2y/2bDo
	F9AurmI90zkYGrrxsxtYxsvmWtC1uhj1BybNSVFZRCYRt7v8r8sSxFNr8/qu17LSSpTYEH7A5Vr8M
	RPIblFU9VnWCyVEG3JEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVyen-0005M3-Rs; Sun, 09 Dec 2018 12:58:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVyek-0005Le-UU
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 12:58:00 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18BCF20831;
 Sun,  9 Dec 2018 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544360268;
 bh=RlvJOQGooPEKppT0cvqES0zozLmCHQmtaSc7yQMbjTo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C4bSF/5n1ebuJmhPj1xapVtziUNWdBjzGrsLJKKmEt2mLamz9vD4klxRbp5SHPDZ0
 z6ruxggtUmRf/j6f99BJJYZBWjLTr/eJTptusNq43LSHlmQlFGHP+5kBlAf1b6Psut
 s244lW8rH890Pn+yeg7ytWqepexLbYzR7Jp8+I5U=
Date: Sun, 9 Dec 2018 20:57:00 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio"
 for hpa1
Message-ID: <20181209125659.GE22960@dragon>
References: <1544139677-16904-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544139677-16904-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_045758_999661_691CE04F 
X-CRM114-Status: UNSURE (   7.84  )
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
Cc: andrew.smirnov@gmail.com, linux-arm-kernel@lists.infradead.org,
 cphealy@gmail.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 09:41:17PM -0200, Fabio Estevam wrote:
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
> 
> TPA6130A2 SD pin on RDU1 is not really controlled by SoC and instead
> is only meant to notify the system that audio was "muted" by external
> actors. To accommodate that, drop "power-gpio" property of hpa1 node as
> well as specify a name for that GPIO so that userspace can access it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
