Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC0C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A97120880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZmXOzpa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MGR+n7w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A97120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qw1bgrx7HOYnx3Zs1mYgYe3Wjvk/zZu6KOAB2a96nW0=; b=DZmXOzpapjAblG
	Fb7Jlxe49sjz3XT/VwM4wuyA8TnzBJLb9ngQcg9MZawLAz4hK/SblE535vILvjV6yf9XYxxszQCyX
	o3MvWSEGDfIla1FJFYXDpJFm5Pg8mqubbEmWzS3pOpb3R1cvZ7IiES7NB3bTv6cQabApwzmzw1NP/
	uZ58TKJALmimeygTEVtantGh3+FDhf4Ccv4dUYa+79ZW5tRP87P3dw4t+QKodKk4Wnt3O6f41td8q
	H5BbXvJS5lrS1VWvvHm3E97DWOG/fMhdbs+GmRf2AA5elrk2UN4GJIcb02KmdHESUXiSxFwlJSHen
	oJ09CCWRVn1TEmvdUrYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXRDf-0000M3-GS; Thu, 13 Dec 2018 13:40:03 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXRDb-0000FD-Ms
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:40:01 +0000
Received: by mail-qk1-x743.google.com with SMTP id 189so1102437qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4E2Bwb5DUkf0C1vvdBwNjevr4g1q0gVM6ZGu5vUMw7I=;
 b=MGR+n7w0Q8ma9b1TeaeKXpvJnPdVxmm8gV3L0huy3O+/XUPhE59Yci9CMHqfz6FToy
 mWw99E14cEvwJJX5AC9GMHfVbkWso6/KaGmhhIwLCFwTQYbqBOKLLbqb5o88JlVrYYBA
 az7kmNSkHfHcVmim8SE3Uu3OvtdyjrWyAD2TqZmlI8+oDjyRSX84z5PCgZXtNeFi7RzY
 1OQo5P/4NpKPtB5aENfVRdosLq/jadMz3Z351JyVOJarb7I+edkMeV0aRWdSzwpgBKnw
 /eeFj1BqYKaDgnV53xsB9Qa5mriHIjLbXzgw5yJrizBYd7N28TPBUU4dUsJkBAdWT/7/
 ZSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4E2Bwb5DUkf0C1vvdBwNjevr4g1q0gVM6ZGu5vUMw7I=;
 b=Osax+/+VETKLEzd6rUE6PB5/I9HVNCE85Jxq/6IAlG6e2darBEG4N9W11lobYxWalk
 LgKO/ankfYAEWDtXS9vn+9Cma9/efeDw3SdywfCeWLlS0KP0rDnJR7O+qoy3LbMS0LBn
 pBirethaAjZjYTJkqdVESMVv/JubQl2h0PjWQC1aDU80Bx3XIGrqOOqiAsKUldFlCqgL
 Gaotq9teWoU4xQFgnV+pNEH1tpdjBheuOzmR/XMFBz0mGlRS3H90q+W1+qszMiz0K37l
 GjSy/9YXMtNEMKXZjc0NvYWx596VUnl0mRo/AkU19vu341+UXA/DbKqEqbRzkBx3juRo
 4pzw==
X-Gm-Message-State: AA+aEWZaclv/9th0M2pMdK736sPOGNOUJLR7/yc93I3eWjVKzVMEkfnG
 GLolALYIsal6WOkww6z65v0ccA==
X-Google-Smtp-Source: AFSGD/UxO/Aat1EAOtmJEujgR6feGpGNSuBWD69clE1pwoPEgfF3IASTk2RptGzoT0ocmoGrKtvwRA==
X-Received: by 2002:a37:52d6:: with SMTP id
 g205mr22340313qkb.335.1544708388593; 
 Thu, 13 Dec 2018 05:39:48 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id m1sm1285923qkh.15.2018.12.13.05.39.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 05:39:48 -0800 (PST)
Message-ID: <1544708386.18411.13.camel@lca.pw>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
From: Qian Cai <cai@lca.pw>
To: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 13 Dec 2018 08:39:46 -0500
In-Reply-To: <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
 <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_053959_798263_4FCFCCAA 
X-CRM114-Status: GOOD (  25.10  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 kexec mailing list <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDExOjEwICswNTMwLCBCaHVwZXNoIFNoYXJtYSB3cm90ZToK
PiBIaSBRaWFuIENhaSwKPiAKPiBPbiBUaHUsIERlYyAxMywgMjAxOCBhdCAxMDo1MyBBTSBRaWFu
IENhaSA8Y2FpQGxjYS5wdz4gd3JvdGU6Cj4gPiAKPiA+IE9uIHRoaXMgSFBFIEFwb2xsbyA3MCBh
cm02NCBzZXJ2ZXIgd2l0aCAyNTYgQ1BVcywgdHJpZ2dlcmluZyBhIGNyYXNoCj4gPiBkdW1wIGp1
c3QgaHVuZy4gSXQgaGFzIDQgdGhyZWFkcyBvbiBlYWNoIGNvcmUuIEVhY2ggMi1jb3JlIHNoYXJl
IGEgc2FtZQo+ID4gTDEgYW5kIEwyIGNhY2hlcywgc28gdGhhdCBpcyA4IENQVXMgc2hhcmVzIHRo
b3NlLiBBbGwgQ1BVcyBzaGFyZSBhIHNhbWUKPiA+IEwzIGNhY2hlLgo+ID4gCj4gPiBJdCB0dXJu
ZWQgb3V0IHRoYXQgdGhpcyB3YXMgZHVlIHRvIHRoZSBUTEIgY29udGFpbmVkIHN0YWxlIGVudHJp
ZXMgKG9yCj4gPiB1bmluaXRpYWxpemVkIGp1bmsgd2hpY2gganVzdCBoYXBwZW5lZCB0byBsb29r
IHZhbGlkKSBmcm9tIHRoZSBmaXJzdAo+ID4ga2VybmVsIGJlZm9yZSB0dXJuaW5nIHRoZSBNTVUg
b24gaW4gdGhlIHNlY29uZCBrZXJuZWwgd2hpY2ggY2F1c2VkIHRoaXMKPiA+IGluc3RydWN0aW9u
IGh1bmcsCj4gPiAKPiA+IG1zcsKgwqDCoMKgwqBzY3Rscl9lbDEsIHgwCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IFFpYW4gQ2FpIDxjYWlAbGNhLnB3Pgo+ID4gLS0tCj4gPiDCoGFyY2gvYXJtNjQv
a2VybmVsL2hlYWQuUyB8IDQgKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9oZWFkLlMgYi9hcmNo
L2FybTY0L2tlcm5lbC9oZWFkLlMKPiA+IGluZGV4IDQ0NzFmNTcwYTI5NS4uNTE5NmYzZDcyOWRl
IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvaGVhZC5TCj4gPiArKysgYi9hcmNo
L2FybTY0L2tlcm5lbC9oZWFkLlMKPiA+IEBAIC03NzEsNiArNzcxLDEwIEBAIEVOVFJZKF9fZW5h
YmxlX21tdSkKPiA+IMKgwqDCoMKgwqDCoMKgwqBtc3LCoMKgwqDCoMKgdHRicjBfZWwxLCB4MsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8gbG9hZCBUVEJSMAo+ID4gwqDC
oMKgwqDCoMKgwqDCoG1zcsKgwqDCoMKgwqB0dGJyMV9lbDEsIHgxwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAvLyBsb2FkIFRUQlIxCj4gPiDCoMKgwqDCoMKgwqDCoMKgaXNi
Cj4gPiArwqDCoMKgwqDCoMKgwqBkc2LCoMKgwqDCoMKgbnNoc3QKPiA+ICvCoMKgwqDCoMKgwqDC
oHRsYmnCoMKgwqDCoHZtYWxsZTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC8vIGludmFsaWRhdGUgVExCCj4gPiArwqDCoMKgwqDCoMKgwqBkc2LCoMKg
wqDCoMKgbnNoCj4gPiArwqDCoMKgwqDCoMKgwqBpc2IKPiAKPiBUaGlzIHdpbGwgYmUgZXhlY3V0
ZWQgYm90aCBmb3IgdGhlIHByaW1hcnkgYW5kIGtkdW1wIGtlcm5lbCwgcmlnaHQ/IEkKPiBkb24n
dCB0aGluayB3ZSByZWFsbHkgd2FudCB0byBpbnZhbGlkYXRlIHRoZSBUTEIgd2hlbiBib290aW5n
IHRoZQo+IHByaW1hcnkga2VybmVsLgo+IEl0IHdvdWxkIGJlIHRvbyBzbG93IGFuZCBjb25zaWRl
cmluZyB0aGF0IHdlIG5lZWQgdG8gbWluaW1pemUgYm9vdAo+IHRpbWluZ3Mgb24gZW1iZWRkZWQg
YXJtNjQgZGV2aWNlcywgSSB0aGluayBpdCB3b3VsZCBub3QgYmUgYSBnb29kCj4gaWRlYS4KClll
cywgaXQgd2lsbCBiZSBleGVjdXRlZCBmb3IgdGhlIGZpcnN0IGtlcm5lbCBhcyB3ZWxsLiBBcyBK
YW1lcyBtZW50aW9uZWQsIGl0Cm5lZWRzIHRvIGJlIGRvbmUgdG8gaW52YWxpZGF0ZSBUTEIgdGhh
dCBtaWdodCBiZSB1c2VkIGJ5IGJvb3Rsb2FkZXIgYW55d2F5LgoKPiAKPiA+IMKgwqDCoMKgwqDC
oMKgwqBtc3LCoMKgwqDCoMKgc2N0bHJfZWwxLCB4MAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlzYgo+
ID4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gPiAtLQo+ID4gMi4xNy4yIChBcHBsZSBHaXQtMTEzKQo+
ID4gCj4gCj4gQWxzbyBkaWQgeW91IGNoZWNrIHRoaXMgaXNzdWUgSSByZXBvcnRlZCBvbiB0aGUg
SFBFIGFwb2xsbyBtYWNoaW5lcwo+IHNvbWUgZGF5cyBiYWNrIHdpdGggdGhlIGtkdW1wIGtlcm5l
bCBib290Cj4gPGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2tleGVjL21zZzIxNzUwLmh0
bWw+Lgo+IENhbiB5b3UgcGxlYXNlIGNvbmZpcm0gdGhhdCB5b3UgYXJlIG5vdCBmYWNpbmcgdGhl
IHNhbWUgaXNzdWUgKGFzIEkKPiBzdXNwZWN0IGZyb20gcmVhZGluZyB5b3VyIGVhcmxpZXIgQnVn
IFJlcG9ydCkgb24gdGhlIEhQRSBhcG9sbG8KPiBtYWNoaW5lLiBBbHNvIGFkZGluZyAnZWFybHlj
b24nIHRvIHRoZSBib290YXJncyBiZWluZyBwYXNzZWQgdG8gdGhlCj4ga2R1bXAga2VybmVsIHlv
dSBjYW4gc2VlIGlmIHlvdSBhcmUgYWJsZSB0byBhdGxlYXN0IGdldCBzb21lIGNvbnNvbGUKPiBv
dXRwdXQgZnJvbSB0aGUga2R1bXAga2VybmVsLgoKTm8sIGhlcmUgZGlkIG5vdCBlbmNvdW50ZXIg
dGhlIHByb2JsZW0geW91IG1lbnRpb25lZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
