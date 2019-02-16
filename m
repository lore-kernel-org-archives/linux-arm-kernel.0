Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:00:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB22222DF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SsYubaUx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft3/m8CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB22222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CMN4LN8OIP49L/HOWkZGly5nrbEgyiD3QVU5OAnbeZs=; b=SsYubaUx7aXPHY
	jZ4TOAnbrikXIXI3zaN3e5L+2/pwhSmHyOHBEE/pZSg/mBZYEH2G4f3POG+iipDjUiwPNbhIvmizB
	gvlgW86+tOrdOT+2+7GhTn9ORLYHmww/RVA2WnXWJbftURKqvdRxjzstEkawRJoivvz5bQ/kruPkK
	8vQE/CEUNFweiFgiUBKBoew5Ny1qOsYBYhEz/9MuqlbNgh30LtKxUB/IUbIiKPxTSOuGk+tBcP9fu
	cL8cridNdlu7OjzKffRNJqEJPVNQUYafgDDkdW/uwg8dGAJFGO9EFg69KGoXWcSFU5hjYuOVMljgT
	H0BXBDzAKtYB0Wmfldvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guoLb-00077D-K7; Sat, 16 Feb 2019 01:00:51 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guoLY-00076s-1p
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 01:00:49 +0000
Received: by mail-lf1-x144.google.com with SMTP id m11so8479691lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 17:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=odCmyZK/pe4i7m+eoyIk/Udls2FduYlQFi7ob0MnlPQ=;
 b=Ft3/m8CNPUiUNYKemqxtbdesRzGm5rdvD8SlZKnMpwtR3bYswPOl/ur4k7hGMV+FTX
 SFIw8+GfJPNVaqCZLZGtrSiAYlT9XH+ceheL1pzcvTy7k7wFSD8WiPmVNxZmcrlGUGzU
 Hr2kGOzZqqZnIeVlbYjXwFkPKue7d6Obd1BKq7dalcGuf7iJY4QZjqxfN9+D7/Q1qpxe
 aaQ8ybAQnSUxAef9jv1YF74qCmKgLHOMoxA4b91D7+ygxQCdxXkgZ/NUgXAJTwnY6cf1
 QAMjnICBvpruwCIXaD4SUQLllcLiGRMsKeyxgL9bePpBHUQu5Dk5a4SuBrVbWgJmMdQp
 CByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=odCmyZK/pe4i7m+eoyIk/Udls2FduYlQFi7ob0MnlPQ=;
 b=knVewre6AaAlZpI1T67AOEiZk5TYszUQWh9QTY7H1Ap18eeKxbpHo/7lf8rp0xxLI6
 fxLKrss3kISUCYuTPKDJ3iGc4E4Kf1nh7NZ36se1HLw9qV+j23W3bFCAdyc+6CNyAkUs
 DJGJ1/ltNYmGevPS4C8vnOk9BV0rsbSiuq1EflxpNnHTc8Va7f1NPo7s9bSTLtppVTjL
 KWik5r55B8txCnK3+2qQ3QfxLK7/K0GMmv1r6LrMKXG4osDOkULYciw80wlAD8IIv7LC
 8PPiVNuoiFFiMeua5d13gMJjG64UDoTiKfMkDN9lTdz2+OGzZJtiv7pQBsK1xc2t2nrO
 FjcA==
X-Gm-Message-State: AHQUAuagmTbVqDz4ScBAcAiygDxLnBLDUF+FJjf0tcjJ9FY9JYAgqQQ5
 aSTkAvWcHhMcrvBfE6Wk+OoxxgcG
X-Google-Smtp-Source: AHgI3IaZjUfVDkzsiahT0ATe2pOjXaNA2Zgg6Ej9hF2Lzq+N4mRbodt2Mpp5FDPKTovWf0oVtxU/UQ==
X-Received: by 2002:a19:c48e:: with SMTP id u136mr6727519lff.167.1550278845585; 
 Fri, 15 Feb 2019 17:00:45 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id r12sm723157ljc.97.2019.02.15.17.00.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 17:00:44 -0800 (PST)
Subject: Re: [GIT PULL 6/9] ARM: tegra: Core changes for v5.1-rc1
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-7-thierry.reding@gmail.com>
 <CAK8P3a2vDG97hP80i6rknqFnDdpoCGMBpmoy2Gp-jUWnGJ5VCg@mail.gmail.com>
 <20190215214826.GB12838@ulmo>
 <afa0e109-b24e-7b00-88c1-b3c30e1755fc@gmail.com>
Message-ID: <0784c2b1-f30f-0c00-bdac-ab52dbde1d0a@gmail.com>
Date: Sat, 16 Feb 2019 04:00:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <afa0e109-b24e-7b00-88c1-b3c30e1755fc@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_170048_119739_3AFB36DE 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MTYuMDIuMjAxOSAzOjAzLCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoKPiAxNi4wMi4yMDE5
IDA6NDgsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+IE9uIEZyaSwgRmViIDE1LCAyMDE5
IGF0IDA1OjQ4OjI1UE0gKzAxMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+PiBPbiBGcmksIEZl
YiA4LCAyMDE5IGF0IDQ6MDkgUE0gVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWls
LmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBIaSBBUk0gU29DIG1haW50YWluZXJzLAo+Pj4+Cj4+Pj4g
VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZmVmZmQxNTUyODM3NzJiYmU3OGM2
YTA1ZGVjN2MwMTI4ZWU1MDBjOgo+Pj4+Cj4+Pj4gICBMaW51eCA1LjAtcmMxICgyMDE5LTAxLTA2
IDE3OjA4OjIwIC0wODAwKQo+Pj4+Cj4+Pj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6Cj4+Pj4KPj4+PiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90ZWdyYS9saW51eC5naXQgdGFncy90ZWdyYS1mb3ItNS4xLWFybS1jb3JlCj4+
Pj4KPj4+PiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMWM2Mjc5YjQ5ZDNmZmZmMzgz
NTdlOTNkMTEyNTEyZmVjZjM3MTFhNzoKPj4+Pgo+Pj4+ICAgQVJNOiB0ZWdyYTogUmVzdG9yZSBt
ZW1vcnkgYXJiaXRyYXRpb24gb24gcmVzdW1lIGZyb20gTFAxIG9uIFRlZ3JhMzArICgyMDE5LTAx
LTE2IDEzOjIyOjA0ICswMTAwKQo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IFRoaWVycnkKPj4+Pgo+
Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPj4+PiBBUk06IHRlZ3JhOiBDb3JlIGNoYW5nZXMgZm9yIHY1LjEtcmMxCj4+
Pj4KPj4+PiBUaGlzIGNvbnRhaW5zIHRocmVlIGZpeGVzIGZvciByZXN1bWUgZnJvbSBMUDEgb24g
VGVncmEzMC4KPj4+Pgo+Pj4KPj4+IFB1bGxlZCBpbnRvIGFybS9zb2M/Cj4+Pgo+Pj4gU2hvdWxk
IHRoZXNlIGJ1Z2ZpeGVzIGhhdmUgYmVlbiBtYXJrZWQgQ2M6c3RhYmxlPwo+Pgo+PiBJIGRvbid0
IHRoaW5rIHRoYXQnZCBiZSB3b3J0aCBpdC4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlc2UgaGF2
ZSBiZWVuCj4+IGJyb2tlbiBzaW5jZSBmb3JldmVyLiBCYWNrcG9ydGluZyB0aGlzIHdvdWxkIGJl
IGZhaXJseSBpbnZvbHZlZCBhbmQgSSdtCj4+IG5vdCBzdXJlIGlmIHRoaXMgaHVydHMgZW5vdWdo
IHRvIHdhcnJhbnQgdGhlIGFkZGl0aW9uYWwgd29yaywgZ2l2ZW4gdGhhdAo+PiBpdCdzIG5vdCBi
ZWVuIHJlcG9ydGVkIGluIGFsbCB0aGlzIHRpbWUuCj4+Cj4+IERtaXRyeSwgY2FuIHlvdSBjbGFy
aWZ5IHdoZXRoZXIgeW91IHdhbnQgdGhlc2UgdG8gYmUgYmFja3BvcnRlZD8KPiAKPiBUZWNobmlj
YWxseSBpdCBmaXhlcyBhIHJlYWwgcHJvYmxlbSwgYnV0IHJlYWxpc3RpY2FsbHkgdGhlcmUgaXMg
bm8gcmVhbCBuZWVkIHRvIGJhY2twb3J0IHRoZXNlIHBhdGNoZXMgYmVjYXVzZSBvZiBvdGhlciBz
dXNwZW5kLXJlc3VtZSB0cm91YmxlcyB0aGF0IGFsc28gZXhpc3RlZCBhbGwgdGhlIHRpbWUgYW5k
IGhhdmVuJ3QgYmVlbiByZXNvbHZlZCB5ZXQgKGxpa2VseSBmaXhlcyB3b24ndCBiZSBiYWNrcG9y
dGFibGUpLiBJbiBnZW5lcmFsIHN1c3BlbmQtcmVzdW1lIGtpbmRhIHdvcmtzIGFuZCBmYWlscyBt
b3N0bHkgdW5kZXIgc29tZSBsb2FkIChsaWtlIHN0cmVzcyB0ZXN0aW5nKSwgYXQgbGVhc3QgdGhh
dCdzIHRoZSBjYXNlIGZvciBUMzAuCgpBY3R1YWxseSBubywgSSBsb29rZWQgdXAgdGhlIG90aGVy
IFQzMCBmaXhlcyBhbmQgdGhleSBhcmUgcHJldHR5IHRyaXZpYWwuIE1vcmVvdmVyIHR1cm5lZCBv
dXQgdGhhdCBJIGFscmVhZHkgc2VudCB0aGVtIG91dCBiZWZvcmUgWzBdIGFuZCBmb3Jnb3QgYWJv
dXQgdGhlbS4uIHByb2JhYmx5IGl0J3MgYSBiaXQgdG9vIGxhdGUgZm9yIHY1LjEgbm93LgoKU3Rp
bGwgaXQncyBub3QgcmVhbGx5IHdvcnRoIHRvIGJhY2twb3J0IHRoZSBwYXRjaGVzIGdpdmVuIHRo
YXQgdmFuaWxsYSB1cHN0cmVhbSBrZXJuZWwgY2FuIGJvb3Qgb25seSBvbiBkZXYgYm9hcmRzIGlu
IGEgY2FzZSBvZiBUZWdyYTMwIGJlY2F1c2UgdGhlcmUgaXMgbm8gc3VwcG9ydCBmb3IgdGhlIFRy
dXN0ZWQgRm91bmRhdGlvbnMgVDMwIGZpcm13YXJlIHlldC4gSG9wZWZ1bGx5IHdlIHdpbGwgbWFu
YWdlIHRvIGdldCBhbGwgdGhlIGZpeGVzIGFuZCB0aGUgZmlybXdhcmUgc3VwcG9ydCByZWFkeSBm
b3IgdjUuMiBhbmQgdGhlbiBldmVyeXRoaW5nIHdpbGwgYmUgaW4gcGxhY2UuCgpbMF0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3Byb2plY3QvbGttbC9saXN0Lz9zZXJpZXM9MzY0
NDQ4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
