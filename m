Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C594C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C7620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uC/zIILP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g29925gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C7620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MsWk8p0KjZNLQ6uYtWrjc+w7AxB8HBJlWlGDNQujlo0=; b=uC/zIILPaEvkmj
	rt8oAs6bt9g4fcZHNgesSf/UyNZYqUJ/xAnaEEeXBoPZNfRLXigyXnaY3b6RHOaQusH1c8XAWWu7v
	xV6qcxApVlUOkYMDUXJY/AURmQM2FAhW1BFeHCdafeh4V/NK/GmU4qVqcVBpJPBNNlPoj/ZBEBDz9
	zfiiVQL0biHc57adNysdS3VaWIbzbustNaZCRdn8yc7RhMO5+t9fnKkwJQfE2qQjIV/AQFd7w+N8T
	ZHgdSRU1wgsTtgM1gBhRqEpqvOXIRufRBniuYegBHzryVEut3ki53mP6o30NxHzMNsjylbUPxIQLn
	1k7Fincdnxs3AyUv1uDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWEs8-0001Vd-Sp; Mon, 10 Dec 2018 06:16:52 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWEs5-0001Tf-Ds
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 06:16:50 +0000
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so9577789wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 22:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=PbJwxQUzTE/UyEN2i6C98e48JCS+XOpPs+LaaL0XlQY=;
 b=g29925gTNUh8hi1KXX7yPrvThITSjsc+EqvvtA9BfPAKq2ZT5q3edLDUU9z24lnLkw
 39qlsbqUFl/awFkVOOH07plucfcDFQdyWuVwP7B81qMlJr2xX3DRsYpdUo7/Ma63Z/gN
 g/IPRxnhTlXHbPVtGzhcDZeQSydxUJ71HrmkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=PbJwxQUzTE/UyEN2i6C98e48JCS+XOpPs+LaaL0XlQY=;
 b=qZ5YBJlVvatOP4kLZWvTjvavTvkfW8cNDtr93uZweAQltQ2c+W1pvRVPq6szCImYV0
 gH8S/fuoBmpRiLtEGYQFwraPAo+Khu9lThEq1cu11Wbu+G19feje1011WJ0s/iqht3Lp
 6q6q8Di4rwjtvJA57fplnZyw3hqyRqZGF0XZ2aptNeeADUluVrwsmVfQ1BNTQ75nVGTM
 Uh4zKVBq+c0R3xIq6W6dF6+FnvJ9xDevrGjbNvVZouEu4eTwcU4JrgLA/KyN4n5nuyAB
 z3x9r6qvumpqMXp+6FKvHKt6N3F7Ohl8Mfl6hh09vj+O6c7JnZc686WlHlfzN4w/mE0b
 zDPQ==
X-Gm-Message-State: AA+aEWYt3ittgshoPuuRRY84j6NX6rAgyQ7mKa9um71+2VXxTOpSlZRU
 XbNVS7xEOq6UQa6SMxtp3N0dCw==
X-Google-Smtp-Source: AFSGD/XyItO8k5L9fG7x0e8Z1fPgNJoH6rcs+Unh6SHJmdOrDvn4YtMCtQpYdVW/qVysIdbv3jcd8g==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr9750264wmi.39.1544422597742; 
 Sun, 09 Dec 2018 22:16:37 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id q185sm13080565wmg.14.2018.12.09.22.16.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 22:16:37 -0800 (PST)
Date: Mon, 10 Dec 2018 06:16:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181210061638.GM26661@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181128091532.GU4272@dell> <20181209045241.GF211094@dtor-ws>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209045241.GF211094@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_221649_512796_57050536 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-stm32@st-md-mailman.stormreply.com,
 Philippe Schenker <philippe.schenker@toradex.com>,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-input@vger.kernel.org,
 Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAwOCBEZWMgMjAxOCwgRG1pdHJ5IFRvcm9raG92IHdyb3RlOgoKPiBPbiBXZWQsIE5v
diAyOCwgMjAxOCBhdCAwOToxNTozMkFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBPbiBG
cmksIDIzIE5vdiAyMDE4LCBQaGlsaXBwZSBTY2hlbmtlciB3cm90ZToKPiA+IAo+ID4gPiBNb3Zl
IGRlZmluZXMgdGhhdCBhcmUgQURDIHJlbGF0ZWQgdG8gdGhlIGhlYWRlciBvZiB0aGUgb3Zlcmx5
aW5nIG1mZCwKPiA+ID4gc28gdGhleSBjYW4gYmUgdXNlZCBmcm9tIG11bHRpcGxlIHN1Yi1kZXZp
Y2VzLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPgo+ID4gPiAtLS0KPiA+ID4gCj4gPiA+IENoYW5nZXMg
aW4gdjM6Cj4gPiA+ICAtIE5vbmUKPiA+ID4gCj4gPiA+IENoYW5nZXMgaW4gdjI6Cj4gPiA+ICAt
IFRoaXMgaXMgYSBuZXcgYWRkZWQgY29tbWl0LiBTZXBhcmF0ZSBjb21taXQgZm9yIG1vdmluZyB0
aGUgZGVmaW5lcyBvdXQgb2YKPiA+ID4gICAgZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9zdG1w
ZS10cy5jIHRvIG92ZXJseWluZyBtZmQtZGV2aWNlIGRyaXZlcnMvbWZkL3N0bXBlLmMKPiA+ID4g
IC0gUHJlLWZpeCBkZWZpbmVzIHdpdGggU1RNUEVfCj4gPiA+IAo+ID4gPiAgZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi9zdG1wZS10cy5jIHwgMzQgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LQo+ID4gPiAgaW5jbHVkZS9saW51eC9tZmQvc3RtcGUuaCAgICAgICAgICAgIHwgMTEgKysrKysr
KysrCj4gPiAKPiA+IEFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+
IAo+IFRoZSBzZXJpZXMgc2VlbSB0byBiZSBoZWFkaW5nIHRvd2FyZHMgTUZEIG9yIElJTywgc28g
SSBhc3N1bWUgdGhpcyBwYXRjaAo+IHdpbGwgYmUgbWVyZ2VkIHRocm91Z2ggb25lIG9mIHRoZXNl
IHRyZWVzLgo+IAo+IEFja2VkLWJ5OiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBn
bWFpbC5jb20+CgpJJ2QgYmUgaGFwcHkgdG8gdGFrZSBpdC4KCi0tIApMZWUgSm9uZXMgW+adjueQ
vOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3
aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
