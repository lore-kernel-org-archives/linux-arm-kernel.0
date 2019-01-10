Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923AEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:19:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EF6208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HZHnW28r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EF6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nVD0yHVRP+H0BXkUXVgaqjpIZMWWE3VuV6SJJzDnIvM=; b=HZHnW28rHcvGjM
	mr4m3XGS9egmewVHIW9hp3O7pR64jG3yBU6+0tiP0adVS0JVP5MFQV21Y3jE8KTk965n5r5V9d1yW
	mhML+SS8Us4g0Y9MAJvJr6qhe9RAVVOdBZzZLVLSpPmHG04aOH2Nf1ZA8q4tHiJT+WTMOAEVM/X9D
	ZWMEYLL9ittaFeH28h7DnfV3fiHxixR3IqYv2xQiL9bf7XX64im+FQnl2HnyjXVm1BfwqRq+Xm3fw
	0R9pQeEVczW1k+z7MVKITgnD7q/pGXX85Od9ERpKgWrNK1HPuHxFZZIPwEVBIzNblIt0lCC2USAnG
	Kqy9TMLqAcWUxQTzTQZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgns-0005bO-RL; Thu, 10 Jan 2019 20:19:48 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgnp-0005aP-OF
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:19:47 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnk-00040k-BG; Thu, 10 Jan 2019 21:19:40 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnj-0007zH-QO; Thu, 10 Jan 2019 21:19:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/2] ARM: adapt defconfigs to pwm driver split
Date: Thu, 10 Jan 2019 21:19:32 +0100
Message-Id: <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
References: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_121945_942227_2F8E3E88 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgp0byBjb250aW51ZSBjb21waWxpbmcgdGhlIChub3cpIHR3byBwd20taW14IGRyaXZl
cnMgYXMgcGFydCBvZiB0aGUKaW14IGRlZmNvbmZpZ3Mgd2Ugc2hvdWxkIHVwZGF0ZSB0aGVtIHRv
IHVzZSB0aGUgbmV3IG5hbWVzLgoKSSB0aGluayB0aGUgZWFzaWVzdCBoYW5kbGluZyB3b3VsZCBi
ZSB0byBsZXQgdGhlbSBnbyB2aWEgdGhlIHB3bSB0cmVlCndpdGggU2hhd24ncyBBY2sgdG8gZ2V0
IHRoZSB1cGRhdGUgbmVhciB0byB0aGUgYWN0dWFsIHNwbGl0IGludG8KdGhlIG1haW5saW5lLgoK
QmVzdCByZWdhcmRzClV3ZQoKVXdlIEtsZWluZS1Lw7ZuaWcgKDIpOgogIEFSTTogaW14X3Y2X3Y3
X2RlZmNvbmZpZzogY29udGludWUgY29tcGlsaW5nIHRoZSBwd20gZHJpdmVyCiAgQVJNOiBpbXhf
djRfdjVfZGVmY29uZmlnOiBlbmFibGUgUFdNIGRyaXZlcgoKIGFyY2gvYXJtL2NvbmZpZ3MvaW14
X3Y0X3Y1X2RlZmNvbmZpZyB8IDMgKysrCiBhcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZj
b25maWcgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
