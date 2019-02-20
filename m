Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E71C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88D72147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOiWLzGN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="k8b/b1t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88D72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ufOalnpbb0jYWqeVc6JYIWrKeDWUrNm6zJP2My5BBFw=; b=UOiWLzGNkkwKF/
	JQL8D3GETFHWj9JjK801kErCHsl+ySnSVvFEZE0d9nI13oQBjYS4/D2qeJRcjgYxfMKAa/me/3qm8
	l3iMuKbrbd/AwSTjSzgyFWvToublir6HEuNH0CHvGogJJRiB/KXE4fF+V3UG6y3p8WIbdHh77hSb5
	axAsrrOlyjdnhyN991eeIjilauAB3oN0cx2XKWqfy4lDeEWZw2Ag7wmV0XdbytinQcPO84E2BryBH
	ZFnxHk9tkLrWzMgKbHv+rSFOqbOriRFdWejW/Y/6SOtCe6KhxfoNE7727QOA54kiPVLzPkJK8WZQH
	CIQfVmjgMsNPllKC2OfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUrF-0007eH-IA; Wed, 20 Feb 2019 16:36:29 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUrB-0007d2-OY
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:36:27 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 444NVy31Pgz7y;
 Wed, 20 Feb 2019 17:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1550680508; bh=mArx3lQNxcAMVi6yx7LwatL78DeNE70aWYwFI/YEqmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k8b/b1t05Ri+PAk+ytVgKwgSoxtqzWLxd3xZ9dJoTMURUXEbSbCo0/hzzfruj2ck8
 YvtpHUAQnOkMxFIB8iSBnWPZ8PUCJzUj7XfYgiWUd7BdjBAkI+Z5KAyU4I6Zzb4Mmr
 4hBUnl+YeWvLKQ9a44mjO5YfwR5q6DEGi1RZLUJTyASYSfXuHsof/C337MGRh8i4PX
 ZUpTlxl1rIwgjjfVBBtQK78Sis1n2vvYg2Vay/zxrZd/3DjY1XhEOl5//j6TQ+T99l
 o5qbBhXqVkb0wqQvRvHf/ukuRb3oZRzKjKebGm2FwEr4lFJcaQgU3Rbsl3/RCf606T
 6W6OAqQIialWg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Wed, 20 Feb 2019 17:36:14 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190220163614.GA11116@qmqm.qmqm.pl>
References: <20190218001726.16785-1-digetx@gmail.com>
 <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_083625_961997_2FED9E83 
X-CRM114-Status: UNSURE (   8.92  )
X-CRM114-Notice: Please train this message.
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
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Robert Yang <decatf@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMjAsIDIwMTkgYXQgMDQ6MzA6MjBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE4LjAyLjIwMTkgMzoxNywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4g
PiBIZWxsbywKPiA+IAo+ID4gVGhpcyBwYXRjaHNldCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBUcnVz
dGVkIEZvdW5kYXRpb25zIGZpcm13YXJlIG9uCj4gPiBOVklESUEgVGVncmEzMC4gUHJldHR5IG11
Y2ggYWxsIG9mIFRlZ3JhMzAgY29uc3VtZXIgZGV2aWNlcyBoYXZlIHRoYXQKPiA+IGZpcm13YXJl
IGFuZCB1cHN0cmVhbSBrZXJuZWwgY2FuJ3QgYm9vdCBvbiB0aG9zZSBkZXZpY2VzIHdpdGhvdXQg
dGhlCj4gPiBmaXJtd2FyZSBzdXBwb3J0Lgo+IAo+IEhlbGxvIE1pY2hhxYIsCj4gCj4gV2lsbCBi
ZSBhd2Vzb21lIGlmIHlvdSBjb3VsZCB0ZXN0IHRoZSBzZXJpZXMgb24geW91cnMgVEYzMDBUIGFu
ZCByZXBvcnQgYmFjaywgdGhhbmtzIGluIGFkdmFuY2UhCgpJIHRoaW5rIEkgd2lsbCBiZSBhYmxl
IHRvIGxvb2sgaW50byB0aGlzIGR1cmluZyB0aGUgd2Vla2VuZC4gV2hpY2gKa2VybmVsIHRyZWUg
ZG8geW91IHN1Z2dlc3QgYXMgYmFzZT8KCkJlc3QgUmVnYXJkcywKTWljaGHFgsKgTWlyb3PFgmF3
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
