Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A656C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468DD206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dwXyWi7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468DD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:From:Date:Reply-To:To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Izp20+OrPnggoZnBxLhc59chPpohku8YCPusBqTJM5M=; b=dwXyWi7wgBdHFy
	XCt/kWr4MGVHMWp1yvvuoHqXfT1u3xXcWbPtZNCMFtRNtG0RPtHAxQAmZmt8g5hxvt79nLD0tGo8n
	uWE9GfWKxUeKZhm4rxbegltAviKnPM/BJTM18OET/YukUMjTzC6L4922m5WHKBHxYjxl5d9VuM4n8
	PzoU5oec5YeEq5I4zy7MBA+afL8n8iGwaHa031pJx2D2aqdxlA7XyXzAB6ffZgEOWQ0UTbEwkV4Sk
	ujP+ADvfyZOt1JShf3eIYHL0ckLRqEpkX52ISx9S7CxdaM+3qfXq7ZjPZRzq1612sYFX8QOr4CE6q
	jiGhX4WiPwR3JIOj8u8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpHe-00036c-Jl; Mon, 03 Dec 2018 14:33:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpGe-0001wJ-JP
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:32:33 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DB8422072A; Mon,  3 Dec 2018 15:32:00 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 87E53206FF;
 Mon,  3 Dec 2018 15:32:00 +0100 (CET)
Date: Mon, 3 Dec 2018 15:32:00 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/4] clk: core: link consumer with clock driver
Message-ID: <20181203153200.4f7a036c@xps13>
In-Reply-To: <201812010856.JW2q4YnG%fengguang.wu@intel.com>
References: <20181130153214.9058-3-miquel.raynal@bootlin.com>
 <201812010856.JW2q4YnG%fengguang.wu@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063213_094860_9E197F8F 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgprYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4gd3JvdGUgb24gU2F0LCAx
IERlYyAyMDE4IDA4OjI5OjA1CiswODAwOgoKPiBIaSBNaXF1ZWwsCj4gCj4gSSBsb3ZlIHlvdXIg
cGF0Y2ghIFlldCBzb21ldGhpbmcgdG8gaW1wcm92ZToKPiAKPiBbYXV0byBidWlsZCB0ZXN0IEVS
Uk9SIG9uIGNsay9jbGstbmV4dF0KPiBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uIHY0LjIwLXJj
NCBuZXh0LTIwMTgxMTMwXQo+IFtpZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25n
IGdpdCB0cmVlLCBwbGVhc2UgZHJvcCB1cyBhIG5vdGUgdG8gaGVscCBpbXByb3ZlIHRoZSBzeXN0
ZW1dCj4gCj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRz
L01pcXVlbC1SYXluYWwvQWRkLWRldmljZS1saW5rcy10by1jbG9ja3MvMjAxODEyMDEtMDc0MzA1
Cj4gYmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jbGsvbGludXguZ2l0IGNsay1uZXh0Cj4gY29uZmlnOiBpMzg2LXJhbmRjb25maWcteDA3MS0y
MDE4NDcgKGF0dGFjaGVkIGFzIC5jb25maWcpCj4gY29tcGlsZXI6IGdjYy03IChEZWJpYW4gNy4z
LjAtMSkgNy4zLjAKPiByZXByb2R1Y2U6Cj4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5j
b25maWcgdG8gbGludXggYnVpbGQgdHJlZQo+ICAgICAgICAgbWFrZSBBUkNIPWkzODYgCj4gCj4g
QWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOgo+IAo+ID4+IGRyaXZlcnMvL2Ns
ay9jbGtkZXYuYzoxMTU6MTM6IGVycm9yOiBzdGF0aWMgZGVjbGFyYXRpb24gb2YgJ2Nsa19saW5r
X2NvbnN1bWVyJyBmb2xsb3dzIG5vbi1zdGF0aWMgZGVjbGFyYXRpb24gIAo+ICAgICBzdGF0aWMg
dm9pZCBjbGtfbGlua19jb25zdW1lcihzdHJ1Y3QgZGV2aWNlICpjb25zdW1lciwgc3RydWN0IGNs
ayAqY2xrKSB7fQo+ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgo+ICAgIEluIGZp
bGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzLy9jbGsvY2xrZGV2LmM6MjI6MDoKPiAgICBpbmNsdWRl
L2xpbnV4L2Nsay1wcm92aWRlci5oOjc4NDo2OiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBv
ZiAnY2xrX2xpbmtfY29uc3VtZXInIHdhcyBoZXJlCj4gICAgIHZvaWQgY2xrX2xpbmtfY29uc3Vt
ZXIoc3RydWN0IGRldmljZSAqY29uc3VtZXIsIHN0cnVjdCBjbGsgKmNsayk7Cj4gICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn4KPiA+PiBkcml2ZXJzLy9jbGsvY2xrZGV2LmM6MTE2OjEzOiBlcnJv
cjogc3RhdGljIGRlY2xhcmF0aW9uIG9mICdjbGtfdW5saW5rX2NvbnN1bWVyJyBmb2xsb3dzIG5v
bi1zdGF0aWMgZGVjbGFyYXRpb24gIAo+ICAgICBzdGF0aWMgdm9pZCBjbGtfdW5saW5rX2NvbnN1
bWVyKHN0cnVjdCBjbGsgKmNsaykge30KPiAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fgo+ICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzLy9jbGsvY2xrZGV2LmM6MjI6
MDoKPiAgICBpbmNsdWRlL2xpbnV4L2Nsay1wcm92aWRlci5oOjc4NTo2OiBub3RlOiBwcmV2aW91
cyBkZWNsYXJhdGlvbiBvZiAnY2xrX3VubGlua19jb25zdW1lcicgd2FzIGhlcmUKPiAgICAgdm9p
ZCBjbGtfdW5saW5rX2NvbnN1bWVyKHN0cnVjdCBjbGsgKmNsayk7Cj4gICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fgo+IAo+IHZpbSArL2Nsa19saW5rX2NvbnN1bWVyICsxMTUgZHJpdmVycy8v
Y2xrL2Nsa2Rldi5jCj4gCj4gICAgMTE0CQo+ICA+IDExNQlzdGF0aWMgdm9pZCBjbGtfbGlua19j
b25zdW1lcihzdHJ1Y3QgZGV2aWNlICpjb25zdW1lciwgc3RydWN0IGNsayAqY2xrKSB7fQo+ICA+
IDExNglzdGF0aWMgdm9pZCBjbGtfdW5saW5rX2NvbnN1bWVyKHN0cnVjdCBjbGsgKmNsaykge30g
IAo+ICAgIDExNwkKPiAKCkJvdGggZnVuY3Rpb25zIHNob3VsZCBub3QgYmUgc3RhdGljLiBJIHdp
bGwgcmVtb3ZlIHRoZSBrZXl3b3JkIGluIGEgdjMuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
