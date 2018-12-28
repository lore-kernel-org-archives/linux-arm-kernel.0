Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E1D217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GdcWsMEp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLqDJKWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E1D217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QcSmAGdjIVBfRd1I5Ii4wu3qZZgbQaV2P1CqI3Ljf1o=; b=GdcWsMEp/ohz2G
	H68oy4Pz+Dz1gdkm7vXPSUeZl1m1D02I0b0HRBeXBzPRSYKKM7HLnncabXBShhTXqK15jqAVvelJG
	62aznXmsa4o4RMQKN/lhvX8RuaMl8zK1fFF1mfkRDyBgflvDCaFMZl9dmM2afBKgLsp/LeWC0v2zx
	t13xvxWKooPlYUHXNjJ52eU9ho0QWQSKg4Ju/UqbzaRWdbQFiiqQG5KZ3ThGnYzwo3OU277lwAeQ0
	wvjlNQqGYennQ/6hFYCN7GtffxPJbcWvJSuX4gwrisqMwDR1l+8haMQ7MpD/6GCtOsZI4e+vjRm+X
	TEUXcZPvTQKiehV8kjUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0xX-00062E-H0; Fri, 28 Dec 2018 22:50:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0xV-00061S-4f
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:50:26 +0000
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B208217F9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546037414;
 bh=uVI3otFRq0tFWPeVcKd+mDKORvyqnzzM4+2NNrOZpvY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nLqDJKWJDHGNnXtb3MmAOHUpn0gw76A0gFmLKFDoFWqC0ezsKuUsXX2E7TJEOkh00
 xeezhDzpoAsSmOuG+RTcWQBPIOZva+DwMWMha+nbb5eaThU6oDGk4KBF3WoH1Mbu+o
 wWv62WYIxbezyH1IfwjtAkqKqpCgrMk7tay3SO34=
Received: by mail-lf1-f52.google.com with SMTP id v5so15349454lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 14:50:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbN+jPqRZMza+yw306K5vWESoa9FMleEdxQMLtzjxe1NkVGN+6e
 +rvSZucsKBQipkz0kzeltW1yZoFTpYYmZbYL40w=
X-Google-Smtp-Source: AFSGD/V15kW1pbsIywPYvAVgrXECvr7WoEuIfoP9uIPHnRVftI4INopYcTh9/6YEDYpmMKF9BXc2hFU4DtXOqbEAPi4=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr15895055lfe.87.1546037412298; 
 Fri, 28 Dec 2018 14:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 28 Dec 2018 23:50:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcdKG4rkRh=AQ+zQPYRDbQo=eaOAMe5A6hvGDta796mTA@mail.gmail.com>
Message-ID: <CAJKOXPcdKG4rkRh=AQ+zQPYRDbQo=eaOAMe5A6hvGDta796mTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document
 s5pv210 support
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_145025_199454_8D3F4B08 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 jy0922.shim@samsung.com, airlied@linux.ie,
 Seung Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
 robh+dt@kernel.org, kyungmin.park@samsung.com, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNjoxOSwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGRvY3VtZW50cyBuZXcg
Y29tcGF0aWJsZSBmb3IgczVwdjIxMCBzb2MsCj4gd2hpY2ggd2lsbCBiZSBhbHNvIHN1cHBvcnRl
ZCBieSB0aGlzIGRyaXZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2Vs
Lm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGZyb20gdjE6Cj4gICAt
IFJlbW92ZWQgbGlzdCBlbnVtZXJhdGlvbgo+ICAgLSBQbGFjZWQgczVwdjIxMCBhdCBiZWdpbm5p
bmcgb2YgbGlzdCAoaXQncyB0aGUgb2xkZXN0IGNoaXBzZXQpCj4gLS0tCj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dCB8IDcgKysrKy0t
LQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKQWNr
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4KCkJlc3QgcmVnYXJk
cywKS3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
