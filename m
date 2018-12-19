Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:54:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C9E21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lb6ZFVFe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4zdV+V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C9E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yNfuUxx7WuAkuckmvi89OGbRv3qgv5jIG5nKvznE9jI=; b=Lb6ZFVFetpsCgc
	YRKDaqwJnGY1v025ClXb0d1LxoLwVEAhkeQIkXukiDOwc2SqGM3tcvCSAaXT/uoiAFW3YLQqUQR/y
	XEj9Ll/Alobyk0klSi8gv21lE4CA31wJcLtKs++ewIzs3sWm5C6TcNQPPvVt/PfMGDtWDUOXAEJMb
	JvHMMzLsTrQJYONzsRHJafyDd9NSSsDwIumX1NoWf9GTXt8yqQzYT915GmHikXGlEeq8QoVGpIpyL
	MPmM/Q4Dar1JlryOZh45WyFEQaz7bg1hHSpDrdmjylBvMMkR7CHJh+HGn7C/ZAGGS2yPJF37mniQT
	XZs8Vdjby7F+JOuVxnzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbMc-0006tV-21; Wed, 19 Dec 2018 12:54:14 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbMZ-0006sp-C3
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:54:13 +0000
Received: by mail-vs1-xe42.google.com with SMTP id e7so12167730vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jcFIssZ5uCnxarSbhhjy8lOdqNazHu2rLSIxhH6ZZ94=;
 b=P4zdV+V7D+kJ2OqmDWA+6CaNThu6p87cXk7tzR7cPP1nzGV/PgkkxXFWRpE22BGrCz
 kKUh7dMorNC16o3ZrXj/gLY//viyUdiS6zJlPQDjByvZz1QdSiJ5ctp2sTaCVNRZwAov
 +wejvtkYQLzZ9l27zP0bRucJFRuPmU3Fh08s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jcFIssZ5uCnxarSbhhjy8lOdqNazHu2rLSIxhH6ZZ94=;
 b=Yw+sYOmqqWC9PTcKX/ShFME4xyEm0wfYp/XgVmk/8kInxgvzi93LuNFdXR6wSFdyJD
 3cluKvh3WD2fS2F/ASm2F63ZEpUj1BZu7LHUcX11NkvfBX7BKhkV5XAoV7WnHs+EBzxT
 zmADcjS9DhdsLQokGqTu89BiK2Lcp/wWwzC9PcRUVaCsdGMY9C8gqMJU3y4LF7008fg8
 UkA9WC8XcD5EvqSbne/WaJDUNG3amRc5q5FTk9Qsf6y/Hy0Jcx+OPqO/jbI8zOttitE5
 esUE8cd8xs+55JbQhGtnQ0dNRopBsE0bFsgdIVrQ8CpcGLjcr4WamgvT1cDPW/5RL+MC
 eKEQ==
X-Gm-Message-State: AA+aEWanTNqs176cY6M+J17dkJoTjvDB9WFWCEIs5ncmFCCRUvjPVzZj
 zxWHhyqTUnSOXFvjHRLu7q3g+oX4mGGefrX6+WhB/A==
X-Google-Smtp-Source: AFSGD/Wh86tdW772GFuHMHhvw2DdDNpd3ZVUMAJgAka8VlI8rOlkT+Iwc3ty+6s4rvkmgNu0DKQFlrF5x8NX5sJKoZo=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10207107vsh.200.1545224039014; 
 Wed, 19 Dec 2018 04:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org>
 <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
In-Reply-To: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Dec 2018 13:53:23 +0100
Message-ID: <CAPDyKFpa6cCfQtfNo=CN0=BpY6bARfnVWRH0N=apQgVr1m24Og@mail.gmail.com>
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_045411_427097_A2B98F71 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxOSBEZWMgMjAxOCBhdCAxMzoxMSwgRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpj
YW5vQGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4gT24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNz
b24gd3JvdGU6Cj4gPiBGcm9tOiBMaW5hIEl5ZXIgPGxpbmEuaXllckBsaW5hcm8ub3JnPgo+ID4K
PiA+IEN1cnJlbnRseSBDUFUncyBpZGxlIHN0YXRlcyBhcmUgcmVwcmVzZW50ZWQgaW4gYSBmbGF0
dGVuZWQgbW9kZWwsIHZpYSB0aGUKPiA+ICJjcHUtaWRsZS1zdGF0ZXMiIGJpbmRpbmcgZnJvbSB3
aXRoaW4gdGhlIENQVSdzIGRldmljZSBub2Rlcy4KPiA+Cj4gPiBTdXBwb3J0IHRoZSBoaWVyYXJj
aGljYWwgbGF5b3V0LCBzaW1wbHkgYnkgY29udmVydGluZyB0byBjYWxsaW5nIHRoZSBuZXcgT0YK
PiA+IGhlbHBlciwgb2ZfZ2V0X2NwdV9zdGF0ZV9ub2RlKCkuCj4gPgo+ID4gQ2M6IExpbmEgSXll
ciA8aWxpbmFAY29kZWF1cm9yYS5vcmc+Cj4gPiBTdWdnZXN0ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8
c3VkZWVwLmhvbGxhQGFybS5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaW5hIEl5ZXIgPGxpbmEu
aXllckBsaW5hcm8ub3JnPgo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4KPiA+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPgo+ID4gLS0tCj4KPiBGb2xkIGl0IHdpdGggMDcvMjcgPwoKSSBjYW4g
ZG8gdGhhdC4gSG93ZXZlciwgbm9ybWFsbHkgd2UgdHJ5IHRvIGtlZXAgY2hhbmdlcyB0aGF0IHRv
dWNoZXMKZGlmZmVyZW50IHN1YnN5c3RlbXMsIHNlcGFyYXRlIGZyb20gZWFjaCBvdGhlci4gT2Yg
Y291cnNlIHNvbWV0aW1lcwppdCdzIG5vdCBwb3NzaWJsZSBhbmQgc29tZXRpbWVzIGl0IGp1c3Qg
ZG9lc24ndCBtYWtlIHNlbnNlIHRvIHNlcGFyYXRlCmNoYW5nZXMuCgpQZXJoYXBzIHRoZSBQU0NJ
IG1haW50YWluZXJzIGFuZCBSYWZhZWwgY2FuIGdpdmUgdGhlaXIgb3Bpbmlvbi4KCktpbmQgcmVn
YXJkcwpVZmZlCgo+Cj4gPgo+ID4gQ2hhbmdlcyBpbiB2MTA6Cj4gPiAgICAgICAtIE5vbmUuCj4g
Pgo+ID4gLS0tCj4gPiAgZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyB8IDIgKy0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyBiL2RyaXZlcnMvZmlybXdhcmUv
cHNjaS9wc2NpLmMKPiA+IGluZGV4IGNiZmM5MzZkMjUxYy4uNjMxZTIwNzIwYTIyIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYwo+ID4gKysrIGIvZHJpdmVycy9m
aXJtd2FyZS9wc2NpL3BzY2kuYwo+ID4gQEAgLTMwMCw3ICszMDAsNyBAQCBzdGF0aWMgaW50IHBz
Y2lfZHRfY3B1X2luaXRfaWRsZShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwKPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPgo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IG51
bV9zdGF0ZV9ub2RlczsgaSsrKSB7Cj4gPiAtICAgICAgICAgICAgIHN0YXRlX25vZGUgPSBvZl9w
YXJzZV9waGFuZGxlKGNwdV9ub2RlLCAiY3B1LWlkbGUtc3RhdGVzIiwgaSk7Cj4gPiArICAgICAg
ICAgICAgIHN0YXRlX25vZGUgPSBvZl9nZXRfY3B1X3N0YXRlX25vZGUoY3B1X25vZGUsIGkpOwo+
ID4gICAgICAgICAgICAgICBpZiAoIXN0YXRlX25vZGUpCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7Cj4gPgo+ID4KPgo+Cj4gLS0KPiAgPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExp
bmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+Cj4gRm9sbG93
IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29r
IHwKPiA8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8Cj4gPGh0dHA6
Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
