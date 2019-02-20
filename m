Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938E0C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCB920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="enmRpNTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCB920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hWjuX2jWEjYo+HfmOuUYVjjSNzy+bQGfmOWpvDWjIfU=; b=enmRpNTfSsuLGl
	ZUsqHTtv9hUSnCNqnDaEtL9hKThJOrdiOLiP/jOzM7jv1oFZQezIvqqOefH8HOnfRiWxvMT2QxNM1
	J+mjZjkJ2FjptEbgEmGgyvn2X9ouvL567RHrshxnjxmyB46SzamjnUvUVA1T6XVFJ+/CwH3SAwwpJ
	caZ6T2BUx2bJD9XYXBgxLPk4Ea7k9+ukmFxa8lz/zc/eexnVLrtoa2/3p80wDa369V9iQH6ciqWwH
	QGErxzIrWl5NbhlmXJfWGPisx0tP8Vm/1F3aruYxLuk8TgSwFC99p9t5TsGBCF1Ob09wzUXYh0QIO
	sz0PgLqSM8ONePE9w21A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRm1-00026v-3K; Wed, 20 Feb 2019 13:18:53 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRly-00026L-1c
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:18:51 +0000
Received: by mail-qt1-f194.google.com with SMTP id s1so910137qte.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jM9Jw3aefaKq+H2j+be/k/Ar6QLO2mjo2F1yZuiawdI=;
 b=ITkEy1AlQxynIG+XTOI7igOhyUT7jTFH+RyDc28MbMyktxbEjOHjm9y8CcjAhITYou
 uzhzdhuasXkY2BZrwGoU/7ZBN2rTNU8gbj19I3i/EE/XPBNbSNIPIQGMq9bllvgJtfIp
 4a+4mzcoLTGBRFyC1Np7R268o2swVj+gEagxDygkufL4dPH15MKEVZgxeoMIKgYNfgV3
 /fhje+VxXj4TgdvRs5MHYBUMA/31I8Pah+qMRt76Hxzq1SSgu0p75cirZjvvTz91VjwS
 0USYpTCNKCdNDiy9Ba5dhWxqkp1LKrUnZurEaKAV1haKYKmGBgbmgWe4YoOWsptZ38nk
 +n3A==
X-Gm-Message-State: AHQUAuZn7PQa4Kt4qsr4T3hOW3wzHWYsEj/dCUt+Ur5mM2RcdGzo6sAo
 LUihB7WahWJiJDpXfmMcihZeWGAPzMQs/tiTL6o=
X-Google-Smtp-Source: AHgI3IZeqeQugYiEdR6EYrPjJWVBGALk5nTuDudEdlIatk05LGXbg83xZwYiXEtk6t0fLob1vUE/JpR1WUyDSdNevMQ=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr12817677qtb.343.1550668729035; 
 Wed, 20 Feb 2019 05:18:49 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
 <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
In-Reply-To: <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 14:18:31 +0100
Message-ID: <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Masami Hiramatsu <masami.hiramatsu@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_051850_089226_44D23DA8 
X-CRM114-Status: GOOD (  23.27  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>, "Sugaya,
 Taichi" <sugaya.taichi@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMjoxNiBQTSBNYXNhbWkgSGlyYW1hdHN1CjxtYXNhbWku
aGlyYW1hdHN1QGxpbmFyby5vcmc+IHdyb3RlOgo+IDIwMTnlubQy5pyIMjDml6Uo5rC0KSAyMToy
OCBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjoKPiA+IE9uIFdlZCwgRmViIDIwLCAyMDE5
IGF0IDEyOjI3IFBNIFN1Z2F5YSwgVGFpY2hpCj4gPiA8c3VnYXlhLnRhaWNoaUBzb2Npb25leHQu
Y29tPiB3cm90ZToKPiA+ID4gT24gMjAxOS8wMi8yMCAxODoyOCwgQXJuZCBCZXJnbWFubiB3cm90
ZToKPiA+ID4gPiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCA4OjQ0IEFNIFN1Z2F5YSBUYWljaGkK
PiA+ID4gPiA8c3VnYXlhLnRhaWNoaUBzb2Npb25leHQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4g
PiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9taWxiZWF1dF9tMTB2X2RlZmNvbmZp
ZyBiL2FyY2gvYXJtL2NvbmZpZ3MvbWlsYmVhdXRfbTEwdl9kZWZjb25maWcKPiA+ID4gPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gPj4gaW5kZXggMDAwMDAwMC4uYTI2MzIxMQo+ID4gPiA+
PiAtLS0gL2Rldi9udWxsCj4gPiA+ID4+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvbWlsYmVhdXRf
bTEwdl9kZWZjb25maWcKPiA+ID4gPj4gQEAgLTAsMCArMSwxNzUgQEAKPiA+ID4gPgo+ID4gPiA+
IEkgbm8gbG9uZ2VyIHNlZSBhbnl0aGluZyBoZXJlIHRoYXQgc2hvdWxkIGJlIHR1cm5lZCBvZmYs
IGJ1dCB5b3UKPiA+ID4gPiBtaWdodCB3YW50IHRvIHJ1biAnbWFrZSBzYXZlZGVmY29uZmlnJyBh
bmQgdXNlIHRoZSBvdXRwdXQgb2YgdGhhdCwKPiA+ID4gPiB0byBtYWtlIGl0IGVhc2llciB0byBr
ZWVwIGl0IHVwIHRvIGRhdGUuCj4gPiA+ID4KPiA+ID4KPiA+ID4gSSBnb3QgaXQsIEkgdXNlIHRo
ZSBvdXRwdXQgb2YgJ21ha2Ugc2F2ZWRlZmNvbmZpZycuCj4gPiA+IE9uZSBxdWVzdGlvbiwgaXMg
dGhhdCBPSyB0byBhZGQgc29tZSBvcHRpb25zIG9uIGl0Pwo+ID4gPiAgIC1CZWNhdXNlICJDT05G
SUdfQVJDSF9NSUxCRUFVVCIgd2FzIG5vdCBsaXN0ZWQuCj4gPgo+ID4gV2hhdCBJJ2QgZG8gaGVy
ZSBpcyB0byBhcHBseSBhbGwgdGhlIHBhdGNoZXMgeW91IHdhbnQgdG8gZ2V0IG1lcmdlZCBpbgo+
ID4gdGhlIG5leHQgZmV3IHJlbGVhc2VzIGJlZm9yZSBydW5uaW5nICdzYXZlZGVmY29uZmlnJyBh
bmQgdXNlIHRoZSBvdXRwdXQKPiA+IG9mIHRoYXQuCj4KPiBMZXQgbWUgY2hlY2suIFdvdWxkIHlv
dSBtZWFuIHRoYXQgdGhlIGRlZmNvbmZpZyB3aWxsIGluY2x1ZGUgYWxsIHRob3NlCj4gZHJpdmVy
cyBjb25maWdzLCB3aGljaCB3aWxsIG5vdCBhcHBlYXIgYXQgdGhpcyBtb21lbnQ/CgpDb3JyZWN0
LgoKPiA+IElmIHlvdSBhbHJlYWR5IGtub3cgdGhhdCB5b3Ugd2lsbCBuZWVkIHRoZSBvcHRpb25z
LCBpbmNsdWRpbmcKPiA+IHRoZW0gbm93IG1lYW5zIHlvdSBkb24ndCBoYXZlIHRvIHVwZGF0ZSB0
aGUgZGVmY29uZmlnIGZpbGUKPiA+IGFzIG11Y2ggaW4gdGhlIGZ1dHVyZS4KPgo+IEkganVzdCBj
b25jZXJuIHRoYXQgaWYgb3RoZXIgc3Vic3lzdGVtIG1haW50YWluZXIgY29tbWVudHMKPiBvbiB0
aGUgY29uZmlnIG5hbWUuIEV2ZW4gaW4gdGhhdCBjYXNlLCBjYW4gd2UganVzdCB1cGRhdGUgdGhl
Cj4gZGVmY29uZmlnIHdpdGggbmV3IG5hbWU/CgpZZXMsIHRoYXQncyBlYXN5IGVub3VnaC4KCiAg
ICAgIEFybmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
