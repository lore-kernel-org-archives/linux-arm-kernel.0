Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B7C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0C3218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bF1ntePu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5bIBUI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0C3218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iO1qUYq3DDywu8sHTA9qjOG1JQKGV7LRk6DUVSjGvVc=; b=bF1ntePu6oC3D8
	vC3Vky2zbrVuxyImd2puRPXJreBVkK9W482u67Wed98ipdiG9aV57Rn5spiu+tWVaDEe6UJstOu45
	/TahzJgqWzZkk9ETVwI6/es6KAbqE7fR5c/DHmYKJJhuMiKlCaGSSox19fV2c0KdGrxGivwN39Yv+
	rhr/OgCIdlXnHZSwlDsDASyAqJMBvFifBYAIUqfaLYasjSVZN/o8kMTkC/C1rVxB+O6MD5wsvjotf
	T6uEUxvNWjGttpKqfr5nYcTympBGMWU3XEKv5ZIlKJb3Sf51gt4sKEy5AyvCMIAfMsPW23KUQQFul
	iHUCY7GQAr0TfQumT45w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWee-0001KG-3k; Mon, 18 Feb 2019 00:19:28 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWeW-0001AS-VV
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:19:23 +0000
Received: by mail-pg1-x543.google.com with SMTP id q206so7527850pgq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KbRr2RYMR54b7AhSan9xsBEduDl7IIBORSvu485az7g=;
 b=k5bIBUI5CFOxVPWatAXvBfSEsDsHuEBJNQEx2EXO53ONtwXca5aNp0R6O3lnwRrknC
 87o7BFl8F89mybGy7xdYmdVuLJm/G6NgL1Sm/qL2lwZRNv6peuZ42pdMTBcxE7E6U44S
 XP5vIkRqVYH0eXy3Eagp97c9ZQScYdw9iaFrExKu00llQWisNimIlFxPV45qlILovM/V
 Y5/DRAlvMRMQS34ha//lHWpRsAZshvx0PSLa3kisSyuSthB8rOAol4gGyXRYxTw5pT0f
 Ng+FK1t1RvnffCy3AqE6nMc//YLZJleIL9gjlaJXvPNq1d2o3im7VJ4mgCg+nzKYszTG
 4b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KbRr2RYMR54b7AhSan9xsBEduDl7IIBORSvu485az7g=;
 b=eBGd7kBMD7CAoGROQ4sQ8rZ3TqGG1NcNtNucd5d54605GxKdm8U1ceeje6VqErxgkt
 J4ogF5zXyAdQdQUC1hAie3mM0e0FOezskVp160Ls03XIU0FsRp4o7PjUZt79ljXHV2tT
 LXr+WoXnSz74Jl+KL/c5VsKu0GZOpG7vAbP8rxKxa37XYQzkukiNgjeGfvYnYSJ//Q9p
 pD+9WAi5OmcIQ5XIrefxAKP1ZAiTOF83vemTkhGkGFZdl+da8WT/F5NgmiG80sFKVZkw
 +3OECawJVt3ApftJNY3UJH/xawb47l3N0aZrJjecmG+SFPrVTWxeFvAZ9VF8tIhwc2CC
 aqaw==
X-Gm-Message-State: AHQUAuYBZgFL2iSmWbCVi1EOPFnJnF2y+hQ/qlKJlo7auIF/P4AVW9KK
 62vBdZvZlK7tEhmLVySl7wI=
X-Google-Smtp-Source: AHgI3IZjeEEDkocnHoB3ynLb3cTG5WtWPet77NkvY7hg3MhJUltqkvEt+kKOQI6amQQRIozvQWGmcg==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr22353524pfh.228.1550449159620; 
 Sun, 17 Feb 2019 16:19:19 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:18 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
Date: Mon, 18 Feb 2019 03:17:18 +0300
Message-Id: <20190218001726.16785-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161921_507689_F8E9BF65 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFRydXN0ZWQgRm91bmRh
dGlvbnMgZmlybXdhcmUgb24KTlZJRElBIFRlZ3JhMzAuIFByZXR0eSBtdWNoIGFsbCBvZiBUZWdy
YTMwIGNvbnN1bWVyIGRldmljZXMgaGF2ZSB0aGF0CmZpcm13YXJlIGFuZCB1cHN0cmVhbSBrZXJu
ZWwgY2FuJ3QgYm9vdCBvbiB0aG9zZSBkZXZpY2VzIHdpdGhvdXQgdGhlCmZpcm13YXJlIHN1cHBv
cnQuCgpDaGFuZ2Vsb2c6Cgp2NDogICAgIC0gRml4ZWQgVGh1bWIyLWtlcm5lbCBoYW5naW5nIG9u
IFRlZ3JhMjAsIHR1cm5lZCBvdXQgaXQgd2FzIG5vdCBhCiAgICAgICAgICBnb29kIGlkZWEgdG8g
c3dpdGNoIENQVSBpbnRvIFRodW1iMiBtb2RlIHJpZ2h0IGFmdGVyIGp1bXBpbmcgaW50bwogICAg
ICAgICAgdGhlIHJlc2V0IGhhbmRsZXIuCgogICAgICAgIC0gTW92ZWQgTFAyLW1vZGUtc2V0IGZp
cm13YXJlIGNhbGwgaW52b2NhdGlvbiB0byBhIGxhdGVyIHN0YWdlIHRvCiAgICAgICAgICBiZXR0
ZXIgcmVwbGljYXRlIHdoYXQgZG93bnN0cmVhbSBrZXJuZWwgZG9lcy4gVGhpcyBjaGFuZ2Ugd2Fz
CiAgICAgICAgICBzdWdnZXN0ZWQgYnkgUm9iZXJ0IFlhbmcgYW5kIGZpeGVzIHN5c3RlbSBoYW5n
IG9uIE91eWEgZ2FtZQogICAgICAgICAgY29uc29sZS4KCiAgICAgICAgLSBBZGRlZCByZWZlcmVu
Y2VzIHRvIHRoZSBvcmlnaW5hbCB3b3JrIG1hZGUgYnkgTWljaGHFgiBNaXJvc8WCYXcKICAgICAg
ICAgIGludG8gY29tbWl0IG1lc3NhZ2VzIG9mIHRoZSByZWxldmFudCBwYXRjaGVzLgoKdjM6ICAg
ICAtIEltcGxlbWVudGVkIHN1c3BlbmQtcmVzdW1lIHN1cHBvcnQuCgogICAgICAgIC0gUmV3b3Jr
ZWQgYXJtL2Zpcm13YXJlL3RydXN0ZWRfZm91bmRhdGlvbnMuYyBhIHRhZC4gTm93IGNhY2hlCiAg
ICAgICAgICBpcyBnZXR0aW5nIHByb3Blcmx5IGluaXRpYWxpemVkLCBjYWNoZSBlbmFibGluZyAv
IGRpc2FibGluZyBpcwogICAgICAgICAgc3VwcG9ydGVkLgoKdjI6CiAgICAgICAgLSBUaGUgIkRv
bid0IGFwcGx5IENQVSBlcnJhdGFzIGluIGluc2VjdXJlIG1vZGUiIHBhdGNoIGdvdCBzb21lCiAg
ICAgICAgICBjbGVhbnVwLCBpbiBwYXJ0aWN1bGFyIHJlc29sdmVkIHRoZSBtZXNzaW5lc3MgaW4K
ICAgICAgICAgIF9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfZGF0YS4KCiAgICAgICAgLSBBZGRl
ZCBhIGNvbW1lbnQgdG8gdGZfY2FjaGVfd3JpdGVfc2VjKCksIGp1c3RpZnlpbmcgdGhlIHdhcm5p
bmcKICAgICAgICAgIG1lc3NhZ2UuCgpEbWl0cnkgT3NpcGVua28gKDgpOgogIEFSTTogdHJ1c3Rl
ZF9mb3VuZGF0aW9uczogSW1wbGVtZW50IEwyIGNhY2hlIGluaXRpYWxpemF0aW9uIGNhbGxiYWNr
CiAgQVJNOiB0cnVzdGVkX2ZvdW5kYXRpb25zOiBNYWtlIHByZXBhcmVfaWRsZSBjYWxsIHRvIHRh
a2UgbW9kZSBhcmd1bWVudAogIEFSTTogdHJ1c3RlZF9mb3VuZGF0aW9uczogUHJvdmlkZSBpbmZv
cm1hdGlvbiBhYm91dCB3aGV0aGVyIGZpcm13YXJlCiAgICBpcyByZWdpc3RlcmVkCiAgQVJNOiB0
ZWdyYTogU2V0IHVwIEwyIGNhY2hlIHVzaW5nIFRydXN0ZWQgRm91bmRhdGlvbnMgZmlybXdhcmUK
ICBBUk06IHRlZ3JhOiBEb24ndCBhcHBseSBDUFUgZXJyYXRhcyBpbiBpbnNlY3VyZSBtb2RlCiAg
QVJNOiB0ZWdyYTogQWx3YXlzIGJvb3QgQ1BVIGluIEFSTS1tb2RlCiAgQVJNOiB0ZWdyYTogU3Vw
cG9ydCBMMiBjYWNoZSBtYWludGVuYW5jZSBkb25lIHZpYSBmaXJtd2FyZQogIEFSTTogdGVncmE6
IEFkZCBmaXJtd2FyZSBjYWxscyByZXF1aXJlZCBmb3Igc3VzcGVuZC1yZXN1bWUKCiBhcmNoL2Fy
bS9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmMgICAgfCA4MCArKysrKysrKysrKysrKysr
KysrKystCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9maXJtd2FyZS5oICAgICAgICAgICAgfCAgMiAr
LQogYXJjaC9hcm0vaW5jbHVkZS9hc20vdHJ1c3RlZF9mb3VuZGF0aW9ucy5oIHwgMTMgKysrKwog
YXJjaC9hcm0vbWFjaC10ZWdyYS9jcHVpZGxlLXRlZ3JhMTE0LmMgICAgIHwgIDMgKy0KIGFyY2gv
YXJtL21hY2gtdGVncmEvcG0uYyAgICAgICAgICAgICAgICAgICB8IDUwICsrKysrKysrKysrKysr
CiBhcmNoL2FybS9tYWNoLXRlZ3JhL3Jlc2V0LWhhbmRsZXIuUyAgICAgICAgfCA1MiArKysrKysr
KysrLS0tLQogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5jICAgICAgICAgICAgICAgIHwgIDMg
KwogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5oICAgICAgICAgICAgICAgIHwgIDkgKystCiBh
cmNoL2FybS9tYWNoLXRlZ3JhL3NsZWVwLXRlZ3JhMjAuUyAgICAgICAgfCAgNCArKwogYXJjaC9h
cm0vbWFjaC10ZWdyYS9zbGVlcC5TICAgICAgICAgICAgICAgIHwgMTEgKy0tCiBhcmNoL2FybS9t
YWNoLXRlZ3JhL3RlZ3JhLmMgICAgICAgICAgICAgICAgfCAxMCArKysKIDExIGZpbGVzIGNoYW5n
ZWQsIDIxNCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCi0tIAoyLjIwLjEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
