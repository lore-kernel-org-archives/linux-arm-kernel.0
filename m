Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B693620645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rMN2VrcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B693620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ceP/f1sl8RL/8BdlGRwmDyveYEelWeGH+aHqrE0FroY=; b=rMN2VrcXk9YuJH
	kjYi9Q+0Ukm/IBFwZvVHgP/riPi/7cKDv2tE+UyfWC5hTl8ZRdch6iwdqTE8xbvDOxMP/8UEPtRxf
	biYFb+lPIwaG5yE4Lmk65J4cTz+PfoP8zoduX8TeNTxvVawrpgZWoO424E/ChuqZUaQPWXel9WTAd
	QCI8+VTq4BjmvjmuRgQK0hR4lgJh5xz15f6gu6sBlOtjj/79VlLKsLF0hex9KbBrqMTt8AeIVUy69
	jHLTNmFc+2bytncYrJEhRyLksHJkP3bR5Pn9vSbe08x+sL2LuyWWdbRlUwjavKChKG42QKw8wMQAw
	xueJtvbp3dkrbvb5Qfpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQsX-0007iD-Bs; Tue, 15 Jan 2019 15:43:49 +0000
Received: from mail-sh.amlogic.com ([58.32.228.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQsI-0007VY-I5; Tue, 15 Jan 2019 15:43:36 +0000
Received: from [192.168.0.111] (223.166.104.240) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Tue, 15 Jan
 2019 23:44:15 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v8 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
 <20190115094911.75f4edc9@xps13>
Message-ID: <18ad7184-3bbe-4bd1-826a-fce5d31c215c@amlogic.com>
Date: Tue, 15 Jan 2019 23:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190115094911.75f4edc9@xps13>
Content-Language: en-US
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_074334_598318_51EB4EED 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAoKT24gMjAxOS8xLzE1IDE2OjQ5LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IEhp
IEppYW54aW4sCj4gCj4gSmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPiB3cm90
ZSBvbiBTdW4sIDE2IERlYyAyMDE4Cj4gMjM6MTc6NDEgKzA4MDA6Cj4gCj4+IFRoZXNlIHR3byBw
YXRjaGVzIHRyeSB0byBhZGQgaW5pdGlhbCBOQU5EIGRyaXZlciBzdXBwb3J0IGZvciBBbWxvZ2lj
IE1lc29uCj4+IFNvQ3MsIGN1cnJlbnQgaXQgaGFzIGJlZW4gdGVzdGVkIG9uIEdYTChwMjEyKSBh
bmQgQVhHKHM0MDApIHBsYXRmb3JtLgo+Pgo+PiBDaGFuZ2VzIHNpbmNlIFY2IGF0IFs4XQo+PiAg
LSBmaXggYml0ZmxpcHMgY2hlY2tpbmcgZm9yIGJsYW5rIHBhZ2VzCj4+ICAtIHRyYWNlIHRoZSBs
YXRlc3QgY29tbWl0IHdpdGggbmFuZC9uZXh0IGJyYW5jaAo+PiAgLSBjaGVja2luZyB0aGUgcmV0
dXJuIG9mIG1lc29uX25hbmRfb3BfZ2V0X2RtYV9zYWZlXyppbnB1dC9vdXRwdXQqX2J1Zgo+PiAg
LSBhZGQgLmRldGFjaF9jaGlwIGZvciBmcmVlIG1lc29uX25hbmQuZGF0YV9idWYvaW5mb19idWYK
Pj4KPiAKPiBDYW4geW91IHNlbmQgYSB2OSB3aXRoIHRoZSBidWlsZCBmYWlscmUgKG9iamVjdF9p
c19vbl9zdGFjayBwYikgZml4ZWQKPiBhbmQgdGhlIEtjb25maWcgZW50cnkgdXBkYXRlZCAodGhl
IE1lc29uIGNvbW1vbiBjbG9jayB0aGluZykgYXMKPiBzdWdnZXN0ZWQgYnkgTWFydGluPwpJIHNl
bnQgdjkganVzdCBub3csIG9iamVjdF9pc19vbl9zdGFjayBidWlsZCBmYWlsIGlzIGZpeGVkIGFu
ZCBLY29uZmlnIGlzIHVwZGF0ZWQgYXMgTWFydGluIHN1Z2dlc3RlZC4KVGhhbmsgeW91IGZvciB5
b3VyIHRpbWUuCj4gCj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwKPiAKPiAuCj4gCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
