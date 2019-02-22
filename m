Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F37EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6B720700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P3nEWXCz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT16gM5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6B720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WmL4cJ0gQLQY7vGKBvvIgV51+XLtCMiL7UM0XklR1Tw=; b=P3nEWXCzP44mK8
	tdipV0+s1h5M51cMw2jRSlAruLw+s3N4m7N85YGHNXkFvEN2rEKbg5qXQMDzuDbRpCaDu887+4PST
	mb0HvCJ0KlmAQmPiQLbgjLi+lZKU8gXzT7MCBRNjMRrEhfGC9kLL7UqanfUPyKid/iIHXdUqZSEfG
	A1lCrZdTt/12RQI3WBVs0XKdUZltpwt7zIGc2BzcemMcMieLqNVIdkts4Fq7uT+pDG7WxH0DP3kec
	/rPNNpFDdoJ5K2ttg+FEj8OpU9BGJWFFcV5pgck4dtQ2RnjzRoEL4e1Upl2SCJtbILRuSbvA6NIJF
	y8Hpa3to/qqSpdWIea+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGbe-0003Mb-3f; Fri, 22 Feb 2019 19:35:34 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGba-0003M4-Sq
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:35:32 +0000
Received: by mail-pf1-x441.google.com with SMTP id q17so1533300pfh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kQL1EEwK6NnKOtdqQG3M+wi9O2P4+a93b/SQspi5YpM=;
 b=vT16gM5ZTxafYJKSY/CZLt9eDn/xKofhq9tFBjdOdBmOFMldCGELC551mfl64cIPIK
 AeOcAGDVWLHbh8rp4kuxI9i/aGpn4NtTgWOvHA+/Kwbun7f6sdbiMqL5oOHkh7Cn2wMZ
 r/dmhxykwAlqLpa2MYfSPnSpoR3VnX1i/HTeaf/49P8MkJyhCGdYb/fkY8yfIetbwtRQ
 6/XnJ1KGaOmOSImLOfIBCZCDFYmZAhkmeS76Ngjm4wTAwSbpsP79ONvsApJkHaJnUUjB
 5FFluIOg3noIgJmmuBbjZnwanibpwa7YhIoOOYS7ia3kx+nX0y6CJJRzp4xh84mhv4XR
 oByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kQL1EEwK6NnKOtdqQG3M+wi9O2P4+a93b/SQspi5YpM=;
 b=LbFpecs1qz44Ph06hZwGiWJXqpH6P+Zw+fK4vmEb7LJDON8XbQcYfD/Rr8wvTjta94
 VvC/NKcjnaHNevR4VMMwwQ6RiiIgWP2yko/5z421/9ABR2cOeW/kIQ59d1T9H3zPfA4z
 5Dw8XonZjOZnG/Ts42g9cNCYY2+QwNkRzX0HFAOnrquXgPIABCzM6xlr1owOo5X4NvJZ
 DgfFqD5V7JICrJP4QinsAz8XGHYuitZv62HzlOdaw+hVWxX0BwRs4LrvVTsCN0K/ins0
 rwlypiZbNAaXiM/ETSqsRSlirXFkRzdfw3xF+zRWZltbqN5/LHWAOw41irosgF3mvJQ9
 O5Ww==
X-Gm-Message-State: AHQUAub5NGA2dVoY8Hq281HvakOa6W5x298ithF84phk7mNdLlP9f5pD
 91at00uPitgRu+kVAbTSQIA=
X-Google-Smtp-Source: AHgI3IZk1RyZfWQsi57vD/JQ+++CuTk7M8IdMsDCyG7m7fXk7Z4QFTqvrTr09JY1LNM7ATZ+jrjStA==
X-Received: by 2002:aa7:9090:: with SMTP id i16mr5683573pfa.85.1550864129743; 
 Fri, 22 Feb 2019 11:35:29 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:35:29 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Date: Fri, 22 Feb 2019 22:34:19 +0300
Message-Id: <20190222193426.10747-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113530_988544_C5147281 
X-CRM114-Status: GOOD (  15.12  )
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
cnQuCgpDaGFuZ2Vsb2c6Cgp2NjogICAgIC0gT25lIHBhdGNoIGdvdCBtZXNzZWQgdXAgYWNjaWRl
bnRhbGx5IGluIHY1LCB0aGlzIGlzIGZpeGVkIG5vdy4KCiAgICAgICAgLSBTcXVhc2hlZCAiU3Vw
cG9ydCBMMiBjYWNoZSBtYWludGVuYW5jZSBkb25lIHZpYSBmaXJtd2FyZSIgcGF0Y2gKICAgICAg
ICAgIGludG8gdGhlICJBZGQgZmlybXdhcmUgY2FsbHMuLi4iIHBhdGNoLgoKICAgICAgICAtIFRo
ZSBsMngwX2luaXQoKSBmaXJtd2FyZSBjYWxsYmFjayBpcyBub3cgaW52b2tlZCB1bmNvbmRpdGlv
bmFsbHkKICAgICAgICAgIGJlY2F1c2UgaXQgaXMgYWx3YXlzIGEgTk8tT1Agb24gVDExNCsgYW5k
IGlzIGEgTk8tT1Agb24gVDIwLzMwCiAgICAgICAgICBpZiBmaXJtd2FyZSBub2RlIGlzIG1pc3Nl
ZCBpbiBkZXZpY2UtdHJlZSwgaGVuY2UgdGhlcmUgaXMgbm8KICAgICAgICAgIG5lZWQgdG8gY2hl
Y2sgdGhlIG1hY2hpbmUncyBEVCBjb21wYXRpYmxlIGFzIGl0IHdhcyBkb25lIGluIHRoZQogICAg
ICAgICAgcHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIHNlcmllcy4KCnY1OiAgICAgLSBGaXhlZCBt
YWNoaW5lIGhhbmdpbmcgb24gZGlzYWJsaW5nIEQtY2FjaGUgZHVyaW5nIHN1c3BlbmQsCiAgICAg
ICAgICB0dXJuZWQgb3V0IHRoZXJlIGFyZSBzbGlnaHQgdmFyaWF0aW9ucyBpbiBiZWhhdmlvdXIg
YmV0d2VlbgogICAgICAgICAgZmlybXdhcmUgdmVyc2lvbiBpbiByZWdhcmRzIHRvIGNhY2hlLW1h
bmFnZW1lbnQuIFRoYW5rcyB0bwogICAgICAgICAgUm9iZXJ0IFlhbmcgZm9yIHJlcG9ydGluZyB0
aGUgcHJvYmxlbSBhbmQgaGVscGluZyB3aXRoIHRoZQogICAgICAgICAgc29sdXRpb24uCgp2NDog
ICAgIC0gRml4ZWQgVGh1bWIyLWtlcm5lbCBoYW5naW5nIG9uIFRlZ3JhMjAsIHR1cm5lZCBvdXQg
aXQgd2FzIG5vdCBhCiAgICAgICAgICBnb29kIGlkZWEgdG8gc3dpdGNoIENQVSBpbnRvIFRodW1i
MiBtb2RlIHJpZ2h0IGFmdGVyIGp1bXBpbmcgaW50bwogICAgICAgICAgdGhlIHJlc2V0IGhhbmRs
ZXIuCgogICAgICAgIC0gTW92ZWQgTFAyLW1vZGUtc2V0IGZpcm13YXJlIGNhbGwgaW52b2NhdGlv
biB0byBhIGxhdGVyIHN0YWdlIHRvCiAgICAgICAgICBiZXR0ZXIgcmVwbGljYXRlIHdoYXQgZG93
bnN0cmVhbSBrZXJuZWwgZG9lcy4gVGhpcyBjaGFuZ2Ugd2FzCiAgICAgICAgICBzdWdnZXN0ZWQg
YnkgUm9iZXJ0IFlhbmcgYW5kIGZpeGVzIHN5c3RlbSBoYW5nIG9uIE91eWEgZ2FtZQogICAgICAg
ICAgY29uc29sZS4KCiAgICAgICAgLSBBZGRlZCByZWZlcmVuY2VzIHRvIHRoZSBvcmlnaW5hbCB3
b3JrIG1hZGUgYnkgTWljaGHFgiBNaXJvc8WCYXcKICAgICAgICAgIGludG8gY29tbWl0IG1lc3Nh
Z2VzIG9mIHRoZSByZWxldmFudCBwYXRjaGVzLgoKdjM6ICAgICAtIEltcGxlbWVudGVkIHN1c3Bl
bmQtcmVzdW1lIHN1cHBvcnQuCgogICAgICAgIC0gUmV3b3JrZWQgYXJtL2Zpcm13YXJlL3RydXN0
ZWRfZm91bmRhdGlvbnMuYyBhIHRhZC4gTm93IGNhY2hlCiAgICAgICAgICBpcyBnZXR0aW5nIHBy
b3Blcmx5IGluaXRpYWxpemVkLCBjYWNoZSBlbmFibGluZyAvIGRpc2FibGluZyBpcwogICAgICAg
ICAgc3VwcG9ydGVkLgoKdjI6CiAgICAgICAgLSBUaGUgIkRvbid0IGFwcGx5IENQVSBlcnJhdGFz
IGluIGluc2VjdXJlIG1vZGUiIHBhdGNoIGdvdCBzb21lCiAgICAgICAgICBjbGVhbnVwLCBpbiBw
YXJ0aWN1bGFyIHJlc29sdmVkIHRoZSBtZXNzaW5lc3MgaW4KICAgICAgICAgIF9fdGVncmFfY3B1
X3Jlc2V0X2hhbmRsZXJfZGF0YS4KCiAgICAgICAgLSBBZGRlZCBhIGNvbW1lbnQgdG8gdGZfY2Fj
aGVfd3JpdGVfc2VjKCksIGp1c3RpZnlpbmcgdGhlIHdhcm5pbmcKICAgICAgICAgIG1lc3NhZ2Uu
CgpEbWl0cnkgT3NpcGVua28gKDcpOgogIEFSTTogdHJ1c3RlZF9mb3VuZGF0aW9uczogSW1wbGVt
ZW50IEwyIGNhY2hlIGluaXRpYWxpemF0aW9uIGNhbGxiYWNrCiAgQVJNOiB0cnVzdGVkX2ZvdW5k
YXRpb25zOiBNYWtlIHByZXBhcmVfaWRsZSBjYWxsIHRvIHRha2UgbW9kZSBhcmd1bWVudAogIEFS
TTogdHJ1c3RlZF9mb3VuZGF0aW9uczogUHJvdmlkZSBpbmZvcm1hdGlvbiBhYm91dCB3aGV0aGVy
IGZpcm13YXJlCiAgICBpcyByZWdpc3RlcmVkCiAgQVJNOiB0ZWdyYTogU2V0IHVwIEwyIGNhY2hl
IHVzaW5nIFRydXN0ZWQgRm91bmRhdGlvbnMgZmlybXdhcmUKICBBUk06IHRlZ3JhOiBEb24ndCBh
cHBseSBDUFUgZXJyYXRhcyBpbiBpbnNlY3VyZSBtb2RlCiAgQVJNOiB0ZWdyYTogQWx3YXlzIGJv
b3QgQ1BVIGluIEFSTS1tb2RlCiAgQVJNOiB0ZWdyYTogQWRkIGZpcm13YXJlIGNhbGxzIHJlcXVp
cmVkIGZvciBzdXNwZW5kLXJlc3VtZSBvbiBUZWdyYTMwCgogYXJjaC9hcm0vZmlybXdhcmUvdHJ1
c3RlZF9mb3VuZGF0aW9ucy5jICAgIHwgODAgKysrKysrKysrKysrKysrKysrKysrLQogYXJjaC9h
cm0vaW5jbHVkZS9hc20vZmlybXdhcmUuaCAgICAgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJtL2lu
Y2x1ZGUvYXNtL3RydXN0ZWRfZm91bmRhdGlvbnMuaCB8IDEzICsrKysKIGFyY2gvYXJtL21hY2gt
dGVncmEvY3B1aWRsZS10ZWdyYTExNC5jICAgICB8ICAzICstCiBhcmNoL2FybS9tYWNoLXRlZ3Jh
L3BtLmMgICAgICAgICAgICAgICAgICAgfCA0OSArKysrKysrKysrKysrCiBhcmNoL2FybS9tYWNo
LXRlZ3JhL3Jlc2V0LWhhbmRsZXIuUyAgICAgICAgfCA1MCArKysrKysrKysrKy0tLQogYXJjaC9h
cm0vbWFjaC10ZWdyYS9yZXNldC5jICAgICAgICAgICAgICAgIHwgIDMgKwogYXJjaC9hcm0vbWFj
aC10ZWdyYS9yZXNldC5oICAgICAgICAgICAgICAgIHwgIDkgKystCiBhcmNoL2FybS9tYWNoLXRl
Z3JhL3NsZWVwLXRlZ3JhMjAuUyAgICAgICAgfCAgNCArKwogYXJjaC9hcm0vbWFjaC10ZWdyYS9z
bGVlcC5TICAgICAgICAgICAgICAgIHwgMTQgKystLQogYXJjaC9hcm0vbWFjaC10ZWdyYS90ZWdy
YS5jICAgICAgICAgICAgICAgIHwgIDIgKwogMTEgZmlsZXMgY2hhbmdlZCwgMjA3IGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQoKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
