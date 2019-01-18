Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA37CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:10:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5C520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uBtyPq8a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDrzDLgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5C520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MrVoPiDqrFABIlsytx9z+3ckjIhyYFEt90nvmm/jGis=; b=uBtyPq8anb8qGC
	LDRYqkhMj2BwfqM3QLsRp2Kwl6IoUWZsBSppLfSAn6JTcibzqTxwErkpKebmOJE2RLLcxKZ6MJprJ
	zXYfm70WkQw347e2kynnNMlKkiIoN0MJHvH6NbukrcX8K7zvnT8rNCURNNYBdfuu/MKfuuZzbuH3x
	Fhx+nD581k2H4R437CiU4oeph9/8hht2udo9/if5bXyG09B5Is0czbRkXGHuOOoYTBNs6vIylPIyw
	m3eUsbHoHcQww+8jptZ7xWJPoZYZCZ9QJ7J1YQdKrR/u6hZEWsFdTpESAIRNsIVppHcveOVVgvOo1
	Z1zM6a1b4oDQsSdB0neg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkMQ9-0002ml-2L; Fri, 18 Jan 2019 05:10:21 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkMQ5-0002lx-83
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 05:10:18 +0000
Received: by mail-pf1-x444.google.com with SMTP id w73so5967062pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 21:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=OqwwRYEBTtVEUmI5mtBxmnkd21H2Z+IIwB9uA7XBDXo=;
 b=kDrzDLgyBTGbpwn7c8/OsBkY0PIV11UyxEAW6v2MCY9FNdlDPflF6C/GGfioOmKOvW
 +vtkIR0hi10j+5XCYUskxsuNbpgWCZPKfONwjqOj/GixqTOxYzjjfz8wd+wSgCAIPO4E
 7WnP5/8Ryd+MF9fYLA8gF3eB8tqKEuzSwHylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OqwwRYEBTtVEUmI5mtBxmnkd21H2Z+IIwB9uA7XBDXo=;
 b=ny+UJdhKvDth98J2VW33pp4aRY7bLzk11UrNs7kYIVbsxaFesIqw+qrS65hE2Y3n30
 PQY2K0Ayjw0VFYzQP9Az+1ZZeU4A4yfUbWPWg6r/7yjSiENQ6Ew9rrRrPg2ota51tV2g
 QJbgZiUFiC4GYHKWn2k1s4QNy+xpEzZKGOtmFy0gNOJ3C+IdePGcAnV7m01uzMfOe3vc
 GCkSfW/zsDmHcJLIUBRDrWVxoTs/WWtES4M1HIphuTd6NtP7j1Bk3l+Bd7ai8p6csPtq
 Z7Wak5G+3ZddmXN1Pj955HzAe3F00gOzPlOgwZBVcvyhAKOnOBevp0WzhOxtpcf+4N8e
 /a8w==
X-Gm-Message-State: AJcUukd01w7+ya7ODLf5F5FgKXTVUCMh7on5eFJL2sFbdZNRQonqlIox
 Jel5b2g276lPgDl3KI+HvfXcZxjEz/I=
X-Google-Smtp-Source: ALg8bN7/kaVqB04oJzCi6YbeLKIS9lqCqWDET4+wiSltPBbRCcDIj2GTxtzrDoPPYFEx28z3ciGCww==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr16264319pgj.321.1547788213525; 
 Thu, 17 Jan 2019 21:10:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 15sm6102297pfr.55.2019.01.17.21.10.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 21:10:12 -0800 (PST)
Date: Fri, 18 Jan 2019 10:40:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190118051010.4ed2ntv2mxfeaoot@vireshk-i7>
References: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_211017_289151_ACB7FC4E 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTQtMDEtMTksIDA4OjUxLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgo+IE9uIFN1biwg
MTMgSmFuIDIwMTkgYXQgMjA6NTgsIFBhd2XFgiBDaG1pZWwKPiA8cGF3ZWwubWlrb2xhai5jaG1p
ZWxAZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGVyZSBpcyBwb3NzaWJpbGl0eSwgdGhhdCB3
aGVuIHByb2JpbmcgZHJpdmVyLCByZWd1bGF0b3JzIGFyZSBub3QgeWV0Cj4gPiBpbml0aWFsaXpl
ZC4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4gRVBST0JFX0RFRkVSIGFuZCB3YWl0IHRp
bGwKPiA+IHRoZXkncmUgaW5pdGlhbGl6ZWQsIHNpbmNlIHRoZXkncmUgcmVxdWlyZWQgY3VycmVu
dGx5IGZvciBjcHVmcmVxIGRyaXZlcgo+ID4gdG8gd29yay4gQWxzbyBtb3ZlIHJlZ3VsYXRvciBp
bml0aWFsaXphdGlvbiBjb2RlIGF0IGJlZ2lubmluZyBvZiBwcm9iZSwKPiA+IHNvIHdlIGNhbiBk
ZWZlciBhcyBmYXN0IGFzIHBvc2liYmxlLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBD
aG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gQ2hhbmdl
cyBmcm9tIHYzOgo+ID4gICAtIFplcm8gZG1jX2Jhc2UgcG9pbnRlcnMgYWZ0ZXIgdW5tYXBwaW5n
IHRoZW0KPiA+ICAgLSBJZiBnZXR0aW5nIHZkZGFybSByZWd1bGF0b3IgZmFpbHMganVzdCByZXR1
cm4sIG5vIG5lZWQgdG8gZG8gZ290bwo+ID4gICAgIGp1bXAgd2hpY2ggd291bGQgZG8gdGhlIHNh
bWUKPiA+Cj4gPiBDaGFuZ2VzIGZyb20gdjI6Cj4gPiAgIC0gSGFuZGxlIGFsbCBlcnJvciBwYXRo
cyBpbiBwcm9iZQo+ID4KPiA+IENoYW5nZXMgZnJvbSB2MToKPiA+ICAgLSBGaXggY29tcGlsYXRp
b24gZXJyb3IKPiA+ICAgLSBSZW9yZ2FuaXplIGNvZGUgc28gaXQncyBzbWFsbGVyCj4gCj4gUmV2
aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4KCkFwcGxpZWQs
IHRoYW5rcy4KCi0tIAp2aXJlc2gKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
