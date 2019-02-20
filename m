Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6EDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A142085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7XEUwXz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ58E2+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A142085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cv+fk6VI1Y+NEVQ/u/IxrnEu6CamGMSKYBLkXFiNn4s=; b=J7XEUwXzJwU2Sm
	bowHdzaTsXRV5uM5HVfxAg5m/RNuwlYPIQK+hIKEl6pyH96RoocWLzGfQyJTngs2jWrddOs7k81Wp
	0h+PBXjRd4ivC2fSjnf274DNeS/loZPAXncl9euhTDTwf3oXZAHHiqo4GYX6GiC6b/2OzSddWCckU
	YHNR08HEPDrW8B58y/vvxqlQPl1YartKOTLKTz2PXZ5ir3ABi3ctzr0iwaWps7EAE7/w6R/BAT/2E
	8a1kzdqvZV0IfT6ojywGHpAAikiQcDnlMOh9c7NVJAc4xBgTP4Nloifn7TTK0A3YBqZNKTvz5gjv7
	TtqCjLI13nIX2oYdOvFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRjl-0001Xc-GJ; Wed, 20 Feb 2019 13:16:33 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRjf-0001XA-Tg
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:16:29 +0000
Received: by mail-yw1-xc42.google.com with SMTP id o184so9164150ywo.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FAlIGQCYj27WzYwAN2yS5eVNYPmVEv6xTu9i5VkvUJg=;
 b=qZ58E2+Rz+r4uOfnHb7+Rvb8IW0J3Lskl7qEDQYV3wOB5bgYbsNDWOvQ8vCEOdF1O3
 7zRYpgJaxYUCKjkND2yugrlnWdC5WdQD55m5BxOzJTkXfT6ECI9WQpauzaMdennYsKaD
 bxLRQ+Ibr9AfEqngwb0KX04f2LGDf5C2o+j74cDFjdOZUDrYm628h9MlSssVoOKh5dM7
 /MzHSso0AL1NyTfc1EqgkS76Y40jawGBbIMoxY2UnsTZM/p/GceRQQZ7qzXBxS/gqBi5
 CIRZyiHDi1bIhgSlyUiaZo7fCcjIBt5Ez3jMqzMfC6BJBdnqEw5pr167xoaWy1T55q1A
 demQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FAlIGQCYj27WzYwAN2yS5eVNYPmVEv6xTu9i5VkvUJg=;
 b=JxYOdw1KDdIIodhzTnTCWKWB7sO/aa2LoBM1u8Q9+6dnwcfEWt/pJIqkxHy6RwF/gx
 tU3uE5CkBQ0Z4X1KRVgMRpGGe07wwjD+rEGa1gttslPyCBBB68z3DoMmYjar42j2GHMI
 u/8l7uvmpa4wYEyivEZ5XbWvCfJ8gxj26yuLTP/uW9W0hlnsy3LfAIZsI9SolJVnUx0N
 pHCDVkc804wHFs87s1CEpeYvyATUN0wy3P/WpVxFl4p+afNrQqihGvWUqt8hjrnXgeK2
 e2DroF4NARhW4lUU2kRQ6GkrGdw+uW0noOnftkLoFYkBJ4A6X68xr1F7tmuNJenOdU0c
 ba1g==
X-Gm-Message-State: AHQUAubVEre+4FF9yc7sOfg7qiPpUbapiXP2P717GshghzVP4/bl4WfV
 j5RUxKKDHc3lJunfetyZuqiJG6OpskKgA2EE80e5Uw==
X-Google-Smtp-Source: AHgI3IYYQq9FKrCXNUp5a3y1mW0Opvom5VBRxBQe6l6oivu6QLLeBzvfsccSA2SJy6Wfefn/E/Iz17sCC7rzniMWpR4=
X-Received: by 2002:a81:20d4:: with SMTP id
 g203mr28331506ywg.142.1550668585192; 
 Wed, 20 Feb 2019 05:16:25 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
 <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
From: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date: Wed, 20 Feb 2019 22:16:14 +0900
Message-ID: <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_051627_975848_FFCAC7FB 
X-CRM114-Status: GOOD (  21.24  )
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

SGkgQXJuZCwKMjAxOeW5tDLmnIgyMOaXpSjmsLQpIDIxOjI4IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ogo+Cj4gT24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMTI6MjcgUE0gU3VnYXlhLCBU
YWljaGkKPiA8c3VnYXlhLnRhaWNoaUBzb2Npb25leHQuY29tPiB3cm90ZToKPiA+Cj4gPiBIaQo+
ID4KPiA+IE9uIDIwMTkvMDIvMjAgMTg6MjgsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gPiA+IE9u
IFdlZCwgRmViIDIwLCAyMDE5IGF0IDg6NDQgQU0gU3VnYXlhIFRhaWNoaQo+ID4gPiA8c3VnYXlh
LnRhaWNoaUBzb2Npb25leHQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9jb25maWdzL21pbGJlYXV0X20xMHZfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmln
cy9taWxiZWF1dF9tMTB2X2RlZmNvbmZpZwo+ID4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+
ID4+IGluZGV4IDAwMDAwMDAuLmEyNjMyMTEKPiA+ID4+IC0tLSAvZGV2L251bGwKPiA+ID4+ICsr
KyBiL2FyY2gvYXJtL2NvbmZpZ3MvbWlsYmVhdXRfbTEwdl9kZWZjb25maWcKPiA+ID4+IEBAIC0w
LDAgKzEsMTc1IEBACj4gPiA+Cj4gPiA+IEkgbm8gbG9uZ2VyIHNlZSBhbnl0aGluZyBoZXJlIHRo
YXQgc2hvdWxkIGJlIHR1cm5lZCBvZmYsIGJ1dCB5b3UKPiA+ID4gbWlnaHQgd2FudCB0byBydW4g
J21ha2Ugc2F2ZWRlZmNvbmZpZycgYW5kIHVzZSB0aGUgb3V0cHV0IG9mIHRoYXQsCj4gPiA+IHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGtlZXAgaXQgdXAgdG8gZGF0ZS4KPiA+ID4KPiA+Cj4gPiBJIGdv
dCBpdCwgSSB1c2UgdGhlIG91dHB1dCBvZiAnbWFrZSBzYXZlZGVmY29uZmlnJy4KPiA+IE9uZSBx
dWVzdGlvbiwgaXMgdGhhdCBPSyB0byBhZGQgc29tZSBvcHRpb25zIG9uIGl0Pwo+ID4gICAtQmVj
YXVzZSAiQ09ORklHX0FSQ0hfTUlMQkVBVVQiIHdhcyBub3QgbGlzdGVkLgo+Cj4gV2hhdCBJJ2Qg
ZG8gaGVyZSBpcyB0byBhcHBseSBhbGwgdGhlIHBhdGNoZXMgeW91IHdhbnQgdG8gZ2V0IG1lcmdl
ZCBpbgo+IHRoZSBuZXh0IGZldyByZWxlYXNlcyBiZWZvcmUgcnVubmluZyAnc2F2ZWRlZmNvbmZp
ZycgYW5kIHVzZSB0aGUgb3V0cHV0Cj4gb2YgdGhhdC4KCkxldCBtZSBjaGVjay4gV291bGQgeW91
IG1lYW4gdGhhdCB0aGUgZGVmY29uZmlnIHdpbGwgaW5jbHVkZSBhbGwgdGhvc2UKZHJpdmVycyBj
b25maWdzLCB3aGljaCB3aWxsIG5vdCBhcHBlYXIgYXQgdGhpcyBtb21lbnQ/Cgo+IElmIHlvdSBh
bHJlYWR5IGtub3cgdGhhdCB5b3Ugd2lsbCBuZWVkIHRoZSBvcHRpb25zLCBpbmNsdWRpbmcKPiB0
aGVtIG5vdyBtZWFucyB5b3UgZG9uJ3QgaGF2ZSB0byB1cGRhdGUgdGhlIGRlZmNvbmZpZyBmaWxl
Cj4gYXMgbXVjaCBpbiB0aGUgZnV0dXJlLgoKSSBqdXN0IGNvbmNlcm4gdGhhdCBpZiBvdGhlciBz
dWJzeXN0ZW0gbWFpbnRhaW5lciBjb21tZW50cwpvbiB0aGUgY29uZmlnIG5hbWUuIEV2ZW4gaW4g
dGhhdCBjYXNlLCBjYW4gd2UganVzdCB1cGRhdGUgdGhlCmRlZmNvbmZpZyB3aXRoIG5ldyBuYW1l
PwoKVGhhbmsgeW91LAoKLS0gCk1hc2FtaSBIaXJhbWF0c3UKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
