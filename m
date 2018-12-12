Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AED52084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1hqsk6P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fNUFlOqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AED52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rdXMzI1Wqo9kpxzlNsLYlfKiPmhMGTAj+3SoXLUJXVk=; b=A1hqsk6PRacPe8
	uGPWaeWPKZv9tX0j9JJvHs+zdNiEOxrTYoxIk6ChzueNSdJJceXvYh93YY7yRTlU15ScbotWVPt2z
	ZBX4i0Lj9saPKfOheL+mtoOk9+0TsN+paZWbakKK86OJMXfLTNO9OU/o+BLDSJnrtt3vEmUGGXdeB
	xu9M5gZiG97KZ9qlfXB6Y1ODqGIKNn45Uph7CHX0awJZ0TUYLqSDYqECZ8tpP64N5Cg595RCy9PQ+
	KqC0LXtbuR82h36NUv425mj8o/4TbupTl5CTE+vVEOxhrCMemBUukcs3SMaxGvmXlXfLi277tePKZ
	ienvTYp5IFiIO/JCEwug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD86-0005ls-Sw; Wed, 12 Dec 2018 22:37:22 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXD82-0005ky-JK
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:37:21 +0000
Received: by mail-qt1-x832.google.com with SMTP id n32so33375qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nBMn1PX+IxI9qftbhak8gqTvd8trAPIJ0tYbXZTOpCM=;
 b=fNUFlOqyeM+TZ/Q3Sb8g8VPZJ+xpgQ0WTCGfLPCCs2+MQAqoNZR/vddcinFtU1qKpq
 papgjbiSeViIezpqCD7ks6nKBlA1IIghlXZvTtdVQZhUw1wO6IVHTYY+X530pO2pCnpA
 ysxrm61ytxeHm1fdh57ZJEcJuzIBB+O4sKm3nl/EXMkgwfGJG4TphRUKUzvl/VUPuZpF
 rk2KJh2o9o0FFUtS0Puvrp89DXGALbl3fW7XKB0LcACsoqO9iny9fW1W9lCM19UeCN+k
 5BqB/82e0lFXRU9GiknqfsA21yF1+bCqfgErEYN1Nta+mbphecAJxIlGU46C8uHnory8
 B8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nBMn1PX+IxI9qftbhak8gqTvd8trAPIJ0tYbXZTOpCM=;
 b=p+8do9bWvyZyIvLic0TvZVSdTtOTw4p693vFNdx/QfTWHzDI+kq5UI36aofrOj8U5d
 BP+mmhWmyC1hWvdY80CsdDTV0OSkoqXSwxaBGq11uceicCPvR1QKVLfV/7a3oDGOgq/0
 kF0is1M8k4b0LIFC9YdkdlzGHVritcwOYjR+rRc2+QMy0H7w5VPYsCECZWt+0XPKD+BN
 yya4nZ7E2Rcfp3+Qw8DH/6CM+p+G3D2B5bWmC9y8Zf10Wtc/t1yeatQtgulhMzQa4dlC
 Idl4Mj/haj05dkjYuK2uL6WBYWjXIgYcjjhUJJGB8QkzfSkhHOmR7uiqqJx1AbSiAx54
 2gdg==
X-Gm-Message-State: AA+aEWaZeLNXuOIrteun+3bGfiMEHGkIi/+MFFAQdk3DB0fuBe66zWqz
 Ly0dpA1V2aWzkXgXPTv69FGbUA==
X-Google-Smtp-Source: AFSGD/Ua5nkuVvSABdP0CeGgizofbYMJhkxBXIyz+dsCtZtuGEV0yins+jFvs17J9ISRai9/7lhMow==
X-Received: by 2002:a0c:8264:: with SMTP id h91mr21218167qva.116.1544654226589; 
 Wed, 12 Dec 2018 14:37:06 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id n72sm59884qki.26.2018.12.12.14.37.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 14:37:05 -0800 (PST)
Message-ID: <1544654224.18411.11.camel@lca.pw>
Subject: Re: arm64: kdump broken on a large CPU system
From: Qian Cai <cai@lca.pw>
To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, James Morse
 <james.morse@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 12 Dec 2018 17:37:04 -0500
In-Reply-To: <e4a3456b-6a75-4564-a49f-0532d0b35726@lca.pw>
References: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
 <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
 <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
 <20181212025131.GL21466@linaro.org>
 <e4a3456b-6a75-4564-a49f-0532d0b35726@lca.pw>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_143718_673445_4FCF75E5 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE4LTEyLTExIGF0IDIzOjM5IC0wNTAwLCBRaWFuIENhaSB3cm90ZToKPiBbKyBr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnXQo+IAo+IFRoZSBkZWJ1Z2dpbmcgcHJvZ3Jlc3Mgc28g
ZmFyLi4uCj4gCj4gV2FpdCB1cCB0byA1IG1pbnV0ZXMgZm9yIG90aGVyIENQVXMgdG8gc3RvcCBp
biBjcmFzaF9zbXBfc2VuZF9zdG9wKCkgbWFkZSBubwo+IGRpZmZlcmVuY2UuCj4gCj4gV2l0aCAi
ZGV2IiBicmFuY2ggb2YgdGhpcyB0cmVlIFsxXSwgaXQgaXMgcG9zc2libGUgdG8gcHJpbnQgb3V0
IG1lc3NhZ2VzIGZyb20KPiBwdXJnYXRvcnkgd2hlbiBwYXNzaW5nIHNvbWV0aGluZyBsaWtlICIt
LXBvcnQ9MHg2MDJCMDAwMAo+IC0tcG9ydC1sc3I9MHg2MDJCMDAwMCwweDgwIiB0byBrZXhlYy4g
SG93ZXZlciwgZXZlbiBlbmFibGVfZGNhY2hlKCkgaW4KPiBzZXR1cF9hcmNoKCkgd2lsbCBodW5n
IGxpa2UgZm9yZXZlciBvbiB0aGlzIG1hY2hpbmUgKHdvcmtpbmcgZmluZSBvbiBhbm90aGVyCj4g
YXJtNjQgc2VydmVyIC0gQ29ydGV4LUE3MikuIEFmdGVyIHJlbW92ZWQgb25seSBlbmFibGVfZGNh
Y2hlKCkgLwo+IGRpc2FibGVfZGNhY2hlKCkgZnJvbSBzZXR1cF9hcmNoKCkgZXRjIHdpdGhvdXQg
cmVtb3ZpbmcgcHJpbnRmKCkgbGluZXMsIGl0IGRpZAo+IHByaW50IG91dCwKPiAKPiBJJ20gaW4g
cHVyZ2F0b3J5Cj4gcHVyZ2F0b3J5OiBlbnRyeT0wMDAwMDAwMDkwMDgwMDAwCj4gcHVyZ2F0b3J5
OiBkdGI9MDAwMDAwMDA5MmQ1MDAwMAo+IHB1cmdhdG9yeTogRC1jYWNoZSBFbmFibGVkIGJlZm9y
ZSBTSEEgdmVyaWZpY2F0aW9uCj4gcHVyZ2F0b3J5OiBELWNhY2hlIERpc2FibGVkIGFmdGVyIFNI
QSB2ZXJpZmljYXRpb24KPiAKPiBTbywgaXQgY29uZmlybWVkIHRoYXQgaXQgbXVzdCBodW5nIHNv
bWV3aGVyZSBpbiBhcm02NC9rZXJuZWwvaGVhZC5TICguc3RleHQpCj4gb3IKPiB0aGUgZWFybHkg
cGFydCBvZiBzdGFydF9rZXJuZWwoKSBiZWZvcmUgZWFybHljb24gd2FzIGluaXRpYWxpemVkLgo+
IAo+IEFsc28gY29uZmlybWVkIHRoYXQgcGFzc2luZyBucl9jcHVzPTY0IGluIHRoZSBmaXJzdCBr
ZXJuZWwgd291bGQgYWdhaW4gbWFrZQo+IGV2ZXJ5dGhpbmcgd29yayBmaW5lIHdpdGggdGhpcyBu
ZXcga2V4ZWMuCj4gCj4gU2luY2UgZW5hYmxlX2RjYWNoZSgpIHdvdWxkIGh1bmcgYXMgd2VsbCwg
SSBzdXNwZWN0IHRoaXMgaGFzIHNvbWV0aGluZyB0byBkbwo+IHdpdGggZW5hYmxpbmcgTU1VIChp
LmUsIC5zdGV4dCAtPiBfX3ByaW1hcnlfc3dpdGNoIC0+IF9fZW5hYmxlX21tdSkgY291cGxpbmcK
PiB3aXRoIHNvbWUgc29ydCBvZiBwZXItQ1BVIGRhdGEgd2hlcmUgdGhlIG51bWJlciBvZiBDUFVz
IG1hdHRlcnMuCgpTdGlsbCBkZWJ1Z2dpbmcgYSBodW5nIHRvIGVuYWJsZSBNTVUgKGVuYWJsZV9k
Y2FjaGUpIGluIHB1cmdhdG9yeSBbMV0gd2hpY2ggbWF5CnByb3ZpZGUgc29tZSBjbHVlcyBmb3Ig
dGhlIGh1bmcgbGF0ZXIgaW4gdGhlIDJuZCBrZXJuZWwuCgpkc2IJbnNoc3QKdGxiaQlhbGxlMgpk
c2IJbnNoCmlzYgpibAlnZXRfaXBzX2JpdHMKbHNsCXgxLCB4MCwgI1RDUl9JUFNfRUwyX1NISUZU
Cm9ycgl4MSwgeDEsIHg3Cm1vdgl4MCwgeDYKbGRyCXgyLCA9TUVNT1JZX0FUVFJJQlVURVMKbXNy
CW1haXJfZWwyLCB4Mgptc3IJdGNyX2VsMiwgeDEKbXNyCXR0YnIwX2VsMiwgeDAKaXNiCm1ycwl4
MCwgc2N0bHJfZWwyCmxkcgl4MywgPVNDVExSX0VMeF9GTEFHUwpvcnIJeDAsIHgwLCB4Mwptc3IJ
c2N0bHJfZWwyLCB4MCAgICAgPC0tLSBodW5nIHJpZ2h0IG9uIHRoaXMgaW5zdHJ1Y3Rpb24uCgpX
aXRob3V0IENPTkZJR19BUk02NF9WSEXCoChpLmUuLCBydW5uaW5nIGluIEVMMSksIGl0IGlzIGFi
bGUgdG8gcnVuCmVuYWJsZV9kY2FjaGUoKSBidXQgaXQgc3RpbGwgaHVuZyBsYXRlciBpbiB0aGUg
Mm5kIGtlcm5lbCBzb21ld2hlcmUuCgpkc2IJbnNoc3QKdGxiaQl2bWFsbGUxCmRzYgluc2gKaXNi
CmJsCWdldF9pcHNfYml0cwpsc2wJeDEsIHgwLCAjVENSX0lQU19FTDFfU0hJRlQKb3JyCXgxLCB4
MSwgeDcKbW92CXgwLCB4NgpsZHIJeDIsID1NRU1PUllfQVRUUklCVVRFUwptc3IJbWFpcl9lbDEs
IHgyCm1zcgl0Y3JfZWwxLCB4MQptc3IJdHRicjBfZWwxLCB4MAppc2IKbXJzCXgwLCBzY3Rscl9l
bDEKbGRyCXgzLCA9U0NUTFJfRUx4X0ZMQUdTCm9ycgl4MCwgeDAsIHgzCm1zcglzY3Rscl9lbDEs
IHgwCmlzYgoKT25lIGRhdGEgcG9pbnQgb2YgdGhpcyBzeXN0ZW0gaXMgdGhhdCBpdCBoYXMgNCB0
aHJlYWRzIG9uIGVhY2ggY29yZS4gRWFjaCAyLWNvcmUgCnNoYXJlIGEgc2FtZSBMMSBhbmQgTDIg
Y2FjaGVzLCBzbyB0aGF0IGlzIDggQ1BVcyBzaGFyZXMgdGhlbSBlYWNoLiBBbGwgQ1BVcwpzaGFy
ZSBhIHNhbWUgTDMgY2FjaGUuCgpIZW5jZSwgSSB3b25kZXIgaWYgdGhpcyBpcyBiZWNhdXNlIG9m
IGluY29tcGxldGUgY2FjaGUvVExCIGludmFsaWRhdGlvbiB0aGF0IGhhZApzdGFsZSBlbnRyaWVz
IChvciB1bmluaXRpYWxpc2VkIGp1bmsgd2hpY2gganVzdCBoYXBwZW5zIHRvIGxvb2sgdmFsaWQp
IHByZXNlbnQKYmVmb3JlIHR1cm5pbmcgdGhlIE1NVSBvbi4KClsxXSBodHRwczovL2dpdGh1Yi5j
b20vcHJhdHl1c2hhbmFuZC9rZXhlYy10b29scy9ibG9iL2RldmVsL3B1cmdhdG9yeS9hcmNoL1wK
YXJtNjQvY2FjaGUuUwoKPiAKPiBSaWdodCBub3csIEkgdGhpbmsgSSBuZWVkIHRvIGZpbmQgYSB3
YXkgdG8gcHJpbnQgZGlyZWN0bHkgdG8gcGwwMTEgc2VyaWFsCj4gY29uc29sZSB3aGlsZSBkZWJ1
Z2dpbmcgdGhvc2UgYXNzZW1ibHkgY29kZSBsaWtlIENPTkZJR19ERUJVR19MTCBmb3IgYXJtNjQs
IHNvCj4gaXQgY2FuIGJlIHVzZWQgdG8gbG9jYXRlIHdoZXJlIGV4YWN0bHkgaXQgaHVuZy4gT3Ro
ZXJ3aXNlLCBJIGFtIHNob290aW5nIGluCj4gdGhlCj4gZGFyay4KPiAKPiBbMV0gaHR0cHM6Ly9n
aXRodWIuY29tL3ByYXR5dXNoYW5hbmQva2V4ZWMtdG9vbHMKPiAKPiA9PT0gb3JpZ2luYWwgZW1h
aWwgPT09Cj4gCj4gT24gdGhpcyBIUEUgQXBvbGxvIDcwIGFybTY0IHNlcnZlciB3aXRoIDI1NiBD
UFVzLCB0cmlnZ2VyaW5nIGEgY3Jhc2ggZHVtcCBqdXN0Cj4gaHVuZyAoNC4yMC1yYzYgYXMgd2Vs
bCBhcyA0LjE4KS4gSXQgd2FzIGNvbmZpcm1lZCB0aGF0IHRoZSBleGVjdXRpbmcgd2VudCBhcwo+
IGZhcgo+IGFzIGVudGVyaW5nIF9fY3B1X3NvZnRfcmVzdGFydCgpLAo+IAo+IF9fY3Jhc2hfa2V4
ZWMKPiDCoCBtYWNoaW5lX2tleGVjCj4gwqDCoMKgwqBjcHVfc29mdF9yZXN0YXJ0Cj4gwqDCoMKg
wqDCoMKgcmVzdGFydAo+IMKgwqDCoMKgwqDCoMKgwqBfX2NwdV9zb2Z0X3Jlc3RhcnQKPiAKPiBU
aGUgZWFybHljb24gd2FzIGVuYWJsZWQgYnV0IGhhZCBubyBvdXRwdXQgZnJvbSB0aGUgMm5kIGtl
cm5lbCwgc28gaXQgd2FzCj4gcHJldHR5Cj4gbXVjaCBzdHVjayBpbiBhbGwgdGhvc2UgYXNzZW1i
bHkgY29kZSBpbiBhcm02NC9rZXJuZWwvaGVhZC5TIG9yIHRoZSBlYXJseSBwYXJ0Cj4gb2Ygc3Rh
cnRfa2VybmVsKCkgYmVmb3JlIGVhcmx5Y29uIHdhcyBpbml0aWFsaXplZC4KPiAKPiBJdCB0dXJu
ZWQgb3V0IHRoaXMgaGFzIHNvbWV0aGluZyB0byBkbyB3aXRoIG5yX2NwdXMgaW4gdGhlIDFzdCBr
ZXJuZWwsCj4gYWx0aG91Z2gKPiB0aGUgMm5kIGtlcm5lbCBhbHdheXMgaGFzIG5yX2NwdXM9MSBb
MV0uIEl0IHdhcyB0ZXN0ZWQgd2l0aCBib3RoCj4gY3Jhc2hrZXJuZWw9NTEyTSBvciA3NjhNLgo+
IAo+IG5yX2NwdXMgPD0gOTbCoMKgR09PRCAoMm5kIGtlcm5lbCB3YXMgdXAgaW4gMi0zIG1pbnMu
KQo+IG5yX2NwdXM9MjU2wqDCoMKgwqBCQUTCoMKgKDJuZCBrZXJuZWwgd2FzIE5PVCB1cCBhZnRl
ciAxIGhvdXIuKQo+IG5yX2NwdXM9MTI3wqDCoMKgwqBCQUTCoMKgKDJuZCBrZXJuZWwgd2FzIE5P
VCB1cCBhZnRlciAxMCBtaW5zLikKPiAKPiBJIGRpZCBhbHNvIHRlc3Qgd2l0aCBhbmQgd2l0aG91
dCBDT05GSUdfQVJNNjRfVkhFIChpLmUuLCBlbDJfc3dpdGNoKSBtYWRlIG5vCj4gZGlmZmVyZW5j
ZS4KPiAKPiBbMV0gS0RVTVBfQ09NTUFORExJTkVfQVBQRU5EPSJpcnFwb2xsIG5yX2NwdXM9MSBz
d2lvdGxiPW5vZm9yY2UgcmVzZXRfZGV2aWNlcyIKPiAKPiBJIGFtIHN0aWxsIGZpZ3VyaW5nIG91
dCBhIHdheSB0byBkZWJ1ZyB0aG9zZSBhc3NlbWJseSBjb2RlIHRvIHdoZXJlIGl0Cj4gYWN0dWFs
bHkKPiBodW5nLCBidXQgdGhlIHNlcnZlciB3YXMgaG9va2VkIHVwIHdpdGggYSBjb25zZXJ2ZXIg
dGhhdCB3YXMgbm90IGFibGUgdG8KPiBnZW5lcmF0ZSBhbnkgc3lzcnEgYW5kIEkgaGF2ZSBubyBz
aGVsbCBhY2Nlc3MgdG8gdGhlIGNvbnNlcnZlciwgc28gc2VlbXMgYSBiaXQKPiBkaWZmaWN1bHQg
dG8gdXNlIGtnZGIgb3Iga2RiIGluIHRoaXMgY2FzZS4KPiAKPiBDUFUgaW5mb3JtYXRpb24sCj4g
Cj4gIyBsc2NwdQo+IEFyY2hpdGVjdHVyZTrCoMKgwqDCoMKgwqDCoMKgYWFyY2g2NAo+IEJ5dGUg
T3JkZXI6wqDCoMKgwqDCoMKgwqDCoMKgwqBMaXR0bGUgRW5kaWFuCj4gQ1BVKHMpOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAyNTYKPiBPbi1saW5lIENQVShzKSBsaXN0OiAwLTI1NQo+IFRo
cmVhZChzKSBwZXIgY29yZTrCoMKgNAo+IENvcmUocykgcGVyIHNvY2tldDrCoMKgMzIKPiBTb2Nr
ZXQocyk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDIKPiBOVU1BIG5vZGUocyk6wqDCoMKgwqDCoMKg
wqDCoDIKPiBWZW5kb3IgSUQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoENhdml1bQo+IE1vZGVsOsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDEKPiBNb2RlbCBuYW1lOsKgwqDCoMKgwqDCoMKg
wqDCoMKgVGh1bmRlclgyIDk5eHgKPiBTdGVwcGluZzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAw
eDEKPiBCb2dvTUlQUzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA0MDAuMDAKPiBMMWQgY2FjaGU6
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDMySwo+IEwxaSBjYWNoZTrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgMzJLCj4gTDIgY2FjaGU6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMjU2Swo+IEwzIGNhY2hl
OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDMyNzY4Swo+IE5VTUEgbm9kZTAgQ1BVKHMpOsKgwqDC
oDAtMTI3Cj4gTlVNQSBub2RlMSBDUFUocyk6wqDCoMKgMTI4LTI1NQo+IEZsYWdzOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZwIGFzaW1kIGV2dHN0cm0gYWVzIHBtdWxsIHNoYTEgc2hh
MiBjcmMzMiBhdG9taWNzIGNwdWlkCj4gYXNpbWRyZG0KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
