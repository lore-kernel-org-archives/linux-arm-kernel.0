Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB99AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:53:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7797F2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dBogmufl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H0BzMHZk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cyIcBeuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7797F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GbTUm05FwZzhAt8XmauiiXvSlk0MLNs85Js6wN5UHUQ=; b=dBogmuflkEFrLmjILwTMIA9T8
	Gn72pw7PT0JTmOQPx7Vop5C9vZrplB0PBmdwpnzp4ZWAUlDmd+x20v1Ak+VfPa74Jw+ChFiQGy0a6
	wBFe+g0eYjmSieEMp+9NswoncAeP+RzzhPwu2gZlb76kjR0Mk9ijvDbjiwVT67o9SfP3CjRZg30R0
	uez2YY5eI9V/vpdV1jeCFgnYHqhraLVL0xlAb/Y+mD5qk3/0kxeJUrHVytyHePmB1uRI5kq4kO4MP
	1TqJMM3QbB/bYu81NI9jVe5+ttyaSymIcawH68as81jZ53U3aEmDEXmPYKNzIvkyWxrosRzTCkbnz
	EK2ptUVkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7Ws-0001lL-CZ; Fri, 08 Feb 2019 14:53:22 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7Wo-0001ku-Ii
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:53:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 2AAF66085F; Fri,  8 Feb 2019 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549637598;
 bh=MPRaqOdkGpix0APQkLF+9Z/Ip7Q0xgLGZYfbeWNgmao=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H0BzMHZkFW8CxQOIZpkQMaQKMB5qqhwPDD+hL7Y5iyalbzBwpG++LOptTR5Lz9eVO
 I0i1DzGA0bjfzTaajRFGHujjtKczwZynEoiyss5UWhv14D5n5A8D32KPXXd6r4rlXq
 HnvN0y6c+B5wB3x+2GzMOKa/LmGtIza5M4Mi/y0U=
Received: from [192.168.1.100] (unknown [157.45.225.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 93C4F60208;
 Fri,  8 Feb 2019 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549637597;
 bh=MPRaqOdkGpix0APQkLF+9Z/Ip7Q0xgLGZYfbeWNgmao=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cyIcBeujMHi2oZAkg1z3EGJzMNrRji9YMGARAdGeO3b9Zcty2cHsnG6/ngK5v1QSX
 w8dHHy1qoSNNWcB8CzpIbTuYZKoW9rsA2zRCGAYPeuAaXLARnidJ4QYW7aLJWcC3qb
 IhzlVFYGRIyT/0+BZ9OqzTvu9CDhhMJXHdPLJZB4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93C4F60208
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 1/6] arm64: dts: qcom: sdm845: Add Coresight support
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
 dianders@chromium.org, sboyd@kernel.org, bjorn.andersson@linaro.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, marc.w.gonzalez@free.fr
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <81dc97e6-2640-d600-9373-30518ed59792@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <3922a74f-3607-fb9f-2b50-bb9b2f45b1cf@codeaurora.org>
Date: Fri, 8 Feb 2019 20:23:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <81dc97e6-2640-d600-9373-30518ed59792@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_065318_655498_C1BA2B69 
X-CRM114-Status: GOOD (  12.28  )
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

T24gMi84LzIwMTkgNzo1MCBQTSwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToKPiAKPiAKPiBPbiAw
MS8wMi8yMDE5IDAwOjUzLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4+IEFkZCBjb3Jlc2ln
aHQgY29tcG9uZW50cyBmb3VuZCBvbiBRdWFsY29tbSBTRE04NDUgU29DLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBTYWkgUHJha2FzaCBSYW5qYW4gPHNhaXByYWthc2gucmFuamFuQGNvZGVhdXJvcmEu
b3JnPgo+Pgo+PiAtLS0KPj4gRm9yIHRlc3RpbmcsIGFsbCBkZXBlbmRlbnQgcGF0Y2hlcyBhcmUg
aW4gYmVsb3cgdHJlZToKPj4gwqAgKiBodHRwczovL2dpdGh1Yi5jb20vc2FpcHJha2FzaC1yYW5q
YW4vbGludXgvdHJlZS9jb3Jlc2lnaHQtbmV4dAo+Pgo+PiAtIERlcGVuZHMgb24gQU9TUyBRTVAg
c2lkZSBjaGFubmVsIHBhdGNoZXMgYnkgQmpvcm4gQW5kZXJzc29uIFsxXSAtIFs0XS4KPj4gLSBB
TUJBIGJ1cyBwY2xrIGNoYW5nZSBbNV0uCj4+IC0gQWxzbyBkZXBlbmRzIG9uIHBhdGNoICgiYXJt
NjQ6IGR0czogcWNvbTogc2RtODQ1OiBJbmNyZWFzZSBhZGRyZXNzCj4+IMKgwqAgYW5kIHNpemUg
Y2VsbHMgZm9yIHNvYyIpIFs2XS4KPj4KPj4gWzFdIAo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMTkwMTMxMDAzOTMzLjExNDM2LTUtYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmcv
IAo+Pgo+PiBbMl0gCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTAxMzEwMDM5
MzMuMTE0MzYtNi1iam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZy8gCj4+Cj4+IFszXSAKPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDEzMTAwMzkzMy4xMTQzNi03LWJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnLyAKPj4KPj4gWzRdIAo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMTkwMTMxMDAzOTMzLjExNDM2LTEwLWJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3Jn
LyAKPj4KPj4gWzVdIAo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTkwMTMxMDIw
MTQxLjI4MzUyLTEtYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmcvIAo+Pgo+PiBbNl0gCj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTAxMTcwNDI5NDAuMjU0ODctMi1iam9ybi5h
bmRlcnNzb25AbGluYXJvLm9yZy8gCj4+Cj4+IC0tLQo+PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRz
L3Fjb20vc2RtODQ1LmR0c2kgfCA0MzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA0MzQgaW5zZXJ0aW9ucygrKQo+Pgo+IAo+IEFja2VkLWJ5OiBTdXp1
a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPgoKVGhhbmtzIQoKLS0gClFVQUxD
T01NIElORElBLCBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4g
aXMgYSBtZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91
bmRhdGlvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
