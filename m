Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD3C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524E821848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXpqJsf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524E821848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hYCDCrGDA+msa27OtB0NCG2aKp1tas1vlPvbp/h5hEk=; b=bXpqJsf742N+24
	t3PpyFcZ8aPgDY9IzkxJjehtbxTUIt6s8OsHScp/Ke+6rVFYmPJ8JbrollyeRxHuK4PsClkYahBcS
	4WRSBSNEC2vDs3svEXOrSVxjifu2xGb8Nu4rcNBQ5aWrsStZogbDzaKLyVemTebXAFvi/fZo+LZOd
	fXdSTcrF1qhWp7w1UmsXiz1pgor9EOSeQItVcOD4NOYglz3Jj//OYHi5mWN7wWqIkg4GgwnCEqylW
	2vmpYY0nD3T3bns52JAusRGSRCGLmt3tSQlCda25WQ91zhTPBOaabE1JFzInl1jHOJSK+GejZU70J
	sSMOXjOEHuEler4rtKdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXm8-0003qx-HB; Tue, 29 Jan 2019 18:06:20 +0000
Received: from gateway21.websitewelcome.com ([192.185.45.250])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXm4-0003qE-Ml
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:06:18 +0000
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id 6EEA5400C9C34
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 12:06:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id oXm3g7LG390onoXm3gXTBe; Tue, 29 Jan 2019 12:06:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=44894 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1goXm2-0049dP-6P; Tue, 29 Jan 2019 12:06:14 -0600
Date: Tue, 29 Jan 2019 12:06:12 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] can: mark expected switch fall-throughs
Message-ID: <20190129180612.GA28650@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goXm2-0049dP-6P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:44894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100616_828327_38274ED0 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-can@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBz
d2l0Y2ggY2FzZXMKd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guCgpUaGlz
IHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6Cgpkcml2ZXJzL25ldC9jYW4vcGVh
a19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmM6NjY4OjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50
IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQpkcml2ZXJzL25ldC9j
YW4vc3BpL21jcDI1MXguYzo4NzU6Nzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwg
dGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCmRyaXZlcnMvbmV0L2Nhbi91c2IvcGVh
a191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwg
dGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCmRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nh
bi5jOjg5NTo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPV0KZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmM6OTUzOjE1OiB3
YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0
aHJvdWdoPV0KZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jOiBJbiBmdW5j
dGlvbiDigJhwY2FuX3VzYl9kZWNvZGVfZXJyb3LigJk6CmRyaXZlcnMvbmV0L2Nhbi91c2IvcGVh
a191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwg
dGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCiAgIGlmIChuICYgUENBTl9VU0JfRVJS
T1JfQlVTX0xJR0hUKSB7CiAgICAgIF4KZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2Fu
X3VzYi5jOjQyODoyOiBub3RlOiBoZXJlCiAgY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoK
ICBefn5+CgpXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9
MwoKVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxpbmcK
LVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KCk5vdGljZSB0aGF0IGluIHNvbWUgY2FzZXMgc3BlbGxp
bmcgbWlzdGFrZXMgd2VyZSBmaXhlZC4KSW4gb3RoZXIgY2FzZXMsIHRoZSAvKiBmYWxsIHRocm91
Z2ggKi8gY29tbWVudCBpcyBwbGFjZWQKYXQgdGhlIGJvdHRvbSBvZiB0aGUgY2FzZSBzdGF0ZW1l
bnQsIHdoaWNoIGlzIHdoYXQgR0NDCmlzIGV4cGVjdGluZyB0byBmaW5kLgoKU2lnbmVkLW9mZi1i
eTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4KLS0tCiBkcml2
ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYyAgICAgICAgICAgICAgICAgICAgfCA2ICsrKystLQogZHJp
dmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jIHwgMiArLQogZHJpdmVy
cy9uZXQvY2FuL3NwaS9tY3AyNTF4LmMgICAgICAgICAgICAgICAgIHwgMyArKy0KIGRyaXZlcnMv
bmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYyAgICAgICB8IDIgKy0KIDQgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2Nhbi9hdDkxX2Nhbi5jIGIvZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMKaW5kZXgg
ZDk4YzY5MDQ1YjE3Li4xNzE4YzIwZjljOTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9h
dDkxX2Nhbi5jCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCkBAIC05MDIsNyArOTAy
LDggQEAgc3RhdGljIHZvaWQgYXQ5MV9pcnFfZXJyX3N0YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsCiAJCQkJQ0FOX0VSUl9DUlRMX1RYX1dBUk5JTkcgOgogCQkJCUNBTl9FUlJfQ1JUTF9SWF9X
QVJOSU5HOwogCQl9Ci0JY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91
Z2ggKi8KKwkJLyogZmFsbCB0aHJvdWdoICovCisJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklO
RzoKIAkJLyoKIAkJICogZnJvbTogRVJST1JfQUNUSVZFLCBFUlJPUl9XQVJOSU5HCiAJCSAqIHRv
ICA6IEVSUk9SX1BBU1NJVkUsIEJVU19PRkYKQEAgLTk1MSw3ICs5NTIsOCBAQCBzdGF0aWMgdm9p
ZCBhdDkxX2lycV9lcnJfc3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIAkJbmV0ZGV2X2Ri
ZyhkZXYsICJFcnJvciBBY3RpdmVcbiIpOwogCQljZi0+Y2FuX2lkIHw9IENBTl9FUlJfUFJPVDsK
IAkJY2YtPmRhdGFbMl0gPSBDQU5fRVJSX1BST1RfQUNUSVZFOwotCWNhc2UgQ0FOX1NUQVRFX0VS
Uk9SX1dBUk5JTkc6CS8qIGZhbGx0aHJvdWdoICovCisJCS8qIGZhbGwgdGhyb3VnaCAqLworCWNh
c2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6CiAJCXJlZ19pZHIgPSBBVDkxX0lSUV9FUlJBIHwg
QVQ5MV9JUlFfV0FSTiB8IEFUOTFfSVJRX0JPRkY7CiAJCXJlZ19pZXIgPSBBVDkxX0lSUV9FUlJQ
OwogCQlicmVhazsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtf
cGNpZWZkX21haW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21h
aW4uYwppbmRleCBjNDU4ZDVmZGM4ZDMuLmU0ZjRkNjVhNzZiNCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYwpAQCAtNjY4LDcgKzY2OCw3IEBAIHN0
YXRpYyBpbnQgcGNpZWZkX2Nhbl9wcm9iZShzdHJ1Y3QgcGNpZWZkX2JvYXJkICpwY2llZmQpCiAJ
CXBjaWVmZF9jYW5fd3JpdGVyZWcocHJpdiwgQ0FORkRfQ0xLX1NFTF84ME1IWiwKIAkJCQkgICAg
UENJRUZEX1JFR19DQU5fQ0xLX1NFTCk7CiAKLQkJLyogZmFsbHRob3VnaCAqLworCQkvKiBmYWxs
IHRocm91Z2ggKi8KIAljYXNlIENBTkZEX0NMS19TRUxfODBNSFo6CiAJCXByaXYtPnVjYW4uY2Fu
LmNsb2NrLmZyZXEgPSA4MCAqIDEwMDAgKiAxMDAwOwogCQlicmVhazsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jIGIvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4
LmMKaW5kZXggZTkwODE3NjA4NjQ1Li4xNzI1N2M3M2MzMDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bmV0L2Nhbi9zcGkvbWNwMjUxeC5jCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5j
CkBAIC04NzUsNyArODc1LDggQEAgc3RhdGljIGlycXJldHVybl90IG1jcDI1MXhfY2FuX2lzdChp
bnQgaXJxLCB2b2lkICpkZXZfaWQpCiAJCQlpZiAobmV3X3N0YXRlID49IENBTl9TVEFURV9FUlJP
Ul9XQVJOSU5HICYmCiAJCQkgICAgbmV3X3N0YXRlIDw9IENBTl9TVEFURV9CVVNfT0ZGKQogCQkJ
CXByaXYtPmNhbi5jYW5fc3RhdHMuZXJyb3Jfd2FybmluZysrOwotCQljYXNlIENBTl9TVEFURV9F
UlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLworCQkJLyogZmFsbCB0aHJvdWdoICovCisJ
CWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6CiAJCQlpZiAobmV3X3N0YXRlID49IENBTl9T
VEFURV9FUlJPUl9QQVNTSVZFICYmCiAJCQkgICAgbmV3X3N0YXRlIDw9IENBTl9TVEFURV9CVVNf
T0ZGKQogCQkJCXByaXYtPmNhbi5jYW5fc3RhdHMuZXJyb3JfcGFzc2l2ZSsrOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jIGIvZHJpdmVycy9uZXQv
Y2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jCmluZGV4IDEzMjM4YTcyYTMzOC4uZWNhNzg1NTMy
YjZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMK
KysrIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jCkBAIC00MjMsNyAr
NDIzLDcgQEAgc3RhdGljIGludCBwY2FuX3VzYl9kZWNvZGVfZXJyb3Ioc3RydWN0IHBjYW5fdXNi
X21zZ19jb250ZXh0ICptYywgdTggbiwKIAkJCW5ld19zdGF0ZSA9IENBTl9TVEFURV9FUlJPUl9X
QVJOSU5HOwogCQkJYnJlYWs7CiAJCX0KLQkJLyogZWxzZTogZmFsbCB0aHJvdWdoICovCisJCS8q
IGZhbGwgdGhyb3VnaCAqLwogCiAJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoKIAkJaWYg
KG4gJiBQQ0FOX1VTQl9FUlJPUl9CVVNfSEVBVlkpIHsKLS0gCjIuMjAuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
