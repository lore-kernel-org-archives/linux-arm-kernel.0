Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F0C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:47:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BDC20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PQF68cpa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rq/lIVUb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GsX2NRsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BDC20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5UVFIIBIJi3QXJAM2/qzG9f/6SlSB/RRmgJ6R0SzaZg=; b=PQF68cpa/wHjkmK3PsE5soC9L
	SR7THO6NrHvlsznOETQM8oWt3iETsLNoGPVP3X0nko6i6/zF/e14ue3ypWa164X5tL/k2BXp/mWHU
	fYVoDUS23GcHOCx3rbyrCY3oY83ezG/wappkH6CcBGOnt61EJ90MnPc/BQC/usRKE2sNi1qJ9tOqM
	YEgU4yxwCt1Uu4iEii8UkQXM3It6e3ESm+17Gwyl8lNFgJuotBmnXO/Vm943/X42Nmyff+sr7BTlc
	SeAzoaDNDxaPrpGVqlTuBNUxQ+tJZgscPQIKmeQ4spbw8oUaP1KyUNe7OO032Tg37OHY6Ie3Ghh9N
	2tRqDEzdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpMzG-0002wx-Uc; Fri, 01 Feb 2019 00:47:18 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpMzD-0002wJ-ML
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:47:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E58A960907; Fri,  1 Feb 2019 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982035;
 bh=Y8lg0DlVDLXzhowlfWcZvLE2uBEi8sHKrhd8v6t2Stc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Rq/lIVUbXox50BBZYs6BlWi6H6Jrn3ndg0zC2Rx07cI858hgd19wIO93mwMQce9uj
 N7W6Er7cxbK9wOCntlgXQ83sJNDSNYQkfCSlOXSBebhQBj9wndbrDDMCcEV/PaIiJv
 E/nhx/AkxFTfz1Tj4Mq5u6ooKDD6D0i60yfPcAe0=
Received: from [192.168.43.47] (unknown [223.186.125.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C941A6060A;
 Fri,  1 Feb 2019 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982032;
 bh=Y8lg0DlVDLXzhowlfWcZvLE2uBEi8sHKrhd8v6t2Stc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GsX2NRsvbd12+TV21lFQQPE9KcUT/y/L5O6jsO/jjJbUaOORRJxX55XA76dlRqk1Z
 0ZDzHbAyD9pkL9sg7zbLm3xUWyhhwrEZSOhZgdpAuyZad4y3pOHEPd8MpkIntuCYWD
 gCWOMFOaE3yFB4HpgeqvVgLfUgsUzjFtYlz77BlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C941A6060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
 dianders@chromium.org, sboyd@kernel.org, bjorn.andersson@linaro.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, marc.w.gonzalez@free.fr
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Date: Fri, 1 Feb 2019 06:17:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_164715_760022_D4822C8A 
X-CRM114-Status: GOOD (  15.56  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org, tingwei@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS8zMS8yMDE5IDExOjMxIFBNLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOgo+IAo+IAo+IE9u
IDMxLzAxLzIwMTkgMTQ6MjIsIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4gQWRkIFVDSSB0
YWJsZSBmb3IgY29yZXNpZ2h0IENQVSBkZWJ1ZyBtb2R1bGUuIFRoaXMgcGF0Y2ggYWRkcwo+PiB0
aGUgVUNJIGVudHJpZXMgZm9yIEtyeW8gQ1BVcyBmb3VuZCBvbiBNU004OTk2IHdoaWNoIHNoYXJl
cwo+PiB0aGUgc2FtZSBQSURzIGFzIEVUTXMuCj4+Cj4+IFdpdGhvdXQgdGhpcywgYmVsb3cgZXJy
b3IgaXMgb2JzZXJ2ZWQgb24gTVNNODk5NjoKPiAKPiBuaXQ6IFN1YmplY3QgZG9lc24ndCBtYXRj
aCB0aGUgcGF0Y2ggY29udGVudHMuIFlvdSBjb3VsZCBzaW1wbHkgc2F5IDoKPiAKPiBjb3Jlc2ln
aHQ6IGNwdS1kZWJ1ZzogQWRkIHN1cHBvcnQgZm9yIFF1YWxjb21tIEtyeW8KPiAKCkRvbmUuCgo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1j
cHUtZGVidWcuYyAKPj4gYi9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWNw
dS1kZWJ1Zy5jCj4+IGluZGV4IGU4ODE5ZDc1MDkzOC4uOTE1ZDg2YTM5Y2VlIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWNwdS1kZWJ1Zy5jCj4+
ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtY3B1LWRlYnVnLmMK
Pj4gQEAgLTY1NSwyNCArNjU1LDIzIEBAIHN0YXRpYyBpbnQgZGVidWdfcmVtb3ZlKHN0cnVjdCBh
bWJhX2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiArc3Rh
dGljIHN0cnVjdCBhbWJhX2NzX3VjaV9pZCB1Y2lfaWRfZGVidWdbXSA9IHsKPiAKPiBBcyBTdGVw
aGVuIG1lbnRpb25lZCwgdGhpcyBtdXN0IGJlICJjb25zdCIuCj4gCj4gUmVzdCBsb29rcyBmaW5l
LgoKRG9uZS4KClRoYW5rcywKU2FpCgotLSAKUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBvZiBR
dWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIG1lbWJlcgpvZiBDb2RlIEF1cm9y
YSBGb3J1bSwgaG9zdGVkIGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9uCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
