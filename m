Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3DDC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3016820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFQf4s/q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bx+8UGdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3016820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GXdOhj8oNkc0y8+werTsE05ZGz4OxfDp1ZygPM7qg3M=; b=CFQf4s/qm97gbU
	xRpzwBHXVkIfSRpM9TziX4580K54AyiuUE8n+DAtUk6tRsG9OjIlT/Yp1EbeoATr7Sn/+VzyKYGRv
	2SgRF57X7EYhq6T8yVAe9BXMg0X5g51LxDCjPj4QMEzFc/jQLKHEAXc7S+B3J2gEqBlxpF5I5C52u
	xsCSin+CKisjg4ToIIHvbA5MN6FI4Rk86njRVo/AQ+xgM4LQOTyN061n5uUaLgqtT10vHB3S6+1iz
	hjxjNTt9qYh1ciOvH9UXT2ueMc2m1Hev6nD5MnxkmLMdBeFghmIRPkUEHg7hoKTAhEGegwPpbzAjd
	qu+xsdsONllql2GLUhMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCbm-0006d5-6K; Mon, 11 Feb 2019 14:30:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCbk-0006Hw-VF
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 14:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LjhLkBRITSIsUAkh7znX/AbGiOSxLQaAJRY0qVt+mYI=; b=Bx+8UGdJ7ZwXRfeCQUFLhfp6VP
 oONGTRTHT8MdD2cjVyIH1Lss18uY20Z4jRjqqkyfKrP+0HvI9Hm5LAR7TP4EN7Rsiy0vocN9kispd
 lYBCv6b/h4TPcDYtv9sjHljdVD6S9iZlyXuFBkaZ+ZpySCfB8Nc4KlSJefuPVyEPDJukWLgIcbTqu
 SHqlxKiHnMP0wauKom14iQSWyyHjMPVU6eUlu/+mQrYgcIiKozlIN9yDH5EpiWOZUgGrfwdSyn9OJ
 W5L/MS47vS+nuSX+aB+OFnGV2oGfZqtkquJYJ1KPu+hT9U9/NqWVak16UHPED/CT/ycvl0EtxqkWN
 0ARTAQLg==;
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCXJ-0001WF-1Y
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:26:18 +0000
X-Originating-IP: 90.88.22.177
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6B4EC240010;
 Mon, 11 Feb 2019 14:25:38 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 0/4] net: phy: Add 2.5G/5GBASET PHYs support
Date: Mon, 11 Feb 2019 15:25:25 +0100
Message-Id: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_142617_122926_C882E609 
X-CRM114-Status: UNSURE (   7.69  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev@vger.kernel.org, gregory.clement@bootlin.com,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, stefanc@marvell.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIDgwMi4zYnogc3RhbmRhcmQgZGVmaW5lcyAyIG1vZGVzIGJhc2VkIG9uIHRoZSBOQkFTRVQg
YWxsaWFuY2Ugd29yawp0aGF0IGFsbG93IHRvIHVzZSAyLjVHYnBzIGFuZCA1R2JwcyBzcGVlZHMg
b24gQ2F0IDVlLCA2wqBhbmQgNyBjYWJsZXMuCgpUaGlzIHNlcmllcyBhZGRzIHRoZSBuZWNlc3Nh
cnkgaW5mcmFzdHJ1Y3R1cmUgdG8gaGFuZGxlIHRoZXNlIG1vZGVzIHdpdGgKQzQ1IFBIWXMuIFRo
aXMgc2VyaWVzIHdhcyBvcmlnaW5hbGx5IHBhcnQgb2YgYSBiaWdnZXIgb25lLCB0aGF0IGhhcwpz
ZWVuIDIgaXRlcmF0aW9ucyBbMV0gWzJdIHRoYXQgYWRkZWQgc3VwcG9ydCBmb3IgdGhlc2UgbW9k
ZXMgb24gTWFydmVsbApBbGFza2EgUEhZcy4KCkZvbGxvd2luZyBzb21lIGRpc2N1c3Npb25zIHdp
dGggSGVpbmVyIGFuZCBBbmRyZXcgWzNdLCB3ZSBkZWNpZGVkIHRvCnNwbGl0LW91dCB0aGUgZ2Vu
ZXJpYyBwYXJ0cyBzbyB0aGF0IHdlIGNhbiB3b3JrIHRvZ2V0aGVyIG9uIHRoZQpmb2xsb3dpbmcg
c3RlcHMgdG8gZ2V0IHRoZXNlIG1vZGUgZnVsbHkgd29ya2luZyB3aXRoIEFxdWFudGlhIGFuZApN
YXJ2ZWxsIFBIWVMuCgpUaGUgZmlyc3QgMyBwYXRjaGVzIGFyZSByZXdvcmtpbmcgc29tZSBvZiB0
aGUgaW50ZXJuYWwgbmV0d29yayBwaHkKaW5mcmFzdHJ1Y3R1cmUgdG8gaGFuZGxlIHRoZSBuZXcg
bW9kZXMgaW4gYSBtb3JlIGdlbmVyaWMgd2F5LgoKVGhlIDR0aCBwYXRjaCBhZGRzIGFsbCB0aGUg
QzQ1IHJlZ2lzdGVyIGRlZmluaXRpb24gYW5kIGFjY2Vzc2VzIHRoYXQKZm9sbG93cyB0aGUgODAy
LjNieiBzdGFuZGFyZCB0byBzdXBwb3J0IDIuNUdCQVNFVCBhbmQgNUdCQVNFVC4KClsxXSA6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDE5MDExODE1MjM1Mi4yNjQxNy0xLW1heGlt
ZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tLwpbMl0gOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9u
ZXRkZXYvMjAxOTAyMDcwOTQ5MzkuMjczNjktMS1tYXhpbWUuY2hldmFsbGllckBib290bGluLmNv
bS8KWzNdIDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzgxYzM0MGVhLTU0YjAtMWFi
Zi05NGFmLWI4ZGM0ZWU4M2UzYUBnbWFpbC5jb20vCgpNYXhpbWUgQ2hldmFsbGllciAoNCk6CiAg
bmV0OiBwaHk6IE1hc2stb3V0IG5vbi1jb21wYXRpYmxlIG1vZGVzIHdoZW4gc2V0dGluZyB0aGUg
bWF4LXNwZWVkCiAgbmV0OiBwaHk6IE1vdmUgb2Zfc2V0X3BoeV9lZWVfYnJva2VuIHRvIHBoeS1j
b3JlLmMKICBuZXQ6IHBoeTogRXh0cmFjdCBnZW5waHlfYzQ1X3BtYV9yZWFkX2FiaWxpdGllcyBm
cm9tIG1hcnZlbGwxMGcKICBuZXQ6IHBoeTogQWRkIGdlbmVyaWMgc3VwcG9ydCBmb3IgMi41R0Jh
c2VUIGFuZCA1R0Jhc2VUCgogZHJpdmVycy9uZXQvcGh5L21hcnZlbGwxMGcuYyB8ICA3OCArKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvbmV0L3BoeS9waHktYzQ1LmMgICAgfCAxMTEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3BoeS9waHkt
Y29yZS5jICAgfCAgNzIgKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3BoeS9w
aHlfZGV2aWNlLmMgfCAgODEgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51
eC9waHkuaCAgICAgICAgICB8ICAgMyArCiBpbmNsdWRlL3VhcGkvbGludXgvbWRpby5oICAgIHwg
IDE2ICsrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDIxMCBpbnNlcnRpb25zKCspLCAxNTEgZGVsZXRp
b25zKC0pCgotLSAKMi4xOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
