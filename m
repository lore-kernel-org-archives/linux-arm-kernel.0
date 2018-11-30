Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C42DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2012145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sdhRVbkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2012145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G69asx2UBU4XaBD7cO/4V0WD85HwnB9xQHJgu1qv5fo=; b=sdhRVbkT9jyxcM
	H2S84MCwyMIupPQ241HFcH/pvrsSIs8e7pgoWTjS+BLxHYSI1fQW1lUqnc/fq46KHu6V+M+sjJS+7
	W9F9yGScvFXZBH1jeF/7toFOXWQG9MhVF8SXltlYNILicPjV1STWVpR9xSRVvJB6mOe8uUob6GPAa
	AkyX9XSvfuB1y2urqX3/7EaN7hjEm8PakIQoIvABkpf8fKqh2BvhvI7fY1JEEvhd9YITt5BYVBgdD
	8bJJJCENTT/pUjpfh8YPBfTse+WEFFP60WBGiVYqxHv21/ivXk2E0MIQsa9jA9drjOYo3oMWAE/Aj
	N0ZnPcmprNXOJP3RM5kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfvh-00013B-M3; Fri, 30 Nov 2018 10:21:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfve-00011x-6W
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:21:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EC8A420CFB; Fri, 30 Nov 2018 11:21:34 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 44860207A8;
 Fri, 30 Nov 2018 11:20:53 +0100 (CET)
Date: Fri, 30 Nov 2018 11:20:52 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Message-ID: <20181130112052.73d943ec@xps13>
In-Reply-To: <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_022146_369208_551EC3B2 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: kbuild test robot <lkp@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, kbuild-all@01.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gRnJp
LCAzMCBOb3YgMjAxOCAwMToyNjoyMAotMDgwMDoKCj4gUXVvdGluZyBNaXF1ZWwgUmF5bmFsICgy
MDE4LTExLTIzIDAxOjExOjMyKQo+ID4gV291bGQgeW91IGFncmVlIHdpdGggbWUgYWRkaW5nIGR1
bW15IGZ1bmN0aW9ucyBpbiB0aGUgI2Vsc2Ugc2VjdGlvbgo+ID4gbGlrZToKPiA+IAo+ID4gc3Rh
dGljIGlubGluZSB2b2lkIF9fY2xrX2RldmljZV9saW5rKHN0cnVjdCBkZXZpY2UgKmNvbnN1bWVy
LCBzdHJ1Y3QgY2xrICpjbGspCj4gPiB7Cj4gPiAgICAgICAgcmV0dXJuOwo+ID4gfQo+ID4gCj4g
PiBzdGF0aWMgaW5saW5lIHZvaWQgX19jbGtfZGV2aWNlX3VubGluayhzdHJ1Y3QgY2xrICpjbGsp
Cj4gPiB7Cj4gPiAgICAgICAgcmV0dXJuOwo+ID4gfQo+ID4gCj4gPiBEbyB5b3Ugd2FudCBtZSB0
byBhbHNvIGRlY2xhcmUgdGhlc2UgZnVuY3Rpb25zIGluIHRoZSAjaWYgc2VjdGlvbgo+ID4gKHdp
dGggdGhlIGV4dGVybmFsIGtleXdvcmQpIHRvIGJhbGFuY2UgdGhlIGFib3ZlIGRlY2xhcmF0aW9u
cz8gIAo+IAo+IFdoeSBjYW4ndCB3ZSBkbyB0aGUgbGlua2luZyBpbiBfX2Nsa19nZXQoKSBhbmQg
X19jbGtfcHV0KCk/Cj4gCgpCZWNhdXNlIHdlIG5lZWQgdGhlIGNhbGxlcidzICdzdHJ1Y3QgZGV2
aWNlJyB0byBtYWtlIHRoZSBsaW5rIGFuZAp0aGlzIGlzIG5vdCBhdmFpbGFibGUgaW4gX19jbGtf
Z2V0KCkuIEkgdHJpZWQgdG8gYWQgaXQgYXMgcGFyYW1ldGVyIGJ1dApJIGRvbid0IHRoaW5rIGl0
IGlzIHBvc3NpYmxlIHRvIHJldHJpZXZlIGEgJ3N0cnVjdCBkZXZpY2UnIGZyb20gdGhlCmRldmlj
ZSBuYW1lLiBUaGUgZnVuY3Rpb25zIHdoZXJlIHRoaXMgaXMgcHJvYmxlbWF0aWMgYXJlOgoqIGNs
ay5jOl9fb2ZfY2xrX2dldF9mcm9tX3Byb3ZpZGVyKCkKKiBjbGtkZXYuYzpjbGtfZ2V0X3N5cygp
CgpCeSB0aGUgd2F5IGluIG15IG5ldyB2ZXJzaW9uIEkgY2FsbGVkIHRoZSBoZWxwZXJzOgoqIGNs
a197bGluayx1bmxpbmt9X2hpZXJhcmNoeSgpCiogY2xrX3tsaW5rLHVubGlua31fY29uc3VtZXIo
KQoKSSB3aWxsIHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIHRoZXNlIGhlbHBlcnMsIGJ1dCBpZiB5
b3UgaGF2ZSBhbnl0aGluZwppbiBtaW5kIHRvIGhlbHAgbWUgYWNoaWV2ZSB0aGUgYWJvdmUgcmVx
dWVzdCwgSSB3aWxsIHdlbGNvbWUgdGhlIGlkZWEuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
