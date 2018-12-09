Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2856C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D262081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NxfeL184"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D262081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ipg3qerj33AyHzNRuf3DwClqtS1QhviOpB7adnH3GCU=; b=NxfeL184y+7x3p
	mWJJB9crKzmMhRfrPFNP4BjrFCDgTdun4mCQKlGkt0R92XoVEihtNAzNNFUBmzX6UJ4fC/upVp1Oi
	BG38BMowFLM+00vV819m6oaYp6zOOgdRpUV2+Eb2SSUYByIZ7V8Z1xAoejAoyWSYnwRuL+epTspt1
	+kztuSeetYKGvpKfLmyAnepp2xhEYMi2R521kBRwjRpicsa86Pq6oKa6Fq3SpCjcI2x2GS+G42v31
	O9JIBJ9gcW8HtuQMoC4MGvgSiw1YqhEuiOE7/pdyVCDuK+V3sucqeUlJ7PtxDAU3jSXcLDRlxnpvd
	gKl+k5JjBuxA6IYEN8dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW2EX-0002sR-FJ; Sun, 09 Dec 2018 16:47:09 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW2ET-0002rV-U1
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 16:47:07 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 02F1C8102;
 Sun,  9 Dec 2018 16:46:56 +0000 (UTC)
Date: Sun, 9 Dec 2018 08:46:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181209164650.GX6707@atomide.com>
References: <20181209121318.GA24478@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209121318.GA24478@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_084706_035849_B68F0FEE 
X-CRM114-Status: UNSURE (   8.78  )
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
Cc: mpartap@gmx.net, merlijn@wizzup.org,
 kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
 nekit1000@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> Hi!
> 
> Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> affected. It is bad, because when your battery is low, you get into
> reboot loop and discharge it furher, which batteries do not like.
> 
> Any ideas, or at least idea how to debug this?

Hmm can you check if this is happening with usb unloaded or
unbind? I suspect ohci or musb..

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
