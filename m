Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D3D20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T+26269j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D3D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YEwC8NEYoLD2Pmh87E3b3SaFda8cV8RjFSRmr6HdW7o=; b=T+26269j+zWeWG
	U4wXbmMJuK3ZMAfOi/7d8/9GT79ni6iwsgIqsHUxN8SAj20ByZiXee/CQHFdmhwaTQTtsaCsog3Oa
	3dHx3YelqSczHn2xTQj4inP87LLVIBXW5wNKyEqAAEAboiH8tr9xTPEmJ7w6I97+El2pX0Q/lvPuE
	D/eJoK1+wM+WU88Ra/OzvkFZZ3bTI2zqhc18credPdhdvUmKZy33OSicvZ+XyNi2jpSzwbaeUSqa2
	xvkt/afHQ/HDU0M6ZoQKt526KUQPDLT/wymIp8Y/vEOAwJ+Bi71UtmanCyASfPHaRhHN+IqiXBIbr
	Yiu6vzvP9KnYFTFhG88g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIzZ-0005Ai-Im; Fri, 07 Dec 2018 16:28:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIzU-0005AE-MI
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:28:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E779120750; Fri,  7 Dec 2018 17:28:21 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8BEF12037D;
 Fri,  7 Dec 2018 17:28:21 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB
References: <634478cc2f11ea3ee3b89393ae6d82f39d3c8531.1544095149.git.baruch@tkos.co.il>
 <87tvjqveee.fsf@bootlin.com> <87ftvak2pq.fsf@tkos.co.il>
Date: Fri, 07 Dec 2018 17:28:22 +0100
In-Reply-To: <87ftvak2pq.fsf@tkos.co.il> (Baruch Siach's message of "Thu, 06
 Dec 2018 19:02:57 +0200")
Message-ID: <87ftv9uwrd.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_082836_861627_BA1B87A7 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAogCiBPbiBqZXUuLCBkw6ljLiAwNiAyMDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVj
aEB0a29zLmNvLmlsPiB3cm90ZToKCj4gSGkgR3JlZ29yeSwKPgo+IEdyZWdvcnkgQ0xFTUVOVCB3
cml0ZXM6Cj4+ICBPbiBqZXUuLCBkw6ljLiAwNiAyMDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0
a29zLmNvLmlsPiB3cm90ZToKPj4KPj4+IEVuYWJsZSB0aGUgVVNCMyBwZXJpcGhlcmFsIHRoYXQg
aXMgd2lyZWQgdG8gQ09OMiBvbiB0aGUgQ2xlYXJmb2cgR1QtOEsKPj4+IGJvYXJkLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+Cj4+PiAtLS0K
Pj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtY2xlYXJmb2ctZ3Qt
OGsuZHRzIHwgNCArKysrCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAt
Y2xlYXJmb2ctZ3QtOGsuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04
MDQwLWNsZWFyZm9nLWd0LThrLmR0cwo+Pj4gaW5kZXggZGZiMjY2NjFhODhlLi41YjRhOTYwOWUz
MWYgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgw
NDAtY2xlYXJmb2ctZ3QtOGsuZHRzCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZl
bGwvYXJtYWRhLTgwNDAtY2xlYXJmb2ctZ3QtOGsuZHRzCj4+PiBAQCAtMjgyLDYgKzI4MiwxMCBA
QAo+Pj4gIAl2cW1tYy1zdXBwbHkgPSA8JnZfM18zPjsKPj4+ICB9Owo+Pj4KPj4+ICsmY3AwX3Vz
YjNfMSB7Cj4+Cj4+IERvbid0IHlvdSBoYXZlIGFueSBwaHkgZm9yIHRoaXMgVVNCMyBwb3J0Pwo+
Cj4gTm90IGFzIGZhciBhcyBJIGNhbiBzZWUuIFdoeSB3b3VsZCBJIG5lZWQgb25lPyBUaGUgc2Vy
ZGVzIHNpZ25hbHMgYXJlCj4gY29ubmVjdGVkIGRpcmVjdGx5IHRvIHRoZSBtaW5pLVBDSWUsIGp1
c3QgbGlrZSB0aGUgVVNCIFR5cGUtQSBjb25uZWN0b3IKPiBvbiB0aGUgc2FtZSBib2FyZC4gSSBo
YXZlbid0IHRlc3RlZCB0aGUgVVNCMyBzaWduYWxzIG9uIHRoZSBtaW5pLVBDSWUsCj4gdGhvdWdo
LCBhcyBJIGhhdmUgbm8gVVNCMyBtaW5pLVBDSWUgZGV2aWNlLgoKUmlnaHQhIEkgZm9jdXNlZCBv
biB0aGUgY29tbWl0IGl0c2VsZiBhbmQgbWlzc2VkIHRoZSBmYWN0IHRoYXQgaXQgd2FzCnBhcnQg
b2YgYSBQQ0kgY29ubmVjdG9yIGFzIHN0YXRlZCBpbiB0aGUgdGl0bGUuIEkgYXNrZWQgdGhpcyBi
ZWNhdXNlCnVzdWFsbHkgd2UgaGF2ZSBhIHBoeSBjb25uZWN0ZWQgdG8gYSB2Y2Mgc2lnbmFsLgoK
QXBwbGllZCBvbiBtdmVidS9kdDY0CgpUaGFua3MsCgpHcmVnb3J5CgoKCj4KPiBiYXJ1Y2gKPgo+
Pj4gKwlzdGF0dXMgPSAib2theSI7Cj4+PiArfTsKPj4+ICsKPj4+ICAmY3AxX3BpbmN0cmwgewo+
Pj4gIAkvKgo+Pj4gIAkgKiBNUFAgQnVzOgo+Pj4gLS0KPj4+IDIuMTkuMgo+Pj4KPgo+Cj4gLS0K
PiAgICAgIGh0dHA6Ly9iYXJ1Y2guc2lhY2gubmFtZS9ibG9nLyAgICAgICAgICAgICAgICAgIH4u
IC5+ICAgVGsgT3BlbiBTeXN0ZW1zCj4gPX0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS1vb08tLVUtLU9vby0tLS0tLS0tLS0tLXs9Cj4gICAgLSBiYXJ1Y2hA
dGtvcy5jby5pbCAtIHRlbDogKzk3Mi41Mi4zNjguNDY1NiwgaHR0cDovL3d3dy50a29zLmNvLmls
IC0KCi0tIApHcmVnb3J5IENsZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5l
bCBlbmdpbmVlcmluZwpodHRwOi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
