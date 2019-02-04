Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936AD2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1e4R3il";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="L3IU91xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936AD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5v5dpFox3FQfY/tcL8C9aKisanJzNXBgb23tpjlcvkE=; b=X1e4R3ilQDkFJg
	FQoYFg2ngyTJV3XJkweHoGljNBfrEhYnHVT03sbD+PBIq42VQV7jt+Cm0eK/1C9kDf/yQgJcXQmPt
	S85Vk/Kpc2ee1FmeF06OCGJHkhrJHuvIVejleiHpUBgfQ2YOyAOj+HSLcBaPizWKpF/0vy3mdogEr
	bsGsWXeaACMDHx1CF9w3ilcacmtoSEqTIXP4Ks4LrK/kV1WtlvYnphOWXY9U6FblH6PCNuhfMXIMW
	6z7Jdubh7mlja6yLTn4Q6UlERSCEbIe4Kx/aCnHvXdCxXDccZfar+6dl/O7W2vWi6SWw2xNg+2oe7
	ntjP2w/WQdvkQj+LJ1YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqel7-00065I-OY; Mon, 04 Feb 2019 13:58:01 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqel3-00062t-JN
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:57:59 +0000
Received: by mail-qk1-x743.google.com with SMTP id r21so2718648qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Cob65+TSivxdwHGHhKLnR/57hk8K3UX4vIKW6jQvrU=;
 b=L3IU91xeG1Ti1Ny4jdOZC/KvlBo1JrQq8voAkWQfkB7n0zz8RZ7G1K9NDNV+u0hEMa
 0C+H9B/V7GqBUw0XtEGtNlF3aFUxlzw5X6q/tA5mkGFkJa/3nnETtzwds8gRSgxZlqAc
 iLJr7taM9JcMu8JiAtl6lPvmV4NMHdtH4j69EvFqddVp1WvVvi7rUUoPZITEN8vpY7dE
 1+zDRSmFxM6eHMZFQHnktbl5R5olCGTetJVsAXOT4sgTA2i5t0Mr4egTK6VY99+Be9ti
 EEDoNzg6im64cVq0kaasfVSxZHMHYJck/i/4oHIRpHWoVUJ/AKebjkupU+TtyIvYQYso
 1KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Cob65+TSivxdwHGHhKLnR/57hk8K3UX4vIKW6jQvrU=;
 b=kcORLg1rUOPSg1UKFHfV5mOwTeDpCSsfkte0pNXgB2PKduOiDFchiMBL/cScfks8qK
 US/Pg3G6Q/y2eMXQb9Kg7dWZ9Ea2EmZnklzZlcfMEc9OFzH9wD1tIdrPWLRw8lJQa/rk
 WO3l17wBYyPswVXeX0yX7R9xs/Tlvcgfme6gZQcIzKJBIfrdBWjhBHhLPPGS/PqrIC0a
 h09pmhKk2O2SgESyMLPCH3XvOwEvcH6/6YOgV74tO73os723KL5kuwSvKUIVMdjMxpOo
 qrj0bEaLffM5z6gMooIih3laRT+NzlyXfm5br8JuNrQQbtP3ZFGJsjgxgMEnV032jWiH
 4ZAw==
X-Gm-Message-State: AJcUukcIOFDFLJvp4uHpu6pp9QoyaxHrk/2cR/qQMx+ure/JXGdLpqfX
 ajePjjehEuYOCSlVjypvZ3uEgg==
X-Google-Smtp-Source: ALg8bN7kIrZ9c8PrxWBd0faRE7Uct2ZIqkHdB6pqbSMMAcdLHZsGV/S+6UI8bjeCaawLHah1EFWSdg==
X-Received: by 2002:a37:6f85:: with SMTP id
 k127mr45788050qkc.240.1549288675787; 
 Mon, 04 Feb 2019 05:57:55 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id l4sm4062899qtl.14.2019.02.04.05.57.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 05:57:55 -0800 (PST)
Message-ID: <1549288674.6911.27.camel@lca.pw>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
From: Qian Cai <cai@lca.pw>
To: Steve Capper <Steve.Capper@arm.com>
Date: Mon, 04 Feb 2019 08:57:54 -0500
In-Reply-To: <20190204102715.GA11645@capper-debian.cambridge.arm.com>
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
 <20190201134847.GC29903@fuggles.cambridge.arm.com>
 <1549054142.6911.25.camel@lca.pw>
 <20190204102715.GA11645@capper-debian.cambridge.arm.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_055757_698130_043C8A46 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDE5LTAyLTA0IGF0IDEwOjI3ICswMDAwLCBTdGV2ZSBDYXBwZXIgd3JvdGU6Cj4g
T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDM6NDk6MDJQTSAtMDUwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gPiBPbiBGcmksIDIwMTktMDItMDEgYXQgMTM6NDggKzAwMDAsIFdpbGwgRGVhY29uIHdyb3Rl
Ogo+ID4gPiBIaSBRaWFuIENhaSwKPiAKPiBbLi4uXQo+IAo+ID4gVW5mb3J0dW5hdGVseSwgYWx0
aG91Z2ggdGhpcyB0YWtlcyBjYXJlIG9mIGtlcm5lbF9wYWdlX3RhYmxlcywgaXQgYnJlYWtzCj4g
PiBlZmlfcGFnZV90YWJsZXMuCj4gPiAKPiA+ICMgY2F0IC9zeXMva2VybmVsL2RlYnVnL2VmaV9w
YWdlX3RhYmxlcwo+ID4gQlVHKCkKPiA+IAo+ID4gIyAuL3NjcmlwdHMvZmFkZHIybGluZSB2bWxp
bnV4IHdhbGtfcGdkKzB4ODQvMHgyNTQKPiA+IHdhbGtfcGdkKzB4ODQvMHgyNTQ6Cj4gPiBfX3Jl
YWRfb25jZV9zaXplIGF0IGluY2x1ZGUvbGludXgvY29tcGlsZXIuaDoxOTMgKGRpc2NyaW1pbmF0
b3IgMSkKPiA+IChpbmxpbmVkIGJ5KSB3YWxrX3BnZCBhdCBhcmNoL2FybTY0L21tL2R1bXAuYzoz
NDUgKGRpc2NyaW1pbmF0b3IgMSkKPiA+IAo+ID4gMzQ0OsKgwqDCoMKgwqDCoMKgwqBkbyB7Cj4g
PiAzNDU6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2RfdCBwZ2QgPSBSRUFEX09O
Q0UoKnBnZHApOwo+ID4gMzQ2OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV4dCA9
IHBnZF9hZGRyX2VuZChhZGRyLCAwKTsKPiA+IAo+ID4ga2VybmVsIEJVRyBhdCBhcmNoL2FybTY0
L21tL2R1bXAuYzozMzIhCj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fSBlbHNlIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoEJVR19PTihwdWRfYmFkKHB1ZCkpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgd2Fsa19wbWQoc3QsIHB1ZHAsIGFkZHIsIG5leHQpOwo+ID4g
Cj4gCj4gSGkgUWlhbiBDYWksCj4gQXBvbG9naWVzIGZvciBtaXNzaW5nIHRoZSBlZmlfcGFnZV90
YWJsZXMuCj4gCj4gRG9lcyB0aGUgZm9sbG93aW5nIChhcHBsaWVkIHRvIFdpbGwncyBmaXgpIGhl
bHA/Cj4gCgpZZXMsIGl0IHdvcmtzIGdyZWF0IQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
