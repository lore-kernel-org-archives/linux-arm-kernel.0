Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B172087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g44kMA9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B172087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R3xtsg9koS7nKZH7vPL9KiFGYls4/tl6XC1syYqPle8=; b=g44kMA9rw7mA4d
	6MQ4TKhiXmHJ1erptS/stK7PE7OZzi9F+4gO6YRCJ+fFaIXsXED/0x06bK4w5pmTgxaS3tAMHNzQT
	Hw/wqgxAaqXXK/B28+AZ/aLWM+iPJEJnxPiNgmbFH+t56E/tw65q8tku+ojLn/zAio9P4KkHbw8/G
	sXlfKXYex0Q0+2OmSmOw8uTifpezVWwt3cM0KSnWPgU0F/YKqPIAf/vaK5eBcFnJbgaHmFvW8qZBd
	CwPaWS77q+j4LJP1XW0yapEOsxDg4pk5GBuIq8uqmLoWiWx1/KGC6DKC7KfKla1SGiYWTwZltPoE+
	SXwDXVV/OpxR4m6qgC0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU97A-0005gB-VL; Tue, 04 Dec 2018 11:43:44 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU978-0005fI-4q
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:43:43 +0000
Received: from [192.168.178.52] ([109.104.47.127]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fQ9-1gUyBh3SiF-004Axl; Tue, 04 Dec 2018 12:43:22 +0100
Subject: Re: [PATCH v3 1/3] usb: chipidea: imx: support configuring for active
 low oc signal
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20181204083131.12524-1-u.kleine-koenig@pengutronix.de>
 <20181204083131.12524-2-u.kleine-koenig@pengutronix.de>
 <ce751026-d61f-400e-cb5d-abd9d45dc05f@i2se.com>
 <20181204085250.o4vaviz7ta43zpfo@pengutronix.de>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <05dbcf6d-1551-31b4-4c9b-fb713fc71362@i2se.com>
Date: Tue, 4 Dec 2018 12:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204085250.o4vaviz7ta43zpfo@pengutronix.de>
Content-Language: en-US
X-Provags-ID: V03:K1:Wlx04rhpcU421ifLEn22tkHYNd5hrMeiQTJ2dUArL9DfUOL+qCF
 oKF3pMSWfg/47rwrwrr2B7Dwppe7gUVDuAoK9fsaz2gm/LrXnlgDrD4aRVeIFWzKoxx/JOH
 hkAsHxT4OahlFseRJfS63bOCx5/ni1LTUWSqcOqyDs3+HY98IlepOyGNIQS7avsH4wk/7V2
 UGS7XfnRmT1JKSNrW2oUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHacZCP8arw=:jWZPWbOIUhmszzbw7jENGb
 aN5fx0+hKjmGjpCWOeZzXg2aib1OpwkjPwZRZrbEvw3Xs5pobbg4D29o8rEZAYkPTj9K+8MTH
 KD1aYDbxfb2FMAwoeuy4fIGVuISN8WznqNmxcRLMu1eVZC2YbrG0+K4xS35IZbOadtGUELfO1
 V+lraCQVRyeGMKT5aDTACR/BqOLIm1BnJ7+RfKC2TFJYx6wIormI5LIVUhUWUqYpM33lQTknW
 jSIJ/CqW1o9m+rjca83m6BJL0pWMei9ihDCfjvEh4P8bIdmZ9FKdOpV8npzUY7X0OzFDaemuc
 yYGAQN6yl7azVU9XXlvc9Ul7M9OP/+Mh1Xuwu9Cg3nbQfcClU0ZX2Vf6ma6YezaPvLHA+fPXM
 fS3hRX/YWHwMndK7ZIN+T+JLBo7GUofjUh5FM1LQBm9j+uJvOqjBL86g3mkTiPcRoJD7kYM32
 X4ujAupKORLRdka+1L45SQcv7c4ZZYFez9eNZ+o+ZPjDvFAk8mwNkK98TFYimjh5pzWKQCNcX
 e56eOzwbfltd3qkoHG0rW8Nsmi3/H4lmeMvoBtMMzQqAXetch4cbA9brUefx5dMcqj4aBYUgJ
 TLk3ZDfIXRy9Hnfiokbsf5JBehpPJq5PSQlQWvwVrgVm9OJGFmDwjeI9prtBsbdmOQT6CVxV6
 U1OLSJmjR4YQxSVUbeIxWZyOZsn9JgYDkJ60ykEx+ubYO+4w2n8A5H6KfrgPy52E5ATL607FJ
 71PpCBBY6cmhSP7OXZUHoawXCTgLzuTkIWUlo1EC6Yr35yxj9ULzSktsmlc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_034342_491456_70CEF3EB 
X-CRM114-Status: GOOD (  23.63  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, devicetree@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org,
 Matthew Starr <mstarr@hedonline.com>, Rob Herring <robh+dt@kernel.org>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMDQuMTIuMTggdW0gMDk6NTIgc2NocmllYiBVd2UgS2xlaW5lLUvDtm5pZzoKPiBIZWxsbyBT
dGVmYW4sCj4KPiBPbiBUdWUsIERlYyAwNCwgMjAxOCBhdCAwOTo0MDoyNkFNICswMTAwLCBTdGVm
YW4gV2FocmVuIHdyb3RlOgo+PiBBbSAwNC4xMi4xOCB1bSAwOTozMSBzY2hyaWViIFV3ZSBLbGVp
bmUtS8O2bmlnOgo+Pj4gVGhlIHN0YXR1cyBxdW8gb24gaS5NWDYgaXMgdGhhdCBpZiAib3Zlci1j
dXJyZW50LWFjdGl2ZS1oaWdoIiBpcwo+Pj4gc3BlY2lmaWVkIGluIHRoZSBkZXZpY2UgdHJlZSB0
aGlzIGlzIGNvbmZpZ3VyZWQgYXMgZXhwZWN0ZWQuIElmCj4+PiB0aGUgcHJvcGVydHkgaXMgbWlz
c2luZyBwb2xhcml0eSBpc24ndCBjaGFuZ2VkIGFuZCBzbyB0aGUKPj4+IHBvbGFyaXR5IGlzIGtl
cHQgYXMgc2V0dXAgYnkgdGhlIGJvb3Rsb2FkZXIuIFJlc2V0IGRlZmF1bHQgaXMKPj4+IGFjdGl2
ZSBoaWdoLCBzbyBhY3RpdmUgbG93IGNhbiBvbmx5IGJlIHVzZWQgd2l0aCBoZWxwIGJ5IHRoZQo+
Pj4gYm9vdGxvYWRlci4gT24gaS5NWDcgaXQgaXMgc2ltaWxhciwgYnV0IHRoZXJlIGRpc2FibGlu
ZyBvZgo+Pj4gb3ZlciBjdXJyZW50IGRldGVjdGlvbiBoYXMgYSBzaW1pbGFyIGluY29uc2lzdGVu
Y3kuCj4+Pgo+Pj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IHByb3BlcnR5IHRoYXQgYWxs
b3dzIHRvIGV4cGxpY2l0bHkKPj4+IGNvbmZpZ3VyZSBmb3IgYWN0aXZlIGxvdyBvdmVyIGN1cnJl
bnQgZGV0ZWN0aW9uIGFuZCBjb25zaXN0ZW50bHkKPj4+IHNldHMgdGhpcyB1cC4gSW4gdGhlIGFi
c2VuY2Ugb2YgYW4gZXhwbGljaXQgY29uZmlndXJhdGlvbiB0aGUKPj4+IGJpdCBpcyBrZXB0IGFz
IGlzLiBPbiBpLk1YNyBvdmVyIGN1cnJlbnQgZGV0ZWN0aW9uIGlzIHVzZWQgdW5sZXNzCj4+PiBk
aXNhYmxlZCBpbiB0aGUgZGV2aWNlIHRyZWUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KPj4+IC0tLQo+Pj4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jaS1oZHJjLXVzYjIudHh0ICB8ICA1ICsrLS0K
Pj4+ICBkcml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX2lteC5jICAgICAgICAgICAgfCAxNiAr
KysrKysrKy0tLQo+Pj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmggICAgICAg
ICAgICB8ICA4ICsrKysrLQo+Pj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL3VzYm1pc2NfaW14LmMg
ICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrLS0tLS0KPj4+ICA0IGZpbGVzIGNoYW5nZWQs
IDQzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQKPj4+
IGluZGV4IDUyOWU1MTg3OWZiMi4uYzMyZjZlOTgzY2Y2IDEwMDY0NAo+Pj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jaS1oZHJjLXVzYjIudHh0Cj4+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQK
Pj4+IEBAIC04Nyw4ICs4Nyw5IEBAIGkubXggc3BlY2lmaWMgcHJvcGVydGllcwo+Pj4gIC0gZnNs
LHVzYm1pc2M6IHBoYW5kbGVyIG9mIG5vbi1jb3JlIHJlZ2lzdGVyIGRldmljZSwgd2l0aCBvbmUK
Pj4+ICAgIGFyZ3VtZW50IHRoYXQgaW5kaWNhdGUgdXNiIGNvbnRyb2xsZXIgaW5kZXgKPj4+ICAt
IGRpc2FibGUtb3Zlci1jdXJyZW50OiBkaXNhYmxlIG92ZXIgY3VycmVudCBkZXRlY3QKPj4+IC0t
IG92ZXItY3VycmVudC1hY3RpdmUtaGlnaDogb3ZlciBjdXJyZW50IHNpZ25hbCBwb2xhcml0eSBp
cyBoaWdoIGFjdGl2ZSwKPj4+IC0gIHR5cGljYWxseSBvdmVyIGN1cnJlbnQgc2lnbmFsIHBvbGFy
aXR5IGlzIGxvdyBhY3RpdmUuCj4+PiArLSBvdmVyLWN1cnJlbnQtYWN0aXZlLWxvdzogb3ZlciBj
dXJyZW50IHNpZ25hbCBwb2xhcml0eSBpcyBhY3RpdmUgbG93Lgo+Pj4gKy0gb3Zlci1jdXJyZW50
LWFjdGl2ZS1oaWdoOiBvdmVyIGN1cnJlbnQgc2lnbmFsIHBvbGFyaXR5IGlzIGFjdGl2ZSBoaWdo
Lgo+Pj4gKyAgSXQncyByZWNvbW1lbmRlZCB0byBzcGVjaWZ5IHRoZSBvdmVyIGN1cnJlbnQgcG9s
YXJpdHkuCj4+PiAgLSBleHRlcm5hbC12YnVzLWRpdmlkZXI6IGVuYWJsZXMgb2ZmLWNoaXAgcmVz
aXN0b3IgZGl2aWRlciBmb3IgVmJ1cwo+Pj4gIAo+Pj4gIEV4YW1wbGU6Cj4+IHRoYW5rcyBmb3Ig
bWFraW5nIHRoaXMgY29uZmlndXJhYmxlLiBCdXQgc2hvdWxkbid0IHRoaXMgYmUgYSBzZXBhcmF0
ZQo+PiBwYXRjaCBhbmQgcmV2aWV3ZWQgYnkgdGhlIGRldmljZXRyZWUgZ3V5cz8KPiBJJ20gbm90
IHN1cmUgYWJvdXQgdGhlIHNlcGFyYXRlIHBhdGNoIHBhcnQuIE15IGltcHJlc3Npb24gaXMgaXQg
ZGVwZW5kcwo+IG9uIHRoZSBtYWludGFpbmVyIGlmIGEgY2hhbmdlIHRvIHRoZSBiaW5kaW5nIChv
cHBvc2VkIHRvIHRoZQo+IGludHJvZHVjdGlvbiBvZiBhIGJpbmRpbmcpIHNob3VsZCBiZSBzZXBh
cmF0ZSBvciBub3QuCj4KPiBCdXQgZm9yIHRoZSByZXZpZXcgeW91IGFyZSByaWdodCwgSSBhZGRl
ZCB0aGUgZHQgcGVvcGxlIHRvIENjIGZvciB0aGVtCj4gdG8gY29tbWVudC4gSW4gdjIgTWF0dGhl
dyBhbHNvIG5vdGVkIHRoYXQgaGUgd291bGQgcHJlZmVyIHRvIGhhbmRsZSB0aGUKPiBzaXR1YXRp
b24gd2hlbiBib3RoIG92ZXItY3VycmVudC1hY3RpdmUtbG93IGFuZCBvdmVyLWN1cnJlbnQtYWN0
aXZlLWhpZ2gKPiB3ZXJlIGdpdmVuIGRpZmZlcmVudGx5LiBJIHRoaW5rIHdlIGRvbid0IG5lZWQg
dGhhdCBhcyB0aGlzIGlzIGEgY2FzZSBvZgo+ICJicm9rZW4gZHQiIGFuZCBpdCBkb2Vzbid0IG1h
dHRlciBtdWNoIHdoYXQgaXMgZG9uZSB0aGVuLiAoV2l0aCBteSBwYXRjaAo+IHdlJ3JlIGNvbmZp
Z3VyaW5nIGZvciBhY3RpdmUgaGlnaCBpbiB0aGF0IGNhc2UuKSBBIGZlZWRiYWNrIGhlcmUgd291
bGQKPiBiZSBncmVhdCwgdG9vLgoKQUZBSVIgc3VjaCBpbnZhbGlkIHNldHRpbmdzIHNob3VsZCBi
ZSBjYXRjaGVkIHdpdGggYSBwcm9wZXIgZXJyb3IKbWVzc2FnZSBhbmQgYWJvcnQgb2YgdGhlIHBy
b2JpbmcuCgpSZWdhcmRzClN0ZWZhbgoKPgo+IEJlc3QgcmVnYXJkcwo+IFV3ZQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
