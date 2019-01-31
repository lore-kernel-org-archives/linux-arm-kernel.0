Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1020C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B87218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nntoVQTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B87218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HZjGCp3q+D5meOVd72V7Vd5dfAbhY/HO3lKS3RjF9zE=; b=nntoVQTeO+dnGi
	CQj+2ueBzpL9OpWEHwc6O/VU17MXig0ug2Zs0LQzd8VLHf6FClIv6Rh8OAC9wXflIDEer5HCkSSFP
	jTEATTs/BtvYZ+3eeM5eKibieJyS/vMr/iBmNbIYPuqYD6Pz7SK16crYvDf4lZpVxIHlGTy9V5xvg
	6KT5AeC6hpAgGgxUnUPLLrm8zofeS5W301Mt+Ino2v0VrQGOSbjElZ15WJSXw3n36nnCzJLDkHz8c
	4JLPK1Npm9mltew/pXGgRMQqRAPTKQQmPL6k4P30VUl6llPZtUkvgb37cC8V+oGKI1xIeUaTxZhTo
	GGaAhNfx8cRCsmN/Bwag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBje-0004xl-Pl; Thu, 31 Jan 2019 12:46:26 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBja-0004vx-Q2
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:46:24 +0000
Received: by mail-qt1-f194.google.com with SMTP id l12so3231188qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=L8eYQ5hhgefqEk+G7G/K6cViDNiGVYa5I3lqc3l2fKo=;
 b=g3tIFnCLtXWvUkUjgGwRfQTP0VyjxvAgt2PRUG3YXrAskwjPYBJU3oUyYaWKaLqA7r
 gkggXSmLu/ePF8azA0HYXVrJ6egKm3VqOFOyxHJc+VVOlo3JJzvSvE6a77vV61i6k3jH
 j5LkhSmVUB/9Wt7nG+x5n1Pukz+olaOoYhu4Jnx/eMByVX6dyeUmZs2yBgxVHSjSTD67
 XVM3Cs8Ekt76ZVUX24Y2iFD5WiDOTar9B4T1ZrGopG9+M7/bYKUaryHjvF/JZHiN9OaC
 RTS3TQeoDJA7mGjkowuLlL4g839PzQNZA8Ytd7689jvKxia522No6y1vaJaB8riWJByo
 YFWw==
X-Gm-Message-State: AJcUukeLDZLa9gNGOw7/Grq5uB76kN88pD8rMUeSTVjcyCULyVJYXsYT
 UJgmJ6AAFCDXxXFiYKhqNxZBnRyn
X-Google-Smtp-Source: ALg8bN64WFSjsq/qY2vOIzrG4Stxph0C1vhkZYuvk4OnOyBhpDKh35j0iww5bxmf7GXtvWhXo39vGw==
X-Received: by 2002:aed:2217:: with SMTP id n23mr32811022qtc.288.1548938780741; 
 Thu, 31 Jan 2019 04:46:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
 by smtp.gmail.com with ESMTPSA id m68sm4045377qte.49.2019.01.31.04.46.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 04:46:19 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 31 Jan 2019 10:46:13 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] regulator: rk808: Fix BUCK1/2 voltages on rk805
Date: Thu, 31 Jan 2019 10:46:01 -0200
Message-Id: <20190131124601.29763-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_044622_855262_320E2E32 
X-CRM114-Status: GOOD (  15.32  )
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
ZSBvZiAyLjJWIGluc3RlYWQgb2YgdGhlIHVuc3VwcG9ydGVkIHZhbHVlIG9mIDEuNDg3NVYuCgpG
aXhlczogYzRlMGQzNDRjMWYwICgicmVndWxhdG9yOiByazgwODogQWRkIHJlZ3VsYXRvciBkcml2
ZXIgZm9yIFJLODA1IikKU2lnbmVkLW9mZi1ieTogT3RhdmlvIFNhbHZhZG9yIDxvdGF2aW9Ab3Nz
eXN0ZW1zLmNvbS5icj4KLS0tCgpDaGFuZ2VzIGluIHYyOgotIGFkZCBmaXhlcyB0YWcKLSByZWJh
c2Ugb24gdG9wIG9mIGxpbnV4LW5leHQKCiBkcml2ZXJzL3JlZ3VsYXRvci9yazgwOC1yZWd1bGF0
b3IuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NDUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Jl
Z3VsYXRvci9yazgwOC1yZWd1bGF0b3IuYyBiL2RyaXZlcnMvcmVndWxhdG9yL3JrODA4LXJlZ3Vs
YXRvci5jCmluZGV4IDA4NTc4ZjZkNzM3ZC4uNzllNzljZGQ1MDNiIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3JlZ3VsYXRvci9yazgwOC1yZWd1bGF0b3IuYworKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9y
azgwOC1yZWd1bGF0b3IuYwpAQCAtMjg5LDYgKzI4OSwyMSBAQCBzdGF0aWMgaW50IHJrODA4X3Nl
dF9yYW1wX2RlbGF5KHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LCBpbnQgcmFtcF9kZWxheSkK
IAkJCQkgIFJLODA4X1JBTVBfUkFURV9NQVNLLCByYW1wX3ZhbHVlKTsKIH0KIAorc3RhdGljIGlu
dCByazgwNV9zZXRfc3VzcGVuZF92b2x0YWdlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LCBp
bnQgdXYpCit7CisJdW5zaWduZWQgaW50IHJlZzsKKwlpbnQgc2VsID0gcmVndWxhdG9yX21hcF92
b2x0YWdlX2FzY2VuZChyZGV2LCB1diwgdXYpOworCisJaWYgKHNlbCA8IDApCisJCXJldHVybiAt
RUlOVkFMOworCisJcmVnID0gcmRldi0+ZGVzYy0+dnNlbF9yZWcgKyBSSzgwOF9TTFBfUkVHX09G
RlNFVDsKKworCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMocmRldi0+cmVnbWFwLCByZWcsCisJ
CQkJICByZGV2LT5kZXNjLT52c2VsX21hc2ssCisJCQkJICBzZWwpOworfQorCiBzdGF0aWMgaW50
IHJrODA4X3NldF9zdXNwZW5kX3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsIGlu
dCB1dikKIHsKIAl1bnNpZ25lZCBpbnQgcmVnOwpAQCAtMzg0LDYgKzM5OSwxOSBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHJlZ3VsYXRvcl9vcHMgcms4MDVfc3dpdGNoX29wcyA9IHsKIAkuc2V0X3N1
c3BlbmRfZGlzYWJsZSAgICA9IHJrODA1X3NldF9zdXNwZW5kX2Rpc2FibGUsCiB9OwogCitzdGF0
aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMgcms4MDVfYnVjazFfMl9vcHMgPSB7CisJCS5saXN0X3Zv
bHRhZ2UJCT0gcmVndWxhdG9yX2xpc3Rfdm9sdGFnZV90YWJsZSwKKwkJLm1hcF92b2x0YWdlCQk9
IHJlZ3VsYXRvcl9tYXBfdm9sdGFnZV9hc2NlbmQsCisJCS5nZXRfdm9sdGFnZV9zZWwgICAgICAg
ID0gcmVndWxhdG9yX2dldF92b2x0YWdlX3NlbF9yZWdtYXAsCisJCS5zZXRfdm9sdGFnZV9zZWwg
ICAgICAgID0gcmVndWxhdG9yX3NldF92b2x0YWdlX3NlbF9yZWdtYXAsCisJCS5lbmFibGUgICAg
ICAgICAgICAgICAgID0gcmVndWxhdG9yX2VuYWJsZV9yZWdtYXAsCisJCS5kaXNhYmxlICAgICAg
ICAgICAgICAgID0gcmVndWxhdG9yX2Rpc2FibGVfcmVnbWFwLAorCQkuaXNfZW5hYmxlZCAgICAg
ICAgICAgICA9IHJlZ3VsYXRvcl9pc19lbmFibGVkX3JlZ21hcCwKKwkJLnNldF9zdXNwZW5kX3Zv
bHRhZ2UgICAgPSByazgwNV9zZXRfc3VzcGVuZF92b2x0YWdlLAorCQkuc2V0X3N1c3BlbmRfZW5h
YmxlICAgICA9IHJrODA1X3NldF9zdXNwZW5kX2VuYWJsZSwKKwkJLnNldF9zdXNwZW5kX2Rpc2Fi
bGUgICAgPSByazgwNV9zZXRfc3VzcGVuZF9kaXNhYmxlLAorfTsKKwogc3RhdGljIGNvbnN0IHN0
cnVjdCByZWd1bGF0b3Jfb3BzIHJrODA4X2J1Y2sxXzJfb3BzID0gewogCS5saXN0X3ZvbHRhZ2UJ
CT0gcmVndWxhdG9yX2xpc3Rfdm9sdGFnZV9saW5lYXIsCiAJLm1hcF92b2x0YWdlCQk9IHJlZ3Vs
YXRvcl9tYXBfdm9sdGFnZV9saW5lYXIsCkBAIC00MzMsNiArNDYxLDE3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcmVndWxhdG9yX29wcyByazgwOF9zd2l0Y2hfb3BzID0gewogCS5zZXRfc3VzcGVu
ZF9kaXNhYmxlCT0gcms4MDhfc2V0X3N1c3BlbmRfZGlzYWJsZSwKIH07CiAKK3N0YXRpYyBjb25z
dCBpbnQgcms4MDVfYnVja18xXzJfdm9sdGFnZXNbXSA9IHsKKwk3MTI1MDAsIDcyNTAwMCwgNzM3
NTAwLCA3NTAwMDAsIDc2MjUwMCwgNzc1MDAwLCA3ODc1MDAsIDgwMDAwMCwKKwk4MTI1MDAsIDgy
NTAwMCwgODM3NTAwLCA4NTAwMDAsIDg2MjUwMCwgODc1MDAwLCA4ODc1MDAsIDkwMDAwMCwKKwk5
MTI1MDAsIDkyNTAwMCwgOTM3NTAwLCA5NTAwMDAsIDk2MjUwMCwgOTc1MDAwLCA5ODc1MDAsIDEw
MDAwMDAsCisJMTAxMjUwMCwgMTAyNTAwMCwgMTAzNzUwMCwgMTA1MDAwMCwgMTA2MjUwMCwgMTA3
NTAwMCwgMTA4NzUwMCwgMTEwMDAwMCwKKwkxMTEyNTAwLCAxMTI1MDAwLCAxMTM3NTAwLCAxMTUw
MDAwLCAxMTYyNTAwLCAxMTc1MDAwLCAxMTg3NTAwLCAxMjAwMDAwLAorCTEyMTI1MDAsIDEyMjUw
MDAsIDEyMzc1MDAsIDEyNTAwMDAsIDEyNjI1MDAsIDEyNzUwMDAsIDEyODc1MDAsIDEzMDAwMDAs
CisJMTMxMjUwMCwgMTMyNTAwMCwgMTMzNzUwMCwgMTM1MDAwMCwgMTM2MjUwMCwgMTM3NTAwMCwg
MTM4NzUwMCwgMTQwMDAwMCwKKwkxNDEyNTAwLCAxNDI1MDAwLCAxNDM3NTAwLCAxNDUwMDAwLCAx
ODAwMDAwLCAyMDAwMDAwLCAyMjAwMDAwLCAyMzAwMDAwLAorfTsKKwogc3RhdGljIGNvbnN0IHN0
cnVjdCByZWd1bGF0b3JfZGVzYyByazgwNV9yZWdbXSA9IHsKIAl7CiAJCS5uYW1lID0gIkRDRENf
UkVHMSIsCkBAIC00NDAsMTEgKzQ3OSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ3VsYXRv
cl9kZXNjIHJrODA1X3JlZ1tdID0gewogCQkub2ZfbWF0Y2ggPSBvZl9tYXRjaF9wdHIoIkRDRENf
UkVHMSIpLAogCQkucmVndWxhdG9yc19ub2RlID0gb2ZfbWF0Y2hfcHRyKCJyZWd1bGF0b3JzIiks
CiAJCS5pZCA9IFJLODA1X0lEX0RDREMxLAotCQkub3BzID0gJnJrODA1X3JlZ19vcHMsCisJCS5v
cHMgPSAmcms4MDVfYnVjazFfMl9vcHMsCiAJCS50eXBlID0gUkVHVUxBVE9SX1ZPTFRBR0UsCi0J
CS5taW5fdVYgPSA3MTI1MDAsCi0JCS51Vl9zdGVwID0gMTI1MDAsCi0JCS5uX3ZvbHRhZ2VzID0g
NjQsCisJCS5uX3ZvbHRhZ2VzID0gQVJSQVlfU0laRShyazgwNV9idWNrXzFfMl92b2x0YWdlcyks
CisJCS52b2x0X3RhYmxlID0gcms4MDVfYnVja18xXzJfdm9sdGFnZXMsCiAJCS52c2VsX3JlZyA9
IFJLODA1X0JVQ0sxX09OX1ZTRUxfUkVHLAogCQkudnNlbF9tYXNrID0gUks4MThfQlVDS19WU0VM
X01BU0ssCiAJCS5lbmFibGVfcmVnID0gUks4MDVfRENEQ19FTl9SRUcsCkBAIC00NTYsMTEgKzQ5
NCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ3VsYXRvcl9kZXNjIHJrODA1X3JlZ1tdID0g
ewogCQkub2ZfbWF0Y2ggPSBvZl9tYXRjaF9wdHIoIkRDRENfUkVHMiIpLAogCQkucmVndWxhdG9y
c19ub2RlID0gb2ZfbWF0Y2hfcHRyKCJyZWd1bGF0b3JzIiksCiAJCS5pZCA9IFJLODA1X0lEX0RD
REMyLAotCQkub3BzID0gJnJrODA1X3JlZ19vcHMsCisJCS5vcHMgPSAmcms4MDVfYnVjazFfMl9v
cHMsCiAJCS50eXBlID0gUkVHVUxBVE9SX1ZPTFRBR0UsCi0JCS5taW5fdVYgPSA3MTI1MDAsCi0J
CS51Vl9zdGVwID0gMTI1MDAsCi0JCS5uX3ZvbHRhZ2VzID0gNjQsCisJCS5uX3ZvbHRhZ2VzID0g
QVJSQVlfU0laRShyazgwNV9idWNrXzFfMl92b2x0YWdlcyksCisJCS52b2x0X3RhYmxlID0gcms4
MDVfYnVja18xXzJfdm9sdGFnZXMsCiAJCS52c2VsX3JlZyA9IFJLODA1X0JVQ0syX09OX1ZTRUxf
UkVHLAogCQkudnNlbF9tYXNrID0gUks4MThfQlVDS19WU0VMX01BU0ssCiAJCS5lbmFibGVfcmVn
ID0gUks4MDVfRENEQ19FTl9SRUcsCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
