Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0739E2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Biu1Vh7E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGajBNrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fE5d7OwgQm4fxz9wH6Abo6Wzx06s/GJ5XPawf9rV/AA=; b=Biu1Vh7EA6AYh5
	QNxeZkPWkilgKRgXkmcjVg4ckFTE8Y/7Fqd+uCJs8RiAyVvWfoEyuC4A8mY8/P7c0OhvjhJyt6UUF
	fRxt9wF3hzJc/cGAPYi5ko58uTw46ttsGdViNn4f0RWSXV73BE5ICWgqSQcpCYmES8LE7BfnOZ53g
	CQ7MoX5LbU+COoaR38Kw7IMowLkFU64i/mNJec1Ld57YS/adrwt45QmgnUqCVL6ZX8m9H96bF+Ez0
	mnqo07pPKED2qI9bHulYiO2SxAmEqplecQ3EW7vPQqpS6aXtVFm6HqetAAMYwCWGKgs6ly8Zcm74Y
	fnWXXV4JQZbjkDjWUZ+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJaY-0005jB-Ke; Mon, 25 Feb 2019 16:58:46 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJaT-0005i3-Kv
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:58:44 +0000
Received: by mail-it1-x143.google.com with SMTP id z131so13754549itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=HF/x9SIP2c4LOJI8Gu/IIr7CYiRJWMzO7pgDk5/UdPY=;
 b=jGajBNrFpEYR81NnOiQvQDn66PDFAHx8qfbvW2kglgS++AbZLwBIrC0A2cpXU3WGPI
 +RXEtFh3ehN0ZPz064gxlgRsRg6cofNkKa0JqVy+X+TGsB5bIDDtlq9pLsxsXDo/SxuX
 gNPKrbN8VOba/0rzw8keGuBeJxwzP2mQ1cYk1Ul7v8H7+RLcqsoQEbAdjW6k+S0nq/jd
 AOtIHVrJ2FkvO2JToQjZr+lJsi1bVTQTScvvbAUn5M3v/1pqAivL1S7dMLgqNZ24WCZ3
 IHT/2jCwFA3sxWFKwIGxEWdm3GHWi9Iy1l9wAAYnpXLil9ObaXSlK1g2sOgoxUadaK/A
 mSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=HF/x9SIP2c4LOJI8Gu/IIr7CYiRJWMzO7pgDk5/UdPY=;
 b=R1lrXnlVG7zZHz96LQSi3fFdDzcNA1IuhVtUv5mofG1A9zIuIQ0Xju31q8o1xYsfsD
 Q0dtF2iDq9iFOZIZJMEVIc+5F7ot/XFLXWd9gvzkizJvp2M3bdYJXKqUWM/qdLyieSOG
 Cu0T9WEckXxcGNr70+jDeKsCW09660DJwVuYEduAjrUnwZoRBBPZfdTgd9CDMjr9myJO
 YUGFv2KGoaxqlhXlnjiZMwtxaImTIf5i9t8oc06ymfi8z+c0WCLumybe1UhqTdli6/L0
 wU2FjbwHtNU0h4nOHrOLpci/60Wu++j3I4Dd9MeNkDsPntqz0JX8WFix5iyUZfZsWryR
 hI/g==
X-Gm-Message-State: AHQUAuax6eq5xMzGmnwk0EueHe+m9K0B86JOAsaabpODCGuHpA/w2lpo
 sOapKdkdhlbZ3nHDbe+xMQ==
X-Google-Smtp-Source: AHgI3Ibl91VylLRUlVr4VuwFQHvbTDSfHnPSdKOznY9rlV0fvSEq3CRG3u7TaOVcd3TlT20v9eVZ3g==
X-Received: by 2002:a05:660c:344:: with SMTP id
 b4mr10118861itl.51.1551113919952; 
 Mon, 25 Feb 2019 08:58:39 -0800 (PST)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com.
 [99.229.26.117])
 by smtp.gmail.com with ESMTPSA id f26sm4003124ioh.1.2019.02.25.08.58.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 08:58:39 -0800 (PST)
Date: Mon, 25 Feb 2019 11:58:36 -0500
From: Robert Yang <decatf@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190225165836.GA12933@r>
References: <20190222193426.10747-1-digetx@gmail.com>
 <20190225040232.GA2242@qmqm.qmqm.pl>
 <20190225082155.1163ed85@dimatab>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225082155.1163ed85@dimatab>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_085841_689830_2FC6F182 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMDg6MjE6NTVBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+INCSIE1vbiwgMjUgRmViIDIwMTkgMDU6MDI6MzMgKzAxMDAKPiBNaWNoYcWCIE1p
cm9zxYJhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+INC/0LjRiNC10YI6Cj4gCj4gPiBPbiBG
cmksIEZlYiAyMiwgMjAxOSBhdCAxMDozNDoxOVBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3Jv
dGU6Cj4gPiA+IEhlbGxvLAo+ID4gPiAKPiA+ID4gVGhpcyBwYXRjaHNldCBhZGRzIHN1cHBvcnQg
Zm9yIHRoZSBUcnVzdGVkIEZvdW5kYXRpb25zIGZpcm13YXJlIG9uCj4gPiA+IE5WSURJQSBUZWdy
YTMwLiBQcmV0dHkgbXVjaCBhbGwgb2YgVGVncmEzMCBjb25zdW1lciBkZXZpY2VzIGhhdmUKPiA+
ID4gdGhhdCBmaXJtd2FyZSBhbmQgdXBzdHJlYW0ga2VybmVsIGNhbid0IGJvb3Qgb24gdGhvc2Ug
ZGV2aWNlcwo+ID4gPiB3aXRob3V0IHRoZSBmaXJtd2FyZSBzdXBwb3J0LiAgCj4gPiAKPiA+IEhp
IERtaXRyeQo+ID4gCj4gPiBJJ3ZlIGFwcGxpZWQgYW5kIHRlc3RlZCB0aGlzIHBhdGNoc2V0IG9u
IG15IFRGMzAwVC4gQm9vdHMgYW5kCj4gPiBzdXNwZW5kcy93YWtlcyB1c2luZyAncnRjd2FrZSAt
bSBtZW0gLXMgMSAtZCAvZGV2L3J0YzEnIGFzIHRoZSB0ZXN0Lgo+ID4gZG1lc2cgYXR0YWNoZWQu
Cj4gPiAKPiA+IFRoZSBleGFjdCB0cmVlIHVzZWQ6Cj4gPiAJZ2l0Oi8vcmVyZS5xbXFtLnBsL2xp
bnV4IHRmMzAwdAo+ID4gCj4gPiBGZWVsIGZyZWUgdG8gYWRkIG15IFRlc3RlZC1ieSBhbmQgU2ln
bmVkLW9mZi1ieSBvbiB0aGUgcGF0Y2hlcyB3aGVyZQo+ID4gYXByb3ByaWF0ZSwgYW5kIHRoYW5r
cyBmb3IgeW91ciB3b3JrIQo+IAo+IEF3ZXNvbWUsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ghCj4gCj4g
Um9iZXJ0LCBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhhdCB2NiB3b3JrcyBmb3IgeW91IHRv
bz8KPiAKClllcywgdjYgd29ya3Mgb24gT3V5YS4KCkxQMS9MUDIgc3VzcGVuZCB0ZXN0ZWQgd2l0
aCAncnRjd2FrZSAtbSBtZW0gLXMgNScKY3B1aWRsZSBMUDIgdGVzdGVkIHdpdGggJ2VjaG8gMCB8
IHRlZSAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVbMS0zXS9vbmxpbmUnClRlc3RlZCB3aXRo
IENPTkZJR19TTVAgZGlzYWJsZWQgdG9vLgoKWW91IGNhbiBhZGQgbXkgVGVzdGVkLWJ5IHRvIHRo
aXMgcGF0Y2ggc2V0LgoKPiBJJ2xsIHByb2JhYmx5IG1ha2UgYSB2NyB3aXRoIGFuIGV4dHJhIG1p
bm9yIGNsZWFuIHVwIGFuZCB0aGVuIHdpbGwgYWRkCj4gYWxsIHRoZSBhcHByb3ByaWF0ZSB0YWdz
IHRvIHRoZSBwYXRjaGVzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
