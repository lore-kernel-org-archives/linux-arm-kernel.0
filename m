Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:53:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC66222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFedto1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC66222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hOrilIGT7Pk0D5RxCRj9miSov/B2NbTFaaDNDzBRk+E=; b=hFedto1fFycnFm
	Z14ScdV3gi+xUuehh1PklTekcf9yF//nf1enHmima+FG8ZRxAo69syjF2rMc4v3fad18nG6vnnc8V
	XNzCOUg1ZEwof8pE0lkEaRL5UryB4g2zIqFq5ns+croOvTdPBqbjOyOq6JOuLbImC/sCkTX+aGZg0
	CfNd+rIx0SHKBJuydoANJf5rmsaSYRJvCaCBkM+D+39cYSd2Q0j88in9aB4KdG2pMVoQVI899J5Ig
	U84uMYb26vSo8TcRkaWvb+UnlNfJyd0t6bqJmHP0IivgkXg+Jjpws+LT9y1/4/mMNfggWAy1w1AHP
	6UUOU9ZRCtwqxXzyPMEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujXo-0005p0-Ul; Fri, 15 Feb 2019 19:53:08 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujXl-0005oU-3g; Fri, 15 Feb 2019 19:53:06 +0000
Received: by mail-qt1-f195.google.com with SMTP id d18so2231654qtg.12;
 Fri, 15 Feb 2019 11:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sPGXbhv6UkP2fd8vklPoSv0uq553MV82hTqwB/my814=;
 b=g/+8LTgyZsppYyaJEpUNg3EtFt2JPl3tHg0FGDethMRHY9P2BE7CqMjtSM4WtP91di
 xqiK64hC+beCiSoF0ywve+WTy2NFHJqiAcJwgwt0Kc4/a1iT6rquojV4ZTlyJjtLe/Ji
 ojfKRIzVGTXQrlu3aiNeF2Ne1zv147OXWqHJZnR2V7vKrW9iMGkEJdbv1GQdPyOghX7W
 6Q/nUdKk7Eo0Ok5x9ces7R+NnIbWVtH4jyZYJVFrq56l1yMPGnYkItVjGn4oKqRO8JXl
 hWB/4sd8tbaBKpNBIlCuNxfig5VguiHTdnyTJCOeQolHTcxv5EOSuA18/Pgx3DfkdCA4
 BEYA==
X-Gm-Message-State: AHQUAuYV/TyPHoBax9D4WvmHs6BXdVUAZ60fR5bv27wp6qJ4xOGGrsAG
 jbQgulQPH72VpA0WuCEYYTSe5FgmElYPbXBZQ1c=
X-Google-Smtp-Source: AHgI3IZekrBvfrhIuqEvAfmt/SVwvVoOVvlQSevK0SXVuP/OH4e2OUxWEuBfE3oz3++00sklg8I0qgD/GTXBPPBG590=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr8431303qvi.149.1550260383971; 
 Fri, 15 Feb 2019 11:53:03 -0800 (PST)
MIME-Version: 1.0
References: <2570520.8EeqtpO5V7@phil>
 <CAK8P3a2drxVzNgsKcM2ii62+NsVmsCiOKGirQeby0kOFRQnX_g@mail.gmail.com>
 <CAK8P3a2UkmVOJDddi3rC=GFcBSeqciNuYaT8s3i5E4bOwJE1Bg@mail.gmail.com>
 <3976614.8kaIahWTG7@diego>
In-Reply-To: <3976614.8kaIahWTG7@diego>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 20:52:47 +0100
Message-ID: <CAK8P3a1dg8PcaQXkY9XpqdWgSYYd_e01Cn3HxTjZxroaZir+=Q@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip dts64 updates for 5.1
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_115305_153770_61C3B89F 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgODozMiBQTSBIZWlrbyBTdMO8Ym5lciA8aGVpa29Ac250
ZWNoLmRlPiB3cm90ZToKPgo+IEFtIEZyZWl0YWcsIDE1LiBGZWJydWFyIDIwMTksIDE2OjM4OjQz
IENFVCBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4gPiBPbiBGcmksIEZlYiAxNSwgMjAxOSBhdCAy
OjQ1IFBNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyb3RlOgo+ID4gPiBPbiBGcmks
IEZlYiAxLCAyMDE5IGF0IDEyOjI0IFBNIEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+
IHdyb3RlOgo+ID4gPiA+IE5ldyBib2FyZHMgYXJlIHRoZSBSb2NrIFBpIDQsIE5hbm9QQy1UNCBh
bmQgTmFub1BpLU00LCB3aXRoIHRoZSBsYXN0Cj4gPiA+ID4gdHdvIGJlaW5nIHBhcnQgb2YgYSBm
YW1pbHkgYW5kIHNoYXJpbmcgYmlnZ2VyIHBhcnRzIG9mIHRoZSBkZXZpY2V0cmVlLgo+ID4gPiA+
IHJrMzMyOCBnb3Qgc291bmQtcmVsYXRlZCB1cGdyYWRlcyBhbmQgYSB3aWRlciBwYXRjaCBkcm9w
cyBtbWMgZGlzcGxheS13cAo+ID4gPiA+IGZpZWxkcyBmcm9tIG5vZGVzIHdoaWNoIHNob3VsZG4n
dCB1c2UgaXQuCj4gPiA+Cj4gPiA+IFB1bGxlZCBpbnRvIGFybS9kdCwgbmljZSB0byBzZWUgdGhl
IGFkZGl0aW9uYWwgcmszMzk5IGJvYXJkcy4gVGhhbmtzLAo+ID4KPiA+IEkgc3RpbGwgZ2V0IHNv
bWUgd2FybmluZ3MgZHVyaW5nICdtYWtlIGR0YicsIGFsbCBzcGVjaWZpYyB0byByazMzOTk6Cj4g
Pgo+ID4gLi4vYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktZ3J1LWJvYi5kdHM6
MjUuOS0yOS41OiBXYXJuaW5nCj4gPiAoZ3JhcGhfcG9ydCk6IC9lZHAtcGFuZWwvcG9ydHM6IGdy
YXBoIHBvcnQgbm9kZSBuYW1lIHNob3VsZCBiZSAncG9ydCcKPiA+IC4uL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcm9ja2NoaXAvcmszMzk5LWdydS1rZXZpbi5kdHM6NDYuOS01MC41Ogo+ID4gV2Fybmlu
ZyAoZ3JhcGhfcG9ydCk6IC9lZHAtcGFuZWwvcG9ydHM6IGdyYXBoIHBvcnQgbm9kZSBuYW1lIHNo
b3VsZCBiZQo+ID4gJ3BvcnQnCj4gPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3Jr
MzM5OS1zYXBwaGlyZS1leGNhdmF0b3IuZHRzOjk0LjktOTguNToKPiA+IFdhcm5pbmcgKGdyYXBo
X3BvcnQpOiAvZWRwLXBhbmVsL3BvcnRzOiBncmFwaCBwb3J0IG5vZGUgbmFtZSBzaG91bGQgYmUK
PiA+ICdwb3J0Jwo+ID4KPiA+IENhbiB5b3Ugc2VlIHdoYXQgaXMgZ29pbmcgb24gYW5kIHNlbmQg
YSBmaXg/Cj4KPiBobW0sIHRoYXQgc2hvdWxkIGFjdHVhbGx5IGJlIGZpeGVkIGJ5IHRoZSBmaXhl
cy1wdWxsIHJlcXVlc3RzLCBzZWUKPiAgICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2FybS9hcm0tc29jLmdpdC9jb21taXQvP2g9YXJtL2ZpeGVz
JmlkPTI2Y2Q4NjU3YzdlNzQ1Njg2YTRjNTRhNWNjY2Y3MjFlZGUyMDhhMjUKPiBmb3IgcmVmZXJl
bmNlLCB3aGljaCBzdXBwb3NlZGx5IGZpeGVzIGV4YWN0bHkgdGhlc2UgaXNzdWVzLgoKT2ssIGdv
b2QuIEkgYWxzbyBhc2tlZCB0aGUgc2FtZSB0aGluZyBhYm91dCBvbWFwLCB3aGVyZSBJCm1hZGUg
dGhlIHNhbWUgbWlzdGFrZS4gSSBjb25maXJtZWQgbm93IHRoYXQgbXkgZm9yLW5leHQKYnJhbmNo
ICh3aGljaCBpbmNsdWRlcyB0aGUgZml4ZXMpIGRvZXMgbm90IGhhdmUgdGhpcyBpc3N1ZSwKaHRl
IG9ubHkgd2FybmluZyBJIGdldCB0aGVyZSBpcyBmb3IgbXZlYnUva2lya3dvb2QKCiAgICAgICBB
cm5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
