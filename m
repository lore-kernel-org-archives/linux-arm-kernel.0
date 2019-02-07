Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CD620857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uy9JsVIV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sFzt0pva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CD620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8KLFpCGw+PQPWb8ZGlRu2X8ov1y94X3ZMJC/fa4lYxI=; b=Uy9JsVIVJjayhJ
	TJZHi7BLpbhPK2fuVKKraFFgT+fx6xOhOLxZYqe8MsJimRM3c3Pvx9uwb5yCh0cbN8Db649riaxhJ
	ZwgyUa1tWnOINGx6MqtSXfZejU729BBfc4rRhCMq1sZtIJQoeOysN5ka8PJRIyy1CtbKkUFR/5ekr
	CfgbjUP+nV+0DxqCaMgeG/Zlqv+qSwh+3YChA8nu3Jdraoj730Ku2zKZpyvi6Z7wciFiGCjFZ8sza
	jexrZXBaXRyMqmjFp5dlyj4+L67xzbXQnZw7fE2dyfXrPzF8SH8SAmve6cYXsa/ZEEoQPlYnORzmq
	8WHjqev7svKtqKiPZ5Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grq0h-000088-Bo; Thu, 07 Feb 2019 20:10:59 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grq0d-00007N-CM
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:10:57 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so1172962wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:cc:subject
 :references:in-reply-to:content-transfer-encoding;
 bh=Ck/ivAOI6YZb4ffmZBEVM0UCgiu1gNXYgsW0Qt7/Rms=;
 b=sFzt0pvanDFTGj4jnduJ9ugaudGws+XUzChJhp1JoJHy23W95TdCCQb7V7BnK2VXaZ
 DvYH7ZiLTvnXmO0uLGA3qW+2m7MCvThnvRMoUHWfu9eZ3UVafBbU2c36+Kv0EgquMmer
 C/TT8rNcnQvCgX5MFqzLw5BKkZSURfa8XFLuicReYga64+FWdkbGm0XKPfkdjcMiTR2U
 9+1JNUNZPfNd/moB3DszZpdjTDdaupgPVZJKkhJMxUvh3a3q2UmwguiKTPooHDRT4DH+
 9v9oWIlV030MCwgThjuNPb6k+e9IsdNpdEQuLmKe7hFENKmlYaU5kFu28pG69WPbikKr
 ceuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :cc:subject:references:in-reply-to:content-transfer-encoding;
 bh=Ck/ivAOI6YZb4ffmZBEVM0UCgiu1gNXYgsW0Qt7/Rms=;
 b=LnOCillypMgQLpfKIzEQA/6HMfwuBfL2PILRwLIye/goyE+4R08eJGqVxATBNK/MJ/
 cE7gL7SJz6At677K9SuNYwTR4gxnF2u8aMOS1tbBayb/vV4o/e8+NWQ0/Xy1/wBLGtOw
 eQRMhzQT0ZXK/k/ZpZiu28krGQMbnjgglrK8jltVhO1CwnDpS3PoM6ot6ffsErlAHbED
 CEOdpYsZzYrNOM9fTsjcHIh7PyHOm1C7Q7ZHfdJdrb1tTje8CDwUlPDHKPChccJSRIZb
 Eskh76VQVZFB0MDqu7hZXvRCBgYw+IJWoPbnu9HJSufPS3nTCocn2o0581D69tCEHlGX
 V1pQ==
X-Gm-Message-State: AHQUAubP9pYsbg4HGqAy2h+/ik/8WE4US91SJuY+o+HCXVxaCC4S2Swr
 fjOJpZwGMfq99izP4OQz6iDHYA==
X-Google-Smtp-Source: AHgI3IZYQqgnqtTsRkvfKurjqv9pgAuxMfR8VAb+RAFqRGCPqUsQCM+FVtobKQXDw9jTbMAlJapfIQ==
X-Received: by 2002:adf:c982:: with SMTP id f2mr8576140wrh.98.1549570252297;
 Thu, 07 Feb 2019 12:10:52 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local
 (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
 by smtp.gmail.com with ESMTPSA id a15sm12008922wrx.58.2019.02.07.12.10.51
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 07 Feb 2019 12:10:51 -0800 (PST)
Message-ID: <5C5C90CA.8050409@baylibre.com>
Date: Thu, 07 Feb 2019 21:10:50 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
References: <20190204091331.9298-1-narmstrong@baylibre.com>	
 <20190204091331.9298-2-narmstrong@baylibre.com>
 <2f03298e4d1ca0aa08d683d6db14bc194607b974.camel@baylibre.com>
In-Reply-To: <2f03298e4d1ca0aa08d683d6db14bc194607b974.camel@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_121055_493547_441BA950 
X-CRM114-Status: GOOD (  18.22  )
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
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAwNy8wMi8yMDE5IDE2OjEwLCBKZXJvbWUgQnJ1bmV0IGEgw6ljcml0IDoKPiBPbiBNb24s
IDIwMTktMDItMDQgYXQgMTA6MTMgKzAxMDAsIE5laWwgQXJtc3Ryb25nIHdyb3RlOgo+PiBBZGQg
YmluZGluZ3MgZm9yIHRoZSBBbWxvZ2ljIEcxMkEgQU8gQ2xvY2sgYW5kIFJlc2V0IGNvbnRyb2xs
ZXJzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOZWlsIEFybXN0cm9uZyA8bmFybXN0cm9uZ0BiYXls
aWJyZS5jb20+Cj4+IC0tLQo+PiAgLi4uL2JpbmRpbmdzL2Nsb2NrL2FtbG9naWMsZ3hiYi1hb2Ns
a2MudHh0ICAgIHwgIDEgKwo+PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9nMTJhLWFvY2xr
Yy5oICAgICAgIHwgNDMgKysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9yZXNldC9nMTJhLWFvY2xrYy5oICAgICAgIHwgMTggKysrKysrKysKPj4gIDMgZmlsZXMgY2hh
bmdlZCwgNjIgaW5zZXJ0aW9ucygrKQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svZzEyYS1hb2Nsa2MuaAo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvcmVzZXQvZzEyYS1hb2Nsa2MuaAo+Pgo+PiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2FtbG9naWMsZ3hiYi1hb2Nsa2Mu
dHh0IAo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hbWxvZ2lj
LGd4YmItYW9jbGtjLnR4dAo+PiBpbmRleCA3OTUxMWQ3YmIzMjEuLmM0MWYwYmU1ZDQzOCAxMDA2
NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2FtbG9n
aWMsZ3hiYi1hb2Nsa2MudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jbG9jay9hbWxvZ2ljLGd4YmItYW9jbGtjLnR4dAo+PiBAQCAtMTAsNiArMTAsNyBAQCBS
ZXF1aXJlZCBQcm9wZXJ0aWVzOgo+PiAgCS0gR1hMIChTOTA1WCwgUzkwNUQpIDogImFtbG9naWMs
bWVzb24tZ3hsLWFvY2xrYyIKPj4gIAktIEdYTSAoUzkxMikgOiAiYW1sb2dpYyxtZXNvbi1neG0t
YW9jbGtjIgo+PiAgCS0gQVhHIChBMTEzRCwgQTExM1gpIDogImFtbG9naWMsbWVzb24tYXhnLWFv
Y2xrYyIKPj4gKwktIEcxMkEgKFM5MDVYMiwgUzkwNUQyLCBTOTA1WTIpIDogImFtbG9naWMsbWVz
b24tZzEyYS1hb2Nsa2MiCj4+ICAJZm9sbG93ZWQgYnkgdGhlIGNvbW1vbiAiYW1sb2dpYyxtZXNv
bi1neC1hb2Nsa2MiCj4+ICAtIGNsb2NrczogbGlzdCBvZiBjbG9jayBwaGFuZGxlLCBvbmUgZm9y
IGVhY2ggZW50cnkgY2xvY2stbmFtZXMuCj4+ICAtIGNsb2NrLW5hbWVzOiBzaG91bGQgY29udGFp
biB0aGUgZm9sbG93aW5nOgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9nMTJhLWFvY2xrYy5oIGIvaW5jbHVkZS9kdC0KPj4gYmluZGluZ3MvY2xvY2svZzEyYS1hb2Ns
a2MuaAo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjk5N2Fj
YTE2Yzk0Zgo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xv
Y2svZzEyYS1hb2Nsa2MuaAo+PiBAQCAtMCwwICsxLDQzIEBACj4+ICsvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjArIE9SIEJTRC0zLUNsYXVzZSkgKi8KPj4gKy8qCj4+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMTYgQmF5TGlicmUsIFNBUwo+PiArICogQXV0aG9yOiBOZWlsIEFybXN0
cm9uZyA8bmFybXN0cm9uZ0BiYXlsaWJyZS5jb20+Cj4+ICsgKgo+PiArICogQ29weXJpZ2h0IChj
KSAyMDE4IEFtbG9naWMsIGluYy4KPj4gKyAqIEF1dGhvcjogUWl1ZmFuZyBEYWkgPHFpdWZhbmcu
ZGFpQGFtbG9naWMuY29tPgo+PiArICovCj4+ICsKPj4gKyNpZm5kZWYgRFRfQklORElOR1NfQ0xP
Q0tfQU1MT0dJQ19NRVNPTl9HMTJBX0FPQ0xLCj4+ICsjZGVmaW5lIERUX0JJTkRJTkdTX0NMT0NL
X0FNTE9HSUNfTUVTT05fRzEyQV9BT0NMSwo+PiArCj4+ICsjZGVmaW5lIENMS0lEX0FPX0FIQgkJ
MAo+PiArI2RlZmluZSBDTEtJRF9BT19JUl9JTgkJMQo+PiArI2RlZmluZSBDTEtJRF9BT19JMkNf
TTAJCTIKPj4gKyNkZWZpbmUgQ0xLSURfQU9fSTJDX1MwCQkzCj4+ICsjZGVmaW5lIENMS0lEX0FP
X1VBUlQJCTQKPj4gKyNkZWZpbmUgQ0xLSURfQU9fUFJPRF9JMkMJNQo+PiArI2RlZmluZSBDTEtJ
RF9BT19VQVJUMgkJNgo+PiArI2RlZmluZSBDTEtJRF9BT19JUl9PVVQJCTcKPj4gKyNkZWZpbmUg
Q0xLSURfQU9fU0FSX0FEQwk4Cj4+ICsjZGVmaW5lIENMS0lEX0FPX01BSUxCT1gJOQo+PiArI2Rl
ZmluZSBDTEtJRF9BT19NMwkJMTAKPj4gKyNkZWZpbmUgQ0xLSURfQU9fQUhCX1NSQU0JMTEKPj4g
KyNkZWZpbmUgQ0xLSURfQU9fUlRJCQkxMgo+PiArI2RlZmluZSBDTEtJRF9BT19NNF9GQ0xLCTEz
Cj4+ICsjZGVmaW5lIENMS0lEX0FPX000X0hDTEsJMTQKPj4gKyNkZWZpbmUgQ0xLSURfQU9fQ0xL
ODEJCTE1Cj4+ICsjZGVmaW5lIENMS0lEX0FPX1NBUl9BRENfU0VMCTE2Cj4+ICsjZGVmaW5lIENM
S0lEX0FPX1NBUl9BRENfRElWCTE3Cj4gCj4gRG8gd2UgbmVlZCB0byBleHBvcnQgdGhlIGludGVy
bmFsIHBhcnQgb2YgdGhlc2UgY29tcG9zaXRlIGNsb2NrID8KPiBJIGtub3cgdGhlIG90aGVyIEFP
IGNvbnRyb2xsZXIgZG8gaXQgYnV0IGl0IHdvdWxkIGJlIG5pY2UgdG8gYXZvaWQgaXQsIGxpa2UK
PiBmb3IgdGhlIEVFIGNvbnRyb2xsZXJzIC4uLiB1bmxlc3MgdGhlcmUgaXMgZ29vZCByZWFzb24g
b2YgY291cnNlLgoKSGlzdG9yaWNhbGx5LCB3ZSBleHBvc2VkIGV2ZXJ5dGhpbmcgZm9yIHRoZSBB
TyBjb250cm9sbGVyLAp3ZSBjYW4gZm9sbG93IHRoZSBzYW1lIHNjaGVtZSBhcyB0aGUgRUUgY29u
dHJvbGxlciBzdGFydGluZwpmcm9tIHRoaXMgb25lLgpUaGVyZSBpcyBubyBzdHJvbmcgcmVhc29u
IHRvIGV4cG9zZSBldmVyeXRoaW5nLi4uCgpJJ2xsIHJlcy1waW4gYSB2MiB3aXRoIGJvdGggaXNz
dWVzIGZpeGVkLgoKPiAKPiBTYW1lIGZvciB0aGUgb3RoZXJzIGJlbG93Lgo+IAo+PiArI2RlZmlu
ZSBDTEtJRF9BT19TQVJfQURDX0NMSwkxOAo+PiArI2RlZmluZSBDTEtJRF9BT19DVFNfT1NDSU4J
MTkKPj4gKyNkZWZpbmUgQ0xLSURfQU9fMzJLX1BSRQkyMAo+PiArI2RlZmluZSBDTEtJRF9BT18z
MktfRElWCTIxCj4+ICsjZGVmaW5lIENMS0lEX0FPXzMyS19TRUwJMjIKPj4gKyNkZWZpbmUgQ0xL
SURfQU9fMzJLCQkyMwo+PiArI2RlZmluZSBDTEtJRF9BT19DRUNfUFJFCTI0Cj4+ICsjZGVmaW5l
IENMS0lEX0FPX0NFQ19ESVYJMjUKPj4gKyNkZWZpbmUgQ0xLSURfQU9fQ0VDX1NFTAkyNgo+PiAr
I2RlZmluZSBDTEtJRF9BT19DRUMJCTI3Cj4+ICsjZGVmaW5lIENMS0lEX0FPX0NUU19SVENfT1ND
SU4JMjgKPj4gKwo+PiArI2VuZGlmCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdz
L3Jlc2V0L2cxMmEtYW9jbGtjLmggYi9pbmNsdWRlL2R0LQo+PiBiaW5kaW5ncy9yZXNldC9nMTJh
LWFvY2xrYy5oCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YmQyZTIzMzcxMzVjCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9yZXNldC9nMTJhLWFvY2xrYy5oCj4+IEBAIC0wLDAgKzEsMTggQEAKPj4gKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgT1IgQlNELTMtQ2xhdXNlKSAqLwo+PiArLyoKPj4g
KyAqIENvcHlyaWdodCAoYykgMjAxNiBCYXlMaWJyZSwgU0FTCj4+ICsgKiBBdXRob3I6IE5laWwg
QXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4KPj4gKyAqLwo+PiArCj4+ICsjaWZu
ZGVmIERUX0JJTkRJTkdTX1JFU0VUX0FNTE9HSUNfTUVTT05fRzEyQV9BT0NMSwo+PiArI2RlZmlu
ZSBEVF9CSU5ESU5HU19SRVNFVF9BTUxPR0lDX01FU09OX0cxMkFfQU9DTEsKPj4gKwo+PiArI2Rl
ZmluZSBSRVNFVF9BT19JUl9JTgkJMAo+PiArI2RlZmluZSBSRVNFVF9BT19VQVJUCQkxCj4+ICsj
ZGVmaW5lIFJFU0VUX0FPX0kyQ19NCQkyCj4+ICsjZGVmaW5lIFJFU0VUX0FPX0kyQ19TCQkzCj4+
ICsjZGVmaW5lIFJFU0VUX0FPX1NBUl9BREMJNAo+PiArI2RlZmluZSBSRVNFVF9BT19VQVJUMgkJ
NQo+PiArI2RlZmluZSBSRVNFVF9BT19JUl9PVVQJCTYKPj4gKwo+PiArI2VuZGlmCj4gCj4gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
