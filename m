Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA612084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AYUy9K4V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="mzvamrFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA612084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-ID:Date:MIME-Version:Subject:To:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zdNkgDKlvle3dpSl0kIV7DRn4vcEkslTjnHWvYFLTzg=; b=AYUy9K4Vdlk+KK
	d9q1GjwnDpI1rsN/Mo/b/PB2HQRG5+AqMlAU+LSVhcCVGk2x93zwqt0mbZsr1jXai483bLXTnctDX
	DTp/r2qTwHu6DQaz/cG89hpxrTN455zPOLNkZyW3yr8DtehjJUPqUrx5pmpIVnSKbqFpIwQ6SOGbo
	sJmt8zzow9HRUPGaBB9iQ8KNaNPztL9DsxpX7RUSjjllqawx+H2kWYH3e6JIQcdfZBwP7xZu/ajdn
	b+OkVwqjVCpTBxJhP3rsiNbl4xAdv4HWT9e432T/TS8T1wM58b5Xnl1UGYqTE9bk+FdFiUWM9vRmG
	v/rqsKDuSyqPxX5Ujj6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giBfY-0000Bn-NQ; Sat, 12 Jan 2019 05:17:16 +0000
Received: from f75.i.mail.ru ([128.140.169.157])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giBfU-0000BA-E4
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 05:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From;
 bh=2OkordgP9XiEk3PhOf8rptzAqBFPUw8xAii3qAhwsvU=; 
 b=mzvamrFB9ubOycsF2rp3d4nhAj5tp3xGSe9IUHffuxJLsVcwOsRYqKhP7fnqj/xlzULQNkb7brCCaJI9bDkcpqjlE5X8+JCH4TOPNvEBdHk8o3lwvc0UJ5lb2VEqliu0zmsVJ9AOrQoVxcHIgrY9MZBtOLeJf+jXPbLIhByrteg=;
Received: by f75.i.mail.ru with local (envelope-from <shc_work@mail.ru>)
 id 1giBfM-0002v1-44; Sat, 12 Jan 2019 08:17:04 +0300
Received: by e.mail.ru with HTTP;
	Sat, 12 Jan 2019 08:17:04 +0300
From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
To: =?UTF-8?B?U2hhd24gR3Vv?= <shawnguo@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzZdIEFSTSBpLk1YMjE6IEFkZCBkZXZpY2V0cmVlIHN1?=
 =?UTF-8?B?cHBvcnQ=?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date: Sat, 12 Jan 2019 08:17:04 +0300
X-Priority: 3 (Normal)
Message-ID: <1547270224.382322259@f75.i.mail.ru>
Authentication-Results: f75.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 228A81D1C6436F277F9F52485CB584D72AF743E69CD48747683AD1B08041BDC52E36580ADAA5251FB96A8978C00D5A23074A40F52AF1438D
X-7FA49CB5: 70AAF3C13DB70168C09775C1D3CA48CFC24E78AA85F86F6CCEDC9CE4EAAF8441BD4B6F7A4D31EC0B5B47ED7565F4D52D9742502CCDD46D0D5DA91C8160F4BAA0B2086D80B05047785571747095F342E8C7A0BC55FA0FE5FC5F8A6425D297A119719DCABCBF6A674947FAEB20B0A7A33C389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE748C0180CAE7FAC38759FD2C0DFB8529175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244528808196A61F38F6BF97AF5DBFECDAD6613EDA0D678DD8D31FAC6785B21BE6C2346D653DC8F96EBFDC7E5DB24DA7E57B1937939186396399F4ED1D881B4DF0A5EE23CE02E1CB6F8C5FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
X-Spam: undefined
In-Reply-To: <20190112025302.GQ32649@dragon>
References: <20181222105200.18502-1-shc_work@mail.ru>
 <20181222105200.18502-2-shc_work@mail.ru>
 <20190112025302.GQ32649@dragon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_211712_835266_3A12E973 
X-CRM114-Status: UNSURE (   3.70  )
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
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@nxp.com>,
 =?UTF-8?B?TlhQIExpbnV4IFRlYW0=?= <linux-imx@nxp.com>,
 =?UTF-8?B?UnVzc2VsbCBLaW5n?= <linux@armlinux.org.uk>,
 =?UTF-8?B?UGVuZ3V0cm9uaXggS2VybmVsIFRlYW0=?= <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8uCgo+0KHRg9Cx0LHQvtGC0LAsIDEyINGP0L3QstCw0YDRjyAyMDE5LCA1OjUzICswMzow
MCDQvtGCIFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz46Cj4KPk9uIFNhdCwgRGVjIDIy
LCAyMDE4IGF0IDAxOjUxOjU2UE0gKzAzMDAsIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6Cj4+IFRo
aXMgcGF0Y2ggYWRkcyBiYXNpYyBkZXZpY2V0cmVlIHN1cHBvcnQgZm9yIGkuTVgyMSBiYXNlZCBT
b0NzLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFNoaXlhbiA8IHNoY193b3JrQG1h
aWwucnUgPgo+V2hhdCBpLk1YMjEgYm9hcmQgYXJlIHlvdSBydW5uaW5nIGRldmljZXRyZWUgc3Vw
cG9ydCBvbj8KCkkgZG9uJ3QgaGF2ZSBhbnkgaGFyZHdhcmUgZm9yIG8uTVgyMSBTb0MuCkhhdmUg
YW55IGNvbW1lbnRzIG9yIHNvbWV0aGluZyB3cm9uZz8KCi0tLQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
