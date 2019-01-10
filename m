Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52795C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D19206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENfBcoBN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3L3sYjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D19206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B3gLgact0r3HsMcBNUngIdJllLYrvw/Svedp1jjO3lI=; b=ENfBcoBNkLR/sx
	oP7Gjc6J0c4aHkMZhUbOUnt4+I/VeRrMJmD8oih2JYwyzcrYMuR+pFK3SVrwwxzLVgL3gSO8J2/ob
	q2QiJzC5Xdo8y860oRbSGiwUYHtQgkrPAw1kv9IlS9ecKi0b086RAPO4eA6U30wDxhRg94dPFbZ/y
	5QYoO/Jp3ibTniaY+NHRDdF17MLvcm/6VvIsZheZmEZFtCYbYAV4ZAVJegEU3IzA+ORHC5KpzEZKm
	613rBRRaDR+uiSYBoqaCjTLUrh7v8SUN02raRfeSm2E7KaXNbVWd624N/ZM4T5ju2FDEYMTlnTiGJ
	MLssZlytnji9umOmhXSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUi7-00006X-L2; Thu, 10 Jan 2019 07:25:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUi0-0008Tz-Kl
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:24:59 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E43A1206B7;
 Thu, 10 Jan 2019 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547105096;
 bh=++iHI2xuWU/fTrqQ7Gn7aEg8QylUP918NjneP//+aeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q3L3sYjRlevh9YIi/X4iEDBmrXrrnfyJZ4fU87WHgi20PHRm70lr/bHyPC4+EdWrF
 7Hosu46WnKzbRO35j+QN9tSW6QqIf84gkoH5OFyFRdf+1eI03MJCJYLlfa5bELH8f2
 0w13pJlWYl3bEbxg0Vc5X1E+Oypyam5+y4zYXPbE=
Date: Thu, 10 Jan 2019 15:24:47 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Soeren Moch <smoch@web.de>
Subject: Re: [PATCH] ARM: dts: tbs2910: Switch to SPDX identifier
Message-ID: <20190110072445.GE25218@dragon>
References: <20181211164010.22596-1-smoch@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211164010.22596-1-smoch@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_232456_812789_321255EA 
X-CRM114-Status: UNSURE (   7.65  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 05:40:10PM +0100, Soeren Moch wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
