Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:23:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A6B218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aiyMcstT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A6B218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V/DUTATwSmwCN7hw8GOslTi8gFXXIU+o6kDtAKPnLQI=; b=aiyMcstThI9Obi373Gfp6iNuw
	oowKcRJ4qPlPoKL7CeucT36LNGyo1zk63n7LH9biODegSozOaomcs9um8EPRyw7RAptTZ4yrW8q8B
	Br8E9Yw65ewza6t0UmPluj7lq5gU1tEXSfn1iCoHfOWEGVY3Kqz0EFizqVMFyjR56poTytVdNx+oS
	LlZRN9ddxag7Y9UqfuscjGSsmYTJEPD8XtxHISXgdvb5nqJBLHUFuiwcndXqm0/OLNrbPUMJHRmXz
	wcxi2YLQdzWSHA4KTjivgPpKPoNmVvUNDUIwPWwMyx6S4ShmYj+fqwbdQ/8b9F4W/6W1/jXhmf/57
	1fb2tak1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfU7g-0001aN-E3; Fri, 04 Jan 2019 18:23:08 +0000
Received: from gateway33.websitewelcome.com ([192.185.146.87])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfU7e-0001Ze-2T
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:23:07 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 93C82412C6B
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 12:23:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id fU7cgmWePdnCefU7cgtIBa; Fri, 04 Jan 2019 12:23:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=45416 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gfU7b-000vV2-Ia; Fri, 04 Jan 2019 12:23:04 -0600
Subject: Re: [PATCH] mtd: rawnand: sunxi: Use struct_size() in devm_kzalloc()
To: Boris Brezillon <bbrezillon@kernel.org>
References: <20190104172637.GA28084@embeddedor>
 <20190104191415.126e4a07@bbrezillon>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <02580805-17f7-1cc1-936c-5c73f00fe819@embeddedor.com>
Date: Fri, 4 Jan 2019 12:22:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104191415.126e4a07@bbrezillon>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfU7b-000vV2-Ia
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:45416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_102306_161227_22EC74F4 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hey Boris,

On 1/4/19 12:14 PM, Boris Brezillon wrote:

> 
> I posted the same patch a few days back [1].
> 
> [1]http://patchwork.ozlabs.org/patch/1013855/
> 

Oh, that's great.

It's good to see people adopting the struct_size helper. :)

Happy new year.

Thanks
--
Gustavo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
