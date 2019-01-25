Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF2C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7600921855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhMuU6lC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7600921855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c+dCzdHVo5wtRuvrpQh7jyuGzE396gSPoRrgaZN7fhI=; b=AhMuU6lCtNMDL0
	H2dxXsBrM4rv63fLPmoqlrhNm3b35CUcs7DLCe9YOg2CdWbe1YYvMBDrkmmU4gMgp41dwYNOwliez
	0XfWqrHhCdnWEgm8gs6sSeUBbcMrLjJvRONcD4EZ/ow44QotGb7WAvBVK7zgdbA77cF0GvxzeNHq2
	jpbPMFcdxkDM2+aaXMb8PMTB6eLsJGGz+aRk6PUxMZxMwVyhyrFgvwMUJFr2khHpmASfJaJAT/GB9
	zxS2pOwlvKxHWx6pdwcP/oxZbfV61NwLP9mnxUuz514QvDqGL8xVrhHn2HCihSgOuXkIc3Si1N3Jk
	6yFXlUl/KRCAxyTZxvVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxtk-0003c2-5b; Fri, 25 Jan 2019 09:35:40 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxtg-0003bb-It
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:35:38 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmxta-0001gw-Ol; Fri, 25 Jan 2019 10:35:30 +0100
Message-ID: <1548408930.28802.34.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible
 parts
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Fri, 25 Jan 2019 10:35:30 +0100
In-Reply-To: <20190125025528.15645-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
 <20190125025528.15645-3-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013536_776450_F22FE1D6 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDI0LjAxLjIwMTksIDE5OjU1IC0wNzAwIHNjaHJpZWIgQW5ndXMg
QWluc2xpZSAoUHVyaXNtKToKPiBUaGlzIGlzIGlkZW50aWNhbCB0byB0aGUgaW14N2QgZGF0YSBz
dHJ1Y3R1cmVzIGJ1dCB3ZSBuZWVkIHRvCj4gYmUgYWJsZSB0byBkaWZmZXJlbnRpYXRlIHRoYXQg
dGhlIGlteDhtcSBoYXMgMiBzZG1hIGNvbnRyb2xsZXJzLgoKTm8sIHdlIGRvbid0LCBzZWUgY29t
bWVudCBvbiBwYXRjaCA0LzUuIFRoaXMgY2FuIHJldXNlIHRoZSBpbXg3ZCBkYXRhLgoKUmVnYXJk
cywKTHVjYXMKCj4gU2lnbmVkLW9mZi1ieTogQW5ndXMgQWluc2xpZSAoUHVyaXNtKSA8YW5ndXNA
YWtrZWEuY2E+Cj4gLS0tCj4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTAgKysrKysrKysr
Kwo+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPiBpbmRleCA1
ZTVlZjBiNWE5NzMuLmVjNmZiNDhmMzg3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9pbXgt
c2RtYS5jCj4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYwo+IEBAIC01NTYsNiArNTU2LDEy
IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSBzZG1hX2lteDdkID0gewo+ID4gwqAJ
LnNjcmlwdF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg3ZCwKPiDCoH07Cj4gwqAKPiArc3RhdGlj
IHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14OG1xID0gewo+ID4gKwkuY2huZW5ibDAg
PSBTRE1BX0NITkVOQkwwX0lNWDM1LAo+ID4gKwkubnVtX2V2ZW50cyA9IDQ4LAo+ID4gKwkuc2Ny
aXB0X2FkZHJzID0gJnNkbWFfc2NyaXB0X2lteDdkLAo+ICt9Owo+ICsKPiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNkbWFfZGV2dHlwZXNbXSA9IHsKPiA+IMKgCXsK
PiA+IMKgCQkubmFtZSA9ICJpbXgyNS1zZG1hIiwKPiBAQCAtNTc4LDYgKzU4NCw5IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNkbWFfZGV2dHlwZXNbXSA9IHsKPiA+
IMKgCX0sIHsKPiA+IMKgCQkubmFtZSA9ICJpbXg3ZC1zZG1hIiwKPiA+IMKgCQkuZHJpdmVyX2Rh
dGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg3ZCwKPiA+ICsJfSwgewo+ID4gKwkJLm5hbWUg
PSAiaW14OG1xLXNkbWEiLAo+ID4gKwkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcpJnNk
bWFfaW14OG1xLAo+ID4gwqAJfSwgewo+ID4gwqAJCS8qIHNlbnRpbmVsICovCj4gPiDCoAl9Cj4g
QEAgLTU5Miw2ICs2MDEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZG1h
X2R0X2lkc1tdID0gewo+ID4gwqAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzEtc2RtYSIsIC5k
YXRhID0gJnNkbWFfaW14MzEsIH0sCj4gPiDCoAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgyNS1z
ZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXgyNSwgfSwKPiA+IMKgCXsgLmNvbXBhdGlibGUgPSAiZnNs
LGlteDdkLXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDdkLCB9LAo+ID4gKwl7IC5jb21wYXRpYmxl
ID0gImZzbCxpbXg4bXEtc2RtYSIsIC5kYXRhID0gJnNkbWFfaW14OG1xLCB9LAo+ID4gwqAJeyAv
KiBzZW50aW5lbCAqLyB9Cj4gwqB9Owo+IMKgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc2RtYV9k
dF9pZHMpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
