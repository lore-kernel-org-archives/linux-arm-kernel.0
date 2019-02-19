Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEC32147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kSJNAknu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEC32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EJLkSPatEQaoktiSMCu49AuwOSFhuIspn/b5kp7YxZg=; b=kSJNAknusYMqfW
	PvPOtyMUW/bbUw7qWPwhjzhE7YNnSklo4oWti1JXEkzAzfV7ZxVSE37/WJGlvUD8s/qWEyw6VF9/+
	y7YMI85H3u7aMxtMWIx28Xn0ahHJeOg8yWGRUns4EaMTDHiM6dtLgB/8FJ+svTqQEpc3s0RwWYjFN
	vRec4fbsFi7Nb+VLlVNLz2KnRpEjkjSVR/r/eL/U2PAHATIqpOxopfDvRfoQSuoBBxRmKeJoEv9yc
	SzpUxHPzyDnJc/Jc0nC0U5dItSDV+lVwthRi8i8Gf3A/3KYPI/UdDeVf7bZdDJHx4/cYkOSgiQw0l
	TYxLshCHqLsNIb7JvpiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw895-00025C-1P; Tue, 19 Feb 2019 16:21:23 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw890-00024k-Hz
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:21:20 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2F7DC60006;
 Tue, 19 Feb 2019 16:21:02 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: mvebu: dt for v5.1 (#1)
In-Reply-To: <CAK8P3a1+anoAJvXmU8xCVnyuEAVC-Hs055ybZjmUmfJRdd0x=w@mail.gmail.com>
References: <87k1ia561h.fsf@FE-laptop>
 <CAK8P3a1+anoAJvXmU8xCVnyuEAVC-Hs055ybZjmUmfJRdd0x=w@mail.gmail.com>
Date: Tue, 19 Feb 2019 17:21:02 +0100
Message-ID: <87r2c321ht.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_082118_745182_BCBA535E 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQXJuZCwKIAogT24gdmVuLiwgZsOpdnIuIDE1IDIwMTksIEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+IHdyb3RlOgoKPiBPbiBGcmksIEZlYiA4LCAyMDE5IGF0IDEwOjIyIFBNIEdyZWdv
cnkgQ0xFTUVOVAo+IDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgo+Cj4+Cj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPj4gQW5kcmV3IEx1bm4gKDEpOgo+PiAgICAgICBhcmNoOiBhcm06IGR0czogUmVt
b3ZlIGRpc2FibGVkIG1hcnZlbGwsZHNhIHByb3BlcnRpZXMKPj4KPj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2FybWFkYS0zNzAtcmQuZHRzICAgICAgICAgICAgfCA0MiAtLS0tLS0tLS0tLS0tLS0tLS0t
Cj4+ICBhcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzg4LWNsZWFyZm9nLmR0cyAgICAgIHwgNTgg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS14
cC1saW5rc3lzLW1hbWJhLmR0cyAgfCA0NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2tpcmt3b29kLWRpcjY2NS5kdHMgICAgICAgICAgfCA0NyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2tpcmt3b29kLWxpbmtzeXMtdmlwZXIu
ZHRzICAgfCA0NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2tp
cmt3b29kLW12ODhmNjI4MWd0dy1nZS5kdHMgfCA0NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2tpcmt3b29kLXJkODhmNjI4MS5kdHNpICAgICAgfCA0MSAtLS0t
LS0tLS0tLS0tLS0tLS0KPj4gIDcgZmlsZXMgY2hhbmdlZCwgMzI5IGRlbGV0aW9ucygtKQo+Cj4g
Q291bGQgeW91IGhhdmUgYSBsb29rIGF0IHRoZXNlIHdhcm5pbmdzIGFuZCBzZW5kIGEgZm9sbG93
LXVwIHB1bGwgcmVxdWVzdD8KPgo+IC4uL2FyY2gvYXJtL2Jvb3QvZHRzL2tpcmt3b29kLXJkODhm
NjI4MS16MC5kdHM6MjEuNC0xNjogV2FybmluZwo+IChyZWdfZm9ybWF0KTogL2RzYS9zd2l0Y2hA
MDpyZWc6IHByb3BlcnR5IGhhcyBpbnZhbGlkIGxlbmd0aCAoOCBieXRlcykKPiAoI2FkZHJlc3Mt
Y2VsbHMgPT0gMiwgI3NpemUtY2VsbHMgPT0gMSkKPiAuLi9hcmNoL2FybS9ib290L2R0cy9raXJr
d29vZC1yZDg4ZjYyODEtejAuZHRzOjIzLjUtMTU6IFdhcm5pbmcKPiAocmVnX2Zvcm1hdCk6IC9k
c2Evc3dpdGNoQDAvcG9ydEA0OnJlZzogcHJvcGVydHkgaGFzIGludmFsaWQgbGVuZ3RoICg0Cj4g
Ynl0ZXMpICgjYWRkcmVzcy1jZWxscyA9PSAyLCAjc2l6ZS1jZWxscyA9PSAxKQo+IGFyY2gvYXJt
L2Jvb3QvZHRzL2tpcmt3b29kLXJkODhmNjI4MS16MC5kdGI6IFdhcm5pbmcKPiAocGNpX2Rldmlj
ZV9idXNfbnVtKTogRmFpbGVkIHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcKPiBhcmNoL2FybS9i
b290L2R0cy9raXJrd29vZC1yZDg4ZjYyODEtejAuZHRiOiBXYXJuaW5nIChpMmNfYnVzX3JlZyk6
Cj4gRmFpbGVkIHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcKPiBhcmNoL2FybS9ib290L2R0cy9r
aXJrd29vZC1yZDg4ZjYyODEtejAuZHRiOiBXYXJuaW5nIChzcGlfYnVzX3JlZyk6Cj4gRmFpbGVk
IHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcKPiAuLi9hcmNoL2FybS9ib290L2R0cy9raXJrd29v
ZC1yZDg4ZjYyODEtejAuZHRzOjIwLjEyLTI2LjU6IFdhcm5pbmcKPiAoYXZvaWRfZGVmYXVsdF9h
ZGRyX3NpemUpOiAvZHNhL3N3aXRjaEAwOiBSZWx5aW5nIG9uIGRlZmF1bHQKPiAjYWRkcmVzcy1j
ZWxscyB2YWx1ZQo+IC4uL2FyY2gvYXJtL2Jvb3QvZHRzL2tpcmt3b29kLXJkODhmNjI4MS16MC5k
dHM6MjAuMTItMjYuNTogV2FybmluZwo+IChhdm9pZF9kZWZhdWx0X2FkZHJfc2l6ZSk6IC9kc2Ev
c3dpdGNoQDA6IFJlbHlpbmcgb24gZGVmYXVsdAo+ICNzaXplLWNlbGxzIHZhbHVlCj4gLi4vYXJj
aC9hcm0vYm9vdC9kdHMva2lya3dvb2QtcmQ4OGY2MjgxLXowLmR0czoyMi4xMS0yNS42OiBXYXJu
aW5nCj4gKGF2b2lkX2RlZmF1bHRfYWRkcl9zaXplKTogL2RzYS9zd2l0Y2hAMC9wb3J0QDQ6IFJl
bHlpbmcgb24gZGVmYXVsdAo+ICNhZGRyZXNzLWNlbGxzIHZhbHVlCj4gLi4vYXJjaC9hcm0vYm9v
dC9kdHMva2lya3dvb2QtcmQ4OGY2MjgxLXowLmR0czoyMi4xMS0yNS42OiBXYXJuaW5nCj4gKGF2
b2lkX2RlZmF1bHRfYWRkcl9zaXplKTogL2RzYS9zd2l0Y2hAMC9wb3J0QDQ6IFJlbHlpbmcgb24g
ZGVmYXVsdAo+ICNzaXplLWNlbGxzIHZhbHVlCj4KClllcyBzdXJlLiBJIHJlYWxpemUgdGhhdCBJ
IHRlc3QgdGhlIGJ1aWxkIHdpdGggdGhlIHdyb25nIGRlZmNvbmZpZwoobXZlYnVfdjdfZGVmY29u
ZmlnIGluc3RlYWQgb2YgbXZlYnVfdjVfZGVmY29uZmlnKSB3aGljaCBtYWRlIG1lIG1pc3MKdGhl
c2Ugd2FybmluZ3MuIEkgYW0gZ29pbmcgdG8gc2VuZCBhIHBhdGNoIHRvIGZpeCBpdCBhbmQgdGhl
biBJIHdpbGwgZG8gYQpmb2xsb3ctdXAgcHVsbCByZXF1ZXN0LgoKR3JlZ29yeQoKCj4gVGhhbmtz
LAo+Cj4gICAgICAgQXJuZAoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRlZCBM
aW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
