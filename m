Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED41C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEA42081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OCWWf+eN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlPVI4Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEA42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=07PExcPBdEL32E5+XYYhLexYSJRv51vWl817En+hBsQ=; b=OCWWf+eNXuXVjS
	+bZrIQQ3Y0aasIf4r0jrziyrguNhb6wZ5QdYU5b1JPg1j5/+LS3YVbfX8ENbVSf7G19IS7hY8jNcJ
	9l7uaCHPhvsLZbeh2ixfKi+CGN/WqLlsgCuWC08TWGaO4Mu+duXeF6IwCqgHpICXOgr3PeghH4gGF
	Q5xSiF3nBjaBFfB4YD/yo1zsETY76Gy0QZ1WyQG+yqHTybST7Ijvc381UOFnwNFkKsS3ybxbyuGv+
	M1TID2n7ko0T2/IdCuhdq2Ul6bePj/GM94pwqpkybOqSZHDE2c3buta9JrbgCk696NOjYqSSV025E
	J4GxD//leWd+yQV1kuWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkuQ-00055O-LQ; Tue, 11 Dec 2018 16:29:22 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWktx-0003ei-5f
 for linux-arm-kernel@bombadil.infradead.org; Tue, 11 Dec 2018 16:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xbSTEoaKisX18l0XYX8GaKcQhAMAKOgUbyqPxGzYBV0=; b=TlPVI4PvP7lFNAUXYXWSlFoBe
 fvr9OKwV6iSJE9LEQoagd6gm/o/e3R4H83nSmh5lOaqJ9KTidTEEl/g3Gv42GdJB8drG1v7SGSvdZ
 DxYidIadXLhIdg81Bzoz7L3JWo6pHWExsGuOcoC3uhP2UEL+75Im3NbEJorAM4voaxAgF/XT2r5/7
 X0G5rgrILlR1alZo+QM4lBUcBe5LGhi15qF+7iIih857McId44yM1xDJUe7xWV0O1OVRtseSBuNgn
 54lOaPLOZa0c8pPNkhtUskSukfYDrwjBbVBOXH+2W00wgVAMWw49Wvn6+aWwsOENmBd1H9BySwJsf
 jDebTP/kg==;
Received: from muru.com ([72.249.23.125])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkft-0001Gj-Dy
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:14:23 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 7603C8027;
 Tue, 11 Dec 2018 16:14:11 +0000 (UTC)
Date: Tue, 11 Dec 2018 08:14:05 -0800
From: Tony Lindgren <tony@atomide.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP1: add MMC configuration for Palm Tungsten E
Message-ID: <20181211161405.GQ6707@atomide.com>
References: <20181204175812.2678-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204175812.2678-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_161421_591222_C3F31AD1 
X-CRM114-Status: UNSURE (   8.14  )
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181204 09:58]:
> Add initial MMC configuration for Palm Tungsten E to allow using a proper
> rootfs on the device. This still assumes the bootloader enabling the MMC,
> and that the card is always present and writeable.

Applying into omap-for-v4.21/omap1 thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
