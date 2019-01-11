Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77B220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHgEXLua";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYvPcBRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77B220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DtJMpi04hYZB5Zg+l5eDhdCQ1H4BlNVx94RETfVKRbs=; b=eHgEXLua+Bpznh
	eYMSTtz9sQQdDrua/GIW7z299YveP++cWGc36ygRrQRTEdo+uvUBh2Uc+md3w/TS2UEeBx29SH0rY
	wfSevhk+OCs8qAQ4C8hYEXGOkSzuuhiL7RZ5Z4pnLGS4pw/gDD+C5Pkh1WqxPMDDMYO0z+VLTry0O
	CzOIWNxxEubg+BZ6ymEtobCXZTeyPJrBZOMcULI5Lfm2TvpeIQ/KcaFaYeLtvjRYnN6Byj1479jIC
	UdRS0vtuNSzPGUMfOKVZkusQ0sPBCoBd0907uigT6pyZH9Q8gLtNFdvUg3QVQcmOH/9M8BvpPqGnp
	R0QoKEEHDHuY3EDgZuxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtVo-0000eq-5u; Fri, 11 Jan 2019 09:54:00 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtVk-0000ay-5q
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:53:57 +0000
Received: by mail-it1-x143.google.com with SMTP id h65so2200074ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X8BlbWN2HjYlOQtiuSrwPdZOJRLE+ItQTDWpVSJ/AoM=;
 b=VYvPcBRcZVLM7E3GxT8ji68L/CDLZHjqlnGqFP2mWgISzWPJ+0iaEDA5kfN51DbK+t
 RrGRUmJIB7ccFbJC3XBmJN5k0WiMdsnmHP8ECfSDGsYn484QCQ0Sn1KUAQaqi0LWNVC0
 wytD3d4Plm4j4OUHSuMsD0nKcPVVag/YyARZS3gALBEpC/kaHkc3TwHAJhBWw0620sH6
 IbUvtbp61RRrrSAu7tYJeiOprYcJEWEUpFT2erTQWt5WpsgwP75Na0BA77EIYdOkgX60
 TR1Fo02YwUpcKhPfO6qQQrijprvd8Fsw656bC933wmSP+w+cz9S9+DIh3MFFN9ePc3bI
 k2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X8BlbWN2HjYlOQtiuSrwPdZOJRLE+ItQTDWpVSJ/AoM=;
 b=WieZqg4wDPoilbY3MWRooOnWiIKiys0ILPd5PwAMc3z0QLMvk3nRWCkg44eWOhObhG
 dCqchAnvqtFCA/6kX45zEvj65ak4aWGjmTxBPVwbDRNd9v0rm5JfMCMTmZACuD0NVVfo
 5qxWqzQOn3yzeEznIzDKKOLQN/SCiLDgON0vB3PTA9/gX1EQ6eSdpuYzAka8mKJFZzxt
 GP8rqpZVhehvN+qXp/O/J9RFguKWF1eZr6KIJCsy+E477sjvCiOxzAL1wh9MWn7Ls6eM
 8A2uyUu9fGvq5cmmsiPmy6NCRA/VW3bm95J2N5TshLSFd2H9ncznjW1Clega45VV8g83
 YVUw==
X-Gm-Message-State: AJcUukeJZeRI63UXOvtISG5dQkyARLeGAMYADMq1eDZCbYY/vTgim38/
 da0PSqg4SWoe7qfUuhtpdqtUPc8PveuPkif4ylE=
X-Google-Smtp-Source: ALg8bN52T1VUQ0452u28Ck2IgbKwCIo7u0arkYUYOB7DIXGsCnKFnh2P+dQ7xTUxKqdviqaM0dGeIG+plosJXqy29Sk=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr671096iti.61.1547200435077;
 Fri, 11 Jan 2019 01:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
In-Reply-To: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date: Fri, 11 Jan 2019 10:53:44 +0100
Message-ID: <CAKpie0S3ce1gYqf2-ncz9jQdxG-e58bzn2GkCOkT468sL_EapA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting
 regulators fail
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015356_227387_72B88E1F 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 rjw@rjwysocki.net, linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cHQuLCAxMSBzdHkgMjAxOSBvIDEwOjQ2IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4gbmFwaXNhxYIoYSk6Cj4KPiBPbiBUaHUsIDEwIEphbiAyMDE5IGF0IDIxOjUzLCBQYXdl
xYIgQ2htaWVsCj4gPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+
ID4gVGhlcmUgaXMgcG9zc2liaWxpdHksIHRoYXQgd2hlbiBwcm9iaW5nIGRyaXZlciwgcmVndWxh
dG9ycyBhcmUgbm90IHlldAo+ID4gaW5pdGlhbGl6ZWQuIEluIHRoaXMgY2FzZSB3ZSBzaG91bGQg
cmV0dXJuIEVQUk9CRV9ERUZFUiBhbmQgd2FpdCB0aWxsCj4gPiB0aGV5J3JlIGluaXRpYWxpemVk
LCBzaW5jZSB0aGV5J3JlIHJlcXVpcmVkIGN1cnJlbnRseSBmb3IgY3B1ZnJlcSBkcml2ZXIKPiA+
IHRvIHdvcmsuIEFsc28gbW92ZSByZWd1bGF0b3IgaW5pdGlhbGl6YXRpb24gY29kZSBhdCBiZWdp
bm5pbmcgb2YgcHJvYmUsCj4gPiBzbyB3ZSBjYW4gZGVmZXIgYXMgZmFzdCBhcyBwb3NpYmJsZS4K
PiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWll
bEBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+IENoYW5nZXMgZnJvbSB2MToKPiA+ICAgLSBGaXggY29t
cGlsYXRpb24gZXJyb3IKPiA+ICAgLSBSZW9yZ2FuaXplIGNvZGUgc28gaXQncyBzbWFsbGVyCj4g
PiAtLS0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMgfCAzMiArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZy
ZXEvczVwdjIxMC1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMK
PiA+IGluZGV4IGY1MTY5N2YxZTBiMy4uNmRmOTU5NDFiYTk2IDEwMDY0NAo+ID4gLS0tIGEvZHJp
dmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEv
czVwdjIxMC1jcHVmcmVxLmMKPiA+IEBAIC01OTQsNiArNTk0LDI1IEBAIHN0YXRpYyBpbnQgczVw
djIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgICAg
ICAgICAqIHRoaXMgd2hvbGUgZHJpdmVyIGFzIHNvb24gYXMgUzVQVjIxMCBnZXRzIG1pZ3JhdGVk
IHRvIHVzZQo+ID4gICAgICAgICAgKiBjcHVmcmVxLWR0IGRyaXZlci4KPiA+ICAgICAgICAgICov
Cj4gPiArICAgICAgIGFybV9yZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEwsICJ2ZGRhcm0i
KTsKPiA+ICsgICAgICAgaWYgKElTX0VSUihhcm1fcmVndWxhdG9yKSkgewo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChQVFJfRVJSKGFybV9yZWd1bGF0b3IpID09IC1FUFJPQkVfREVGRVIpCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygidmRkYXJtIHJlZ3VsYXRvciBub3QgcmVh
ZHksIGRlZmVyXG4iKTsKPiA+ICsgICAgICAgICAgICAgICBlbHNlCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Cj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXJtX3JlZ3VsYXRvcik7Cj4gPiArICAg
ICAgIH0KPiA+ICsKPiA+ICsgICAgICAgaW50X3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVM
TCwgInZkZGludCIpOwo+ID4gKyAgICAgICBpZiAoSVNfRVJSKGludF9yZWd1bGF0b3IpKSB7Cj4g
PiArICAgICAgICAgICAgICAgaWYgKFBUUl9FUlIoaW50X3JlZ3VsYXRvcikgPT0gLUVQUk9CRV9E
RUZFUikKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJ2ZGRpbnQgcmVndWxh
dG9yIG5vdCByZWFkeSwgZGVmZXJcbiIpOwo+ID4gKyAgICAgICAgICAgICAgIGVsc2UKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3IgdmRk
aW50XG4iKTsKPiA+ICsgICAgICAgICAgICAgICByZWd1bGF0b3JfcHV0KGFybV9yZWd1bGF0b3Ip
Owo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGludF9yZWd1bGF0b3IpOwo+ID4g
KyAgICAgICB9Cj4gPiArCj4KPiBFcnJvciBwYXRocyBhcmUgbm93IG5vdCBjb3JyZWN0LiBZb3Ug
c2hvdWxkIHB1dCB0aGUgcmVndWxhdG9ycyB3aGVuCj4gcmV0dXJuaW5nIGxhdGVyLiBUaGUgcHJl
dmlvdXMgY29kZSBoYWQgdGhlc2UgZXJyb3IgcGF0aHMgd3JvbmcgYXMgd2VsbAo+IC0gbm90IGlv
dW5tYXBwaW5nIC0gYnV0IGlmIHlvdSBtb3ZlIHRoaW5ncyBhcm91bmQsIG1heWJlIGxldCdzIGZp
eAo+IHRoaW5ncy4KT2ssIHdpbGwgZml4IHRoaXMgaW4gbmV3IHZlcnNpb24gYW5kIHdpbGwgcmVz
ZW5kIGl0IChvbmx5IHRoaXMgb25lCnBhdGNoLCBzaW5jZSBhbGwgb3RoZXIgbG9va3Mgb2svYXBw
bGllZCkuCkFsc28gd2lsbCBhZGQgbWlzc2luZyBpb3VubWFwcGluZy9ldGMgdG8gZml4IGFsbCBv
dGhlciBlcnJvciBwYXRocy4KClRoYW5rcwo+Cj4gQmVzdCByZWdhcmRzLAo+IEtyenlzenRvZgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
