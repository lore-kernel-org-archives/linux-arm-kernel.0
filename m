Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iohTShVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ckQMB4j6BJgWLtB0mQIEZRsXFBfVRWU+VoZ2kUKR6S0=; b=iohTShVDAnwop9
	c3jh5s4KXgmGC0FOusPnNyIpUNmlncfUzwiM+CMROcQbA4VvIYBDNw8gBGev5IsZK0KRjKh0+Ur7s
	LUv9PJRbniKbuGD59xlGQXk2kW+YUg7SsFu6uq/6tPkWXXaDFxszB3CsQh2/8E+H9NLlA+zlbWAkT
	Opi5Xxmk9i7JXYei5VfIgqTxL7FHskxhNn6u89rW2a6FPlA29G7rNXudEoZSQ9ntoBeqL+VDeT98C
	PE60BEHBQf+clL4nOuL5Xxhv7r45h0vrV8qnhOfBEtqmKtF7KMCYfG629AgbcY7+eMLwnfsU3CjDC
	4WriL6siRuQxGzYciSwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQKG-0002UP-6I; Thu, 14 Feb 2019 23:21:52 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQK0-0002BN-JO
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 23:21:40 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D1FA020002;
 Thu, 14 Feb 2019 23:21:22 +0000 (UTC)
Date: Fri, 15 Feb 2019 00:21:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Message-ID: <20190214232122.GS10129@piout.net>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
 <20190214230756.GR10129@piout.net>
 <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152137_279441_2B7E2BA1 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 Ludovic.Desroches@microchip.com, mkl@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, davem@davemloft.net, wg@grandegger.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 17:14:05-0600, Gustavo A. R. Silva wrote:
> >>> Also, the gcc documentation says that -Wimplicit-fallthrough=3
> >>> recognizes /* fallthrough */ as a proper fall through comment (and I
> >>> tested with gcc 8.2).
> >>>
> >>
> >> Yeah. But that's not the relevant change in this case.  Notice that the
> >> comment was moved to the very bottom of the previous case.
> >>
> > 
> > Yes and it doesn't matter for gcc, I tested with gcc 8.2.
> > 
> 
> Yeah. But, again, you are missing the relevant part of the patch.
> 

Right, I misread the patch and though you were moving the comment after
the case statement.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
