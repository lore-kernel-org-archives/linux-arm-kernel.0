Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4947420880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mMTpPKny";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VG8D8PJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4947420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H61DYoRXAWILd0148KgZTwqBYGzcNiE1mLHS4anHMqc=; b=mMTpPKnyLqfjXx
	1SjRrw8r+ArHviDZBuqwllwAkWFViMs9G2Eab+Binx1OY5Su/QaoM1TUNbhhlG7zC4KSEVH9FHWrY
	LaKAQUHOFV2PKQRPPDdkaApA/iNspXa5yJommrxfmRXxA4ZEJis+H3c6HobolCJ74MKKMNGXLX5E/
	E3k1gKli//5ApdOIYVQ9ABdvAmRZ1X3LlapsvB7y0QzVJd0Jt14bpOEA1KkgHw6RqJuH3r0PVeu1U
	+jn876xftmspTMUDyOMWcT4mncJ3NbPwlJuvv5hINWfIdBzYBsbcaY55eEsC/NLOWzmTPz5IFtZIO
	9FpQFR5lKtM4TFJADSoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRqK-0003td-JR; Wed, 20 Feb 2019 13:23:20 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRqH-0003si-2g
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:23:18 +0000
Received: by mail-yb1-xb44.google.com with SMTP id a4so182979ybo.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UPBimqpX1XmXfQQA5dxV0A4d1+kbj31tNEUudF2+Ju0=;
 b=VG8D8PJQA2/tlOWaEfqfFoc14YHCnxlRxmd/+RnHm1bxZXGpIVLxc4lcpSeiv68ULv
 gkCHPcKsKNRSNANxL5DfBRj3xmapPeNnwlKIdcbIqyI3pZjD8Pu/RsQRuo/iEq5n6v+l
 NbilojFtwDrTeHoV6OCYFMDPEa7QX9iV29WqDFiCy6rclyFSUJIZ9HDdEOT46L9ylazy
 sj22IVCagIlxaiUszKJg4dkXbNOnmasb2NvQj0EqQ81t35MyjRNqMTFkJwBwQjxz/UTb
 tIOQettP9vvIffs35BygcArfU60cMNqv4mKfxWexqOmZ95f7oBIwXyWTQdu+m9TCwuXk
 JcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UPBimqpX1XmXfQQA5dxV0A4d1+kbj31tNEUudF2+Ju0=;
 b=hMdRw2V1/y1LHKr60YVQP3yvRakUIYfjNSS12T+E/q3WHH1goAb6sPeXuV+bcM8BCa
 EKqP2sgFQUIJFtgPcVugR9rHuZT3EATMMyvYMRdbqdjYaYhhzxCxsraVYne6UQRk5JPF
 tMLC/18z0fM8HwNCZpnToxkVE6LpUTaQvemzCJVwc09vJI04I+DXE3U1IALyVVt5Bx1f
 P+tMS5OdwfXc6NHNxQ950oeqC5pGHsrH5KD3imZx/A/DHkzSsWfGXUfTsmOf/ItaRS3g
 tyiy71RQXV5fmU89mUrBN/yFIJwDg3Pn+hYg2gm55j1rI2ZhWwl7VSm+gqxUJvUNEU8r
 pJrg==
X-Gm-Message-State: AHQUAuaLdg7vz996EGlyig6CDnvbvuH6D8yHuTEGjPIt73V/dt4lnRZV
 /+b1Or7dUoqOhnwn9GXPILIehlk0SlaaISAz72/AVw==
X-Google-Smtp-Source: AHgI3IY231O3KisMBH/4GvvgbcbIbpjDiA8V5kAxX/MkEpzKSdIOBP0FYVhIVd1g44xSVYb9L9+IUtdbREmLu2VT6cM=
X-Received: by 2002:a25:57c4:: with SMTP id
 l187mr13805906ybb.269.1550668995675; 
 Wed, 20 Feb 2019 05:23:15 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
 <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
 <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
In-Reply-To: <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
From: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date: Wed, 20 Feb 2019 22:23:04 +0900
Message-ID: <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_052317_126212_237F3AF6 
X-CRM114-Status: GOOD (  23.72  )
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

SGkgQXJuZCwKCjIwMTnlubQy5pyIMjDml6Uo5rC0KSAyMjoxOCBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPjoKPgo+IE9uIFdlZCwgRmViIDIwLCAyMDE5IGF0IDI6MTYgUE0gTWFzYW1pIEhp
cmFtYXRzdQo+IDxtYXNhbWkuaGlyYW1hdHN1QGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gMjAxOeW5
tDLmnIgyMOaXpSjmsLQpIDIxOjI4IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Ogo+ID4g
PiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCAxMjoyNyBQTSBTdWdheWEsIFRhaWNoaQo+ID4gPiA8
c3VnYXlhLnRhaWNoaUBzb2Npb25leHQuY29tPiB3cm90ZToKPiA+ID4gPiBPbiAyMDE5LzAyLzIw
IDE4OjI4LCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBGZWIgMjAsIDIw
MTkgYXQgODo0NCBBTSBTdWdheWEgVGFpY2hpCj4gPiA+ID4gPiA8c3VnYXlhLnRhaWNoaUBzb2Np
b25leHQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2NvbmZpZ3MvbWlsYmVhdXRfbTEwdl9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL21p
bGJlYXV0X20xMHZfZGVmY29uZmlnCj4gPiA+ID4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+
ID4gPiA+PiBpbmRleCAwMDAwMDAwLi5hMjYzMjExCj4gPiA+ID4gPj4gLS0tIC9kZXYvbnVsbAo+
ID4gPiA+ID4+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvbWlsYmVhdXRfbTEwdl9kZWZjb25maWcK
PiA+ID4gPiA+PiBAQCAtMCwwICsxLDE3NSBAQAo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgbm8gbG9u
Z2VyIHNlZSBhbnl0aGluZyBoZXJlIHRoYXQgc2hvdWxkIGJlIHR1cm5lZCBvZmYsIGJ1dCB5b3UK
PiA+ID4gPiA+IG1pZ2h0IHdhbnQgdG8gcnVuICdtYWtlIHNhdmVkZWZjb25maWcnIGFuZCB1c2Ug
dGhlIG91dHB1dCBvZiB0aGF0LAo+ID4gPiA+ID4gdG8gbWFrZSBpdCBlYXNpZXIgdG8ga2VlcCBp
dCB1cCB0byBkYXRlLgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEkgZ290IGl0LCBJIHVzZSB0
aGUgb3V0cHV0IG9mICdtYWtlIHNhdmVkZWZjb25maWcnLgo+ID4gPiA+IE9uZSBxdWVzdGlvbiwg
aXMgdGhhdCBPSyB0byBhZGQgc29tZSBvcHRpb25zIG9uIGl0Pwo+ID4gPiA+ICAgLUJlY2F1c2Ug
IkNPTkZJR19BUkNIX01JTEJFQVVUIiB3YXMgbm90IGxpc3RlZC4KPiA+ID4KPiA+ID4gV2hhdCBJ
J2QgZG8gaGVyZSBpcyB0byBhcHBseSBhbGwgdGhlIHBhdGNoZXMgeW91IHdhbnQgdG8gZ2V0IG1l
cmdlZCBpbgo+ID4gPiB0aGUgbmV4dCBmZXcgcmVsZWFzZXMgYmVmb3JlIHJ1bm5pbmcgJ3NhdmVk
ZWZjb25maWcnIGFuZCB1c2UgdGhlIG91dHB1dAo+ID4gPiBvZiB0aGF0Lgo+ID4KPiA+IExldCBt
ZSBjaGVjay4gV291bGQgeW91IG1lYW4gdGhhdCB0aGUgZGVmY29uZmlnIHdpbGwgaW5jbHVkZSBh
bGwgdGhvc2UKPiA+IGRyaXZlcnMgY29uZmlncywgd2hpY2ggd2lsbCBub3QgYXBwZWFyIGF0IHRo
aXMgbW9tZW50Pwo+Cj4gQ29ycmVjdC4KPgo+ID4gPiBJZiB5b3UgYWxyZWFkeSBrbm93IHRoYXQg
eW91IHdpbGwgbmVlZCB0aGUgb3B0aW9ucywgaW5jbHVkaW5nCj4gPiA+IHRoZW0gbm93IG1lYW5z
IHlvdSBkb24ndCBoYXZlIHRvIHVwZGF0ZSB0aGUgZGVmY29uZmlnIGZpbGUKPiA+ID4gYXMgbXVj
aCBpbiB0aGUgZnV0dXJlLgo+ID4KPiA+IEkganVzdCBjb25jZXJuIHRoYXQgaWYgb3RoZXIgc3Vi
c3lzdGVtIG1haW50YWluZXIgY29tbWVudHMKPiA+IG9uIHRoZSBjb25maWcgbmFtZS4gRXZlbiBp
biB0aGF0IGNhc2UsIGNhbiB3ZSBqdXN0IHVwZGF0ZSB0aGUKPiA+IGRlZmNvbmZpZyB3aXRoIG5l
dyBuYW1lPwo+Cj4gWWVzLCB0aGF0J3MgZWFzeSBlbm91Z2guCgpPSywgSSBnb3QgaXQgOikKClRo
YW5rIHlvdSEKCj4KPiAgICAgICBBcm5kCgoKCi0tIApNYXNhbWkgSGlyYW1hdHN1CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
