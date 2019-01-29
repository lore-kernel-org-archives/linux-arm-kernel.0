Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF5AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCD72084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jl7Y8WIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCD72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oyDQiOR7z0b5R9HaaPEkw4lMn3eGoazKznLfnwiwScs=; b=jl7Y8WITRlhWOC
	JVjNICl/JqS+dZY5G4FoqjhcADABrpnHgBnMn7ZpTVQZfPU/+oYPRdL0QatSSBOz9E4xFJn8WDX5e
	KTpDzxmIcY7o0BwLaWJocK6p9UVLiaFfR4GcYqnEei5d/+Kw0X1ckjDbzP1F9H+L/fvjqBbM0mWA0
	QLheG/H6WzPlJBX7hXjxvNLjvwUGTaHbricb9PEkpe34d3tmfuCawZ1dnc1gtuidqoMq9tVZuOCV4
	bK5Cfsw7w5B6Y3ekW+wh7IiRniclDEy6w5jWumsCP2Uuv9EIICir7RnPqSQmF3a/AC0wfLDXT/ngo
	fVH9w2SVontt37IxYwLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZSy-00083h-75; Tue, 29 Jan 2019 19:54:40 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZSu-00083J-Dd
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:54:38 +0000
Received: by mail-qt1-f195.google.com with SMTP id r14so23758745qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 11:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=EioVinHT2X6yqjwgWHj6uKTZ7lv2NlLmkKjuJFYrDpk=;
 b=ovW8hKfZtKA1fZZJBuk0a15Ruup9hRAPxlwV+rT96lye36X1Op8HpnqdPtK7wrfhUv
 63+L7voleAa1NXgTg94sijeBBPyU4Y3MXQBgi3lhfznzN/f/ahIoi7v2LH1WA+KlN2/t
 o68CXswRr2EN7fNZyK1xSyq616TAqFg+/UIC33YFd95Np0moTSbdlngyLSNES/OX1ukT
 UN392oxhcAN0ZVqyX73hC+Ptw7hwH5gmHPLNj3/oqnp7xraA/YnKn6bKOYiCc6eYIUFX
 CE88MrmJeGAHiupB9zxEyoGBLs96BmJziBI7kcau5NlO16VFeM9hjgePi9IkjyQQ7qm1
 F7Qw==
X-Gm-Message-State: AJcUukeERBaEacfcavPzRXNkE9BPT9neVtydFyseQCh9bVvrY4KXfTtL
 zKMuNDyXMIjpe+icgmNgq5DFoIqG
X-Google-Smtp-Source: ALg8bN5sTmRmSJKe/pdaO3EBrE0tcG1zl6fJwd5HndR5E3KyLKn0qIrg6Qs3vcLOuvSsjCCFvyC9lQ==
X-Received: by 2002:ac8:270d:: with SMTP id g13mr27836759qtg.168.1548791674554; 
 Tue, 29 Jan 2019 11:54:34 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
 by smtp.gmail.com with ESMTPSA id k62sm66134794qte.86.2019.01.29.11.54.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 11:54:33 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Tue, 29 Jan 2019 17:54:27 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] regulator: rk808: Fix BUCK1/2 voltages on rk805
Date: Tue, 29 Jan 2019 17:54:21 -0200
Message-Id: <20190129195424.10161-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_115436_460298_40468273 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>,
 Otavio Salvador <otavio@ossystems.com.br>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Tony Xie <tony.xie@rock-chips.com>, Vicent Chi <vicent.chi@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Uks4MDUgaGFzIHRoZSBmb2xsb3dpbmcgdm9sdGFnZSByYW5nZSBmb3IgdGhlIEJVQ0sxIGFuZCBC
VUNLMiByZWd1bGF0b3JzOgoKRnJvbSAwLjcxMjVWIHRvIDEuNDVWIGluIDEyLjVtViBzdGVwcywg
MS44ViwgMlYsIDIuMlYgYW5kIDIuM1YKCiwgd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlIGZvbGxv
d2luZyB2YWx1ZXMgYXMgcGVyIHRoZSBSSzgwNQpkYXRhc2hlZXQ6CgowMDAgMDAwOiAwLjcxMjVW
CjAwMCAwMDE6IDAuNzI1VgrigKbigKYKMTExIDAxMTogMS40NVYKMTExIDEwMDogMS44VgoxMTEg
MTAxOiAyLjBWCjExMSAxMTA6IDIuMlYKMTExIDExMTogMi4zVgoKVGhpcyBtZWFucyB0aGF0IHRo
ZSB2b2x0YWdlIHJhbmdlIGlzIG5vdCBsaW5lYXIgYW5kIHNvIFJLODA1IGNhbiBub3QKcmV1c2Ug
dGhlIHNhbWUgcmVndWxhdG9yX29wcyBzdHJ1Y3R1cmUgZnJvbSBSSzgwOC4KCkZpeCBpdCBieSBj
cmVhdGluZyBhIGxpc3Qgd2l0aCB0aGUgY29ycmVjdCBzdXBwb3J0ZWQgdm9sdGFnZSB2YWx1ZXMK
Zm9yIFJLODA1IEJVQ0sxIGFuZCBCVUNLMiByZWd1bGF0b3JzLgoKVGVzdGVkIG9uIGEgcnYxMTA4
LWVsZ2luLXIxIGJvYXJkIHRoYXQgbm93IGNvcnJlY3RseSByZXBvcnRzIGEgQlVDSzIKdm9sdGFn
ZSBvZiAyLjJWIGluc3RlYWQgb2YgdGhlIHVuc3VwcG9ydGVkIHZhbHVlIG9mIDEuNDg3NVYuCgpT
aWduZWQtb2ZmLWJ5OiBPdGF2aW8gU2FsdmFkb3IgPG90YXZpb0Bvc3N5c3RlbXMuY29tLmJyPgot
LS0KCiBkcml2ZXJzL3JlZ3VsYXRvci9yazgwOC1yZWd1bGF0b3IuYyB8IDUzICsrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9yazgwOC1yZWd1bGF0
b3IuYyBiL2RyaXZlcnMvcmVndWxhdG9yL3JrODA4LXJlZ3VsYXRvci5jCmluZGV4IDIxM2I2ODc0
M2NjOC4uMTQ2M2M2NWM4NWRiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9yazgwOC1y
ZWd1bGF0b3IuYworKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9yazgwOC1yZWd1bGF0b3IuYwpAQCAt
Mjg5LDYgKzI4OSwyMSBAQCBzdGF0aWMgaW50IHJrODA4X3NldF9yYW1wX2RlbGF5KHN0cnVjdCBy
ZWd1bGF0b3JfZGV2ICpyZGV2LCBpbnQgcmFtcF9kZWxheSkKIAkJCQkgIFJLODA4X1JBTVBfUkFU
RV9NQVNLLCByYW1wX3ZhbHVlKTsKIH0KIAorc3RhdGljIGludCByazgwNV9zZXRfc3VzcGVuZF92
b2x0YWdlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LCBpbnQgdXYpCit7CisJdW5zaWduZWQg
aW50IHJlZzsKKwlpbnQgc2VsID0gcmVndWxhdG9yX21hcF92b2x0YWdlX2FzY2VuZChyZGV2LCB1
diwgdXYpOworCisJaWYgKHNlbCA8IDApCisJCXJldHVybiAtRUlOVkFMOworCisJcmVnID0gcmRl
di0+ZGVzYy0+dnNlbF9yZWcgKyBSSzgwOF9TTFBfUkVHX09GRlNFVDsKKworCXJldHVybiByZWdt
YXBfdXBkYXRlX2JpdHMocmRldi0+cmVnbWFwLCByZWcsCisJCQkJICByZGV2LT5kZXNjLT52c2Vs
X21hc2ssCisJCQkJICBzZWwpOworfQorCiBzdGF0aWMgaW50IHJrODA4X3NldF9zdXNwZW5kX3Zv
bHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsIGludCB1dikKIHsKIAl1bnNpZ25lZCBp
bnQgcmVnOwpAQCAtMzc2LDYgKzM5MSwxOSBAQCBzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMg
cms4MDVfcmVnX29wcyA9IHsKIAkJLnNldF9zdXNwZW5kX2Rpc2FibGUgICAgPSByazgwNV9zZXRf
c3VzcGVuZF9kaXNhYmxlLAogfTsKIAorc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3BzIHJrODA1
X2J1Y2sxXzJfb3BzID0geworCQkubGlzdF92b2x0YWdlCQk9IHJlZ3VsYXRvcl9saXN0X3ZvbHRh
Z2VfdGFibGUsCisJCS5tYXBfdm9sdGFnZQkJPSByZWd1bGF0b3JfbWFwX3ZvbHRhZ2VfYXNjZW5k
LAorCQkuZ2V0X3ZvbHRhZ2Vfc2VsICAgICAgICA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZV9zZWxf
cmVnbWFwLAorCQkuc2V0X3ZvbHRhZ2Vfc2VsICAgICAgICA9IHJlZ3VsYXRvcl9zZXRfdm9sdGFn
ZV9zZWxfcmVnbWFwLAorCQkuZW5hYmxlICAgICAgICAgICAgICAgICA9IHJlZ3VsYXRvcl9lbmFi
bGVfcmVnbWFwLAorCQkuZGlzYWJsZSAgICAgICAgICAgICAgICA9IHJlZ3VsYXRvcl9kaXNhYmxl
X3JlZ21hcCwKKwkJLmlzX2VuYWJsZWQgICAgICAgICAgICAgPSByZWd1bGF0b3JfaXNfZW5hYmxl
ZF9yZWdtYXAsCisJCS5zZXRfc3VzcGVuZF92b2x0YWdlICAgID0gcms4MDVfc2V0X3N1c3BlbmRf
dm9sdGFnZSwKKwkJLnNldF9zdXNwZW5kX2VuYWJsZSAgICAgPSByazgwNV9zZXRfc3VzcGVuZF9l
bmFibGUsCisJCS5zZXRfc3VzcGVuZF9kaXNhYmxlICAgID0gcms4MDVfc2V0X3N1c3BlbmRfZGlz
YWJsZSwKK307CisKIHN0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX29wcyByazgwNV9zd2l0Y2hfb3Bz
ID0gewogCQkuZW5hYmxlICAgICAgICAgICAgICAgICA9IHJlZ3VsYXRvcl9lbmFibGVfcmVnbWFw
LAogCQkuZGlzYWJsZSAgICAgICAgICAgICAgICA9IHJlZ3VsYXRvcl9kaXNhYmxlX3JlZ21hcCwK
QEAgLTQzMyw2ICs0NjEsMTcgQEAgc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3BzIHJrODA4X3N3
aXRjaF9vcHMgPSB7CiAJLnNldF9zdXNwZW5kX2Rpc2FibGUJPSByazgwOF9zZXRfc3VzcGVuZF9k
aXNhYmxlLAogfTsKIAorc3RhdGljIGNvbnN0IGludCByazgwNV9idWNrXzFfMl92b2x0YWdlc1td
ID0geworCTcxMjUwMCwgNzI1MDAwLCA3Mzc1MDAsIDc1MDAwMCwgNzYyNTAwLCA3NzUwMDAsIDc4
NzUwMCwgODAwMDAwLAorCTgxMjUwMCwgODI1MDAwLCA4Mzc1MDAsIDg1MDAwMCwgODYyNTAwLCA4
NzUwMDAsIDg4NzUwMCwgOTAwMDAwLAorCTkxMjUwMCwgOTI1MDAwLCA5Mzc1MDAsIDk1MDAwMCwg
OTYyNTAwLCA5NzUwMDAsIDk4NzUwMCwgMTAwMDAwMCwKKwkxMDEyNTAwLCAxMDI1MDAwLCAxMDM3
NTAwLCAxMDUwMDAwLCAxMDYyNTAwLCAxMDc1MDAwLCAxMDg3NTAwLCAxMTAwMDAwLAorCTExMTI1
MDAsIDExMjUwMDAsIDExMzc1MDAsIDExNTAwMDAsIDExNjI1MDAsIDExNzUwMDAsIDExODc1MDAs
IDEyMDAwMDAsCisJMTIxMjUwMCwgMTIyNTAwMCwgMTIzNzUwMCwgMTI1MDAwMCwgMTI2MjUwMCwg
MTI3NTAwMCwgMTI4NzUwMCwgMTMwMDAwMCwKKwkxMzEyNTAwLCAxMzI1MDAwLCAxMzM3NTAwLCAx
MzUwMDAwLCAxMzYyNTAwLCAxMzc1MDAwLCAxMzg3NTAwLCAxNDAwMDAwLAorCTE0MTI1MDAsIDE0
MjUwMDAsIDE0Mzc1MDAsIDE0NTAwMDAsIDE4MDAwMDAsIDIwMDAwMDAsIDIyMDAwMDAsIDIzMDAw
MDAsCit9OworCiBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ3VsYXRvcl9kZXNjIHJrODA1X3JlZ1td
ID0gewogCXsKIAkJLm5hbWUgPSAiRENEQ19SRUcxIiwKQEAgLTQ0MCwxMSArNDc5LDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcmVndWxhdG9yX2Rlc2Mgcms4MDVfcmVnW10gPSB7CiAJCS5vZl9t
YXRjaCA9IG9mX21hdGNoX3B0cigiRENEQ19SRUcxIiksCiAJCS5yZWd1bGF0b3JzX25vZGUgPSBv
Zl9tYXRjaF9wdHIoInJlZ3VsYXRvcnMiKSwKIAkJLmlkID0gUks4MDVfSURfRENEQzEsCi0JCS5v
cHMgPSAmcms4MDVfcmVnX29wcywKKwkJLm9wcyA9ICZyazgwNV9idWNrMV8yX29wcywKIAkJLnR5
cGUgPSBSRUdVTEFUT1JfVk9MVEFHRSwKLQkJLm1pbl91ViA9IDcxMjUwMCwKLQkJLnVWX3N0ZXAg
PSAxMjUwMCwKLQkJLm5fdm9sdGFnZXMgPSA2NCwKKwkJLm5fdm9sdGFnZXMgPSBBUlJBWV9TSVpF
KHJrODA1X2J1Y2tfMV8yX3ZvbHRhZ2VzKSwKKwkJLnZvbHRfdGFibGUgPSByazgwNV9idWNrXzFf
Ml92b2x0YWdlcywKIAkJLnZzZWxfcmVnID0gUks4MDVfQlVDSzFfT05fVlNFTF9SRUcsCiAJCS52
c2VsX21hc2sgPSBSSzgxOF9CVUNLX1ZTRUxfTUFTSywKIAkJLmVuYWJsZV9yZWcgPSBSSzgwNV9E
Q0RDX0VOX1JFRywKQEAgLTQ1NiwxMSArNDk0LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVn
dWxhdG9yX2Rlc2Mgcms4MDVfcmVnW10gPSB7CiAJCS5vZl9tYXRjaCA9IG9mX21hdGNoX3B0cigi
RENEQ19SRUcyIiksCiAJCS5yZWd1bGF0b3JzX25vZGUgPSBvZl9tYXRjaF9wdHIoInJlZ3VsYXRv
cnMiKSwKIAkJLmlkID0gUks4MDVfSURfRENEQzIsCi0JCS5vcHMgPSAmcms4MDVfcmVnX29wcywK
KwkJLm9wcyA9ICZyazgwNV9idWNrMV8yX29wcywKIAkJLnR5cGUgPSBSRUdVTEFUT1JfVk9MVEFH
RSwKLQkJLm1pbl91ViA9IDcxMjUwMCwKLQkJLnVWX3N0ZXAgPSAxMjUwMCwKLQkJLm5fdm9sdGFn
ZXMgPSA2NCwKKwkJLm5fdm9sdGFnZXMgPSBBUlJBWV9TSVpFKHJrODA1X2J1Y2tfMV8yX3ZvbHRh
Z2VzKSwKKwkJLnZvbHRfdGFibGUgPSByazgwNV9idWNrXzFfMl92b2x0YWdlcywKIAkJLnZzZWxf
cmVnID0gUks4MDVfQlVDSzJfT05fVlNFTF9SRUcsCiAJCS52c2VsX21hc2sgPSBSSzgxOF9CVUNL
X1ZTRUxfTUFTSywKIAkJLmVuYWJsZV9yZWcgPSBSSzgwNV9EQ0RDX0VOX1JFRywKLS0gCjIuMjAu
MQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
