Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4AD206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VJ1cb66Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="da0gHnAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4AD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmEqNDXfP+urM4Rdge9UMo7NL7tfM/vwgEA2/6J89nU=; b=VJ1cb66QwGCcqp
	ndOrunveRUrdlj4wvFZK1elcIK2G+LzdAigEcKjRkLB2gLAqBzBlHcjdyMt9kXXTnyIJmShS2f1NE
	5hmfvnzTG+WTdTj/UonnSIzIQGDntmvDiRLIkbY/LMkqu70babjL5tM/Ndv8mUuC04sR1sVibY/7o
	i6WhWKXR+YEHvWrVqFtCCpZfVosjqYD6LKxFrmY3H98LMtjoYyMjctE6OgwLvpiF4Nz/n512tV05D
	fMB7485R9hEmsHfWVKGHiXTPsouJ8kjsRe7iZP311yAyPHOTJYSTnic0UdkQ54y6ZkKrOUwLlkxsG
	M4plt4DE7OcZX6jo6s3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggp4t-0004tP-Ex; Tue, 08 Jan 2019 10:57:47 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggp4Y-0004gi-De
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 10:57:45 +0000
Received: by mail-oi1-x22d.google.com with SMTP id w13so2926926oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xWpzVdg/e6UzVOjrd4RtIckInPRkRyaSSS21wxmlbwE=;
 b=da0gHnAe+uyOwsRktXvfE71bVxMFbgEknQBo2D2+GGapQ6j6CWkaA9mrLq/9UeWD5N
 2817lc9ysrpAgHmY1vTrhVh5C125a4jSO0tPE/JdUcLLWYLzV4IFB3R1p45DLDlHdk/1
 RbMVB1lmLbn0er0GvmSOinw6IQI3E6LGjvXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xWpzVdg/e6UzVOjrd4RtIckInPRkRyaSSS21wxmlbwE=;
 b=UVVDSZgc2gN2z/OVvayQiG8Onuoj/v+xI5r2MCPhEWqcjgK1yWJD5wwRM0KJmMCKx+
 frItEv1/IEF7WI4S8PbexzYviCnCQjYO0xsh8LOMhQlQqUaGsdwe9X65B+jCNz6hjY/v
 BJqpoUt1Ugx5Itkson3Ha9iny4++QWbUDPwJyOOdxL4DdF8Lkm9R5p/m4R5upxRjIvKb
 4DcUEwXWs4ab7fDB8MDEL+IL+WvEpPmLUlgP9ExnVfDAAORthJLmcqoiu0eIXWDGUmXS
 iPAd/mIpJhJ5wvICtrSrvR1zt1CkEGw5BpimkR7+zpbrnJ+g6GdP1qtNZxyMvLdT1qFA
 o5aA==
X-Gm-Message-State: AJcUuke3BmwpRZqi3nV53WCLPq6+YhM/EaCMeJwMxqfdULxkOtET1kfO
 nnqDqGkjgSujZrikVHr6aAoXgZuIYaHpz2PDW1Wh9w==
X-Google-Smtp-Source: ALg8bN785s8id1Mhe/zipIcUqyQef83MGcXhYd7OHCu7MT/49DFLViIwU3g2vSL/Z1k2XsLyvWZ9lDPZruQWGHRhtCc=
X-Received: by 2002:aca:f103:: with SMTP id p3mr805419oih.94.1546945044745;
 Tue, 08 Jan 2019 02:57:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
 <20190108004632.GA3247@icarus>
In-Reply-To: <20190108004632.GA3247@icarus>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 8 Jan 2019 11:57:13 +0100
Message-ID: <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
Subject: Re: New IIO/counter driver
To: William Breathitt Gray <vilhelm.gray@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_025726_983691_9615650F 
X-CRM114-Status: GOOD (  20.63  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin GAIGNARD <benjamin.gaignard@st.com>, linux-iio@vger.kernel.org,
 Patrick Havelange <patrick.havelange@essensium.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fabrice Gasnier <fabrice.gasnier@st.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgbWFyLiA4IGphbnYuIDIwMTkgw6AgMDE6NDYsIFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkKPHZp
bGhlbG0uZ3JheUBnbWFpbC5jb20+IGEgw6ljcml0IDoKPgo+IE9uIE1vbiwgSmFuIDA3LCAyMDE5
IGF0IDAyOjQ1OjM3UE0gKzAxMDAsIFBhdHJpY2sgSGF2ZWxhbmdlIHdyb3RlOgo+ID4gSGVsbG8s
Cj4gPgo+ID4gSSdtIGluIHRoZSBwcm9jZXNzIG9mIGFkZGluZyBhIG5ldyBJSU8vY291bnRlciBk
cml2ZXIsIGhvd2V2ZXIgSSBhbHNvIHNhdwo+ID4gdGhhdCB0aGVyZSB3YXMgYSB3b3JrIGluIHBy
b2dyZXNzIHRvIGhhdmUgYSBzZXBhcmF0ZSBjb3VudGVyIHN1YnN5c3RlbSAoCj4gPiBodHRwczov
L21hcmMuaW5mby8/bD1saW51eC1paW8mbT0xNTM5NzQxNjc3MjcyMDYgKS4gQnV0IGl0IHNlZW1z
IHRoZXJlIGlzCj4gPiBubyByZWNlbnQgcHJvZ3Jlc3Mgb24gaXQuCj4gPiBXaGF0IGlzIHRoZSBz
dGF0ZSBvZiB0aG9zZSBwYXRjaGVzID8gSXMgaXQgc3RpbGwgaW50ZXJlc3RpbmcgdG8gZGV2ZWxv
cCB0aGUKPiA+IGRyaXZlciBhcyBhbiBJSU8vY291bnRlciAsIG9yIHNob3VsZCBJIHVzZSBhbHJl
YWR5IHRoYXQgbmV3IHN1YnN5c3RlbSA/Cj4gPgo+ID4gQmVzdCBSZWdhcmRzLAo+ID4KPiA+IFBh
dHJpY2sgSGF2ZWxhbmdlLgo+Cj4gSGVsbG8sCj4KPiBJIGFtIHN0aWxsIG9wZW4gdG8gbWVyZ2lu
ZyB0aGlzIHBhdGNoc2V0IGFuZCBtYWludGFpbmluZyB0aGUgQ291bnRlcgo+IHN1YnN5c3RlbS4g
SG93ZXZlciwgSSB0b29rIHRoZSBsYWNrIG9mIHJlc3BvbnNlIGZvciBteSBsYXRlc3QKPiBzdWJt
aXNzaW9uIHRvIGluZGljYXRlIGEgbG9zcyBvZiBpbnRlcmVzdCBpbiB0aGlzIHBhdGNoc2V0J3Mg
YXBwcm9hY2guCj4gSWYgdGhlcmUgYXJlIHN0aWxsIHBlb3BsZSB3aG8gd2FudCB0aGlzLCBJIGNh
biByZWJhc2UgYW5kIHJlc2VuZCB0aGlzCj4gcGF0Y2hzZXQgZm9yIHN1Ym1pc3Npb247IHRoZSBw
YXN0IGZldyB2ZXJzaW9ucyBoYXZlIHByaW1hcmlseSBiZWVuIGNvZGUKPiBjbGFyaXR5IGFuZCBk
b2N1bWVudGF0aW9uIGNoYW5nZXMgc28gSSBiZWxpZXZlIHRoZSBjb3JlIGRlc2lnbiBpdHNlbGYg
aXMKPiBzb21ld2hhdCBzdGFibGUgbm93Lgo+Cj4gSnVzdCBsZXQgbWUga25vdyBob3cgYmVzdCB0
byBwcm9jZWVkIGFuZCBJIHNoYWxsIGJlIGhhcHB5IHRvIG9ibGlnZSAtLQo+IHdoZXRoZXIgdG8g
Y29udGludWUgbWFpbnRhaW5pbmcgdGhpcyBwYXRjaHNldCBvciB0byBkcm9wIHRoaXMgZGVzaWdu
IGluCj4gZmF2b3Igb2YgaW1wcm92aW5nIHRoZSBleGlzdGluZyBJSU8gQ291bnRlciBjb2RlIGlu
IHRoZSBrZXJuZWwuCj4KPiBJJ2xsIENDIHRob3NlIGZyb20gdGhlIHBhdGNoc2V0IHN1Ym1pc3Np
b24gdG8ga2VlcCB0aGVtIGluIHRoZSBsb29wLgoKSSBjb25maXJtIHRoYXQgSSBzdGlsbCBpbnRl
cmVzdGVkIHRvIGdldCB0aG9zZSBwYXRjaGVzIG1lcmdlZC4KClJlZ2FyZHMsCkJlbmphbWluCj4K
PiBTaW5jZXJlbHksCj4KPiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5Cj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCgoK
Ci0tIApCZW5qYW1pbiBHYWlnbmFyZAoKR3JhcGhpYyBTdHVkeSBHcm91cAoKTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiBGYWNl
Ym9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
