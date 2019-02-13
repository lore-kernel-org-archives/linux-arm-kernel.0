Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BFC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DA720675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BuH/44w2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QfDegrqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DA720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GMaD6mg5rBx4mtzsLt0TQCtgCfaZU/nPdBKobneMkZY=; b=BuH/44w2PheO71
	bX8f05pHSuaFpdrZezlf/+IAc+26m8cKA+vC98tJUbVL3bAsx2O8UzRFzxdazPSH92fOQldg1+VlT
	45ULqhqxCow+O+/c4EBHCtOcsJwZsOqyOhk1qt85QiILg5X06RJaFLHCY9U+hKYHbYyWiZXEke54b
	tG/0rSHbpY3Zhr9Z4cyJMsMp7WfgJTndrFM3PYWrwTEPalXCfVQ54NLZFYiyvRvSbb6mqTLz7zH1V
	95zF9NUcGJ4xQWyS4+o6Z8M8k6YOE2NFWSh8mY9Y125QEt0Qlmh34m2kHix7CJPVXsYPo/hyGGql0
	+agR3HdgkeTdJUU27jqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu0jg-0005QI-Na; Wed, 13 Feb 2019 20:02:24 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu0jd-0005Pn-4C
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 20:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g/IIyeS+dGSxv8gjHKMJPnvLB28d2ppVkMV4l1uageU=; b=QfDegrqMdlpEJY9El+rHTPd7zF
 oQxeNiyjjbdl1tQ+qs+VJ/cfoYKQqyxUYN8kgspI/P1bh6wEVa0jJLvGkboZmmeaoy/SYN4jD9aDM
 HzVZi1C+J4xWW4NzFPIg37Pdir7aNskhFVQ2uE9TXX4p3NpJOszfnbdSNB7IIHHVaj1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gu0ja-0001nW-QQ; Wed, 13 Feb 2019 21:02:18 +0100
Date: Wed, 13 Feb 2019 21:02:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: vf610-zii: Disable SNVS RTC
Message-ID: <20190213200218.GC708@lunn.ch>
References: <20190213182439.6184-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213182439.6184-1-festevam@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_120221_318855_931F9F62 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: andrew.smirnov@gmail.com, shawnguo@kernel.org, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:24:38PM -0200, Fabio Estevam wrote:
> None of these vf610-zii boards have a battery or super-capacitor
> holding up power to the SNVS RTC embedded in the Vybrid SoC,
> so it is preferable to disable the snvsrtc node.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
