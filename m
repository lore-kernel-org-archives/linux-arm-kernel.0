Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5DC2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZGC7Zm9t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYP2nwGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5DC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X93Kpu0p+6N4Sb+fOLCEfZrm/ZtYMamC/02RLFez5/w=; b=ZGC7Zm9tSlzlqM
	DLlFoLPFUdC9Jod+CbO02kHnOyjSMJM1+eniMuJcQSYHBZMImo/SpcVP0+g3XGin0NoEs1RiWAOH+
	DZQhc0dTDubnindMFKOYEEzDO2nOmHQI6lFo+2fRHvD+gLlomsufP3KqD1WU/iSPKtRHFqRfi0KB5
	s3Q1YroRSOibg/r1Zj+A88YpkwGAse+GyZgcXXBaiXPWO/n1osarh20xR5I/v44+Cm44d9ziCJA3d
	s/b+4Q44g1TiVrvfqJ8jVMGj0b1s8LrrTFmBAajZoVOXwOwT6ODIzdImaSfbZLcNYBkwUd29bIzxE
	iC74NXOr1vNly4tdoyEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gww8U-0008UF-Dy; Thu, 21 Feb 2019 21:44:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gww8R-0008Tv-Nv
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:44:05 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D1792080F;
 Thu, 21 Feb 2019 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785443;
 bh=9zxz3UN/CEWlIByBWZuZX/fn6rZgTADee+6kemEtPg0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=bYP2nwGAkhPJape5j1b4UOEQuR7Y5m8jIe5SWEkMM+vNBbLNtlcfgCizrQ/DgX2Pc
 P3Mz4ByNhkl+dPfn4oOfrX2IdaoaPnGP/Qh4Xdei0O7X+ra/leNDAWwNeRFBOG+Jsc
 Kk32fSAhle4Vu+35i+C3uJvzMCJDmEbLYmg9qiHM=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155078544270.77512.5446420781034016673@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211181531.GA3238@embeddedor>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190211181531.GA3238@embeddedor>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>
Date: Thu, 21 Feb 2019 13:44:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_134403_793609_64AD0566 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBHdXN0YXZvIEEuIFIuIFNpbHZhICgyMDE5LTAyLTExIDEwOjE1OjMxKQo+IEluIHBy
ZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNo
Cj4gY2FzZXMgd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guCj4gCj4gVGhp
cyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+IAo+IGRyaXZlcnMvY2xrL3Nh
bXN1bmcvY2xrLXMzYzI0NDMuYzogSW4gZnVuY3Rpb24g4oCYczNjMjQ0M19jb21tb25fY2xrX2lu
aXTigJk6Cj4gZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jOjM5MDozOiB3YXJuaW5n
OiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdo
PV0KPiAgICBzYW1zdW5nX2Nsa19yZWdpc3Rlcl9hbGlhcyhjdHgsIHMzYzI0NTBfYWxpYXNlcywK
PiAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiAg
ICAgIEFSUkFZX1NJWkUoczNjMjQ1MF9hbGlhc2VzKSk7Cj4gICAgICB+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Cj4gZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jOjM5MzoyOiBu
b3RlOiBoZXJlCj4gICBjYXNlIFMzQzI0MTY6Cj4gICBefn5+Cj4gCj4gV2FybmluZyBsZXZlbCAz
IHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMKPiAKPiBOb3RpY2UgdGhhdCwgaW4g
dGhpcyBwYXJ0aWN1bGFyIGNhc2UsICB0aGUgY29kZSBjb21tZW50IGlzIG1vZGlmaWVkCj4gaW4g
YWNjb3JkYW5jZSB3aXRoIHdoYXQgR0NDIGlzIGV4cGVjdGluZyB0byBmaW5kLgo+IAo+IFRoaXMg
cGF0Y2ggaXMgcGFydCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJsZQo+IC1XaW1wbGlj
aXQtZmFsbHRocm91Z2guCj4gCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8
Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4KPiAtLS0KCkFwcGxpZWQgdG8gY2xrLW5leHQKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
