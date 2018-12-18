Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7D7217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbEXLKgJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Sx4TZAPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7D7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z0kApGs1K171oY8kRET4tet4gQ69LSJ+5INaWEyMOpY=; b=pbEXLKgJDEQm1w
	ht+PmBCF+iI49mxot1aTqiQ4ODXJy6ym0PTorlmtLyWcyuxdem86Na+AylwjG3BoQprGgki9BoOKD
	hB9+UZw/p/14cUug9fCV6E7qezKZAJP9gzmn+5MxeOjJST/MGgJBTu8q5h9O1cQ91mYhQ+/dvS2wz
	gLFW6C/TDMSzUxRRUP8MsTploY0ZEboHiYVBBK4lqgtAa5sQjgrNjxZngwJJOWLsoHb2PqHtH2o71
	OUKfvkfInHJ1BwK04lRsSqw26EeVFEEXQyoCkm9kFjR/u14r+Ac2lldqQ7EqXq7StN9rHpZWnzbTf
	wYLQkbTet7ljv2oO1D9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZELE-0005Hx-Lc; Tue, 18 Dec 2018 12:19:16 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEKz-00053L-2G
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:19:03 +0000
Received: by mail-wm1-x343.google.com with SMTP id f81so2560307wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SkscCEtDXpliSXHUz/cuWzh5NuHyq42x9x7Eg9phJA0=;
 b=Sx4TZAPnVYELEi/GgiW2vm6HLxP6N3CesPKNUruVEtOrQdV3j+sJUglwhjkcqZlcLt
 FM3CCZsB4QyVZ8LX+cpq/z+1XCkXMNEbX6yGwR2HeBOMote03LYZtCRB1i/0AvSwQhcS
 HvM/qslHbK26aBNdqbHvbzKK5fbJSlX4Q90VHlnKpj6fc9T6TfsQKQtPYk/+TeU/WrK3
 5DICy+eqFo2fqf8a5JUIlCJcoTENy6ff747mQ2VNZOnIMd+Xi7ErwXXatX/Fy6pe7M8V
 yhHEd36TYjFL6Okln5g99tFj9Q9JzXVRw6bjxe6XOp0eVEiXvZw0GB74vuPE7BcFp02M
 pCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SkscCEtDXpliSXHUz/cuWzh5NuHyq42x9x7Eg9phJA0=;
 b=eRDKP4HYShQI2sWz65fTMvS2qz1yvDyRRV172sa327sECf5RQsoM/gWjPixXfAFr7P
 L9BGNLHoKOVWNYHQTeCYzGpGCMTHw7ExBrgS29ML7+uUUa6+QjH41+RTdnFMp6k4D3Bq
 K3gkZO64z6kle59akW8nv0aFGqPN/WMcQqlfkgCcI8Si8dxj3wLvgunzriVMGtile9XA
 FGc33g8/zF1rMp9jAO+UhvkOKs7giPV9BGg0Sukws5l7qU7lk6K2gWKNiga1ePILmacb
 XJ5EqLiG//NQKYao5mEtXtmI3m9FxJZshdBOufcGwqGqT5LMrftyM/l+xvzoQgNbf27i
 Y6LA==
X-Gm-Message-State: AA+aEWbktov13pjSRyOAtlknE5P1lEtQwXB6inp/enZfCgKBO1qSMeBa
 xb7Ctiip3Fxf3qpPc/hGJRLj50D2De4qOQ==
X-Google-Smtp-Source: AFSGD/WQEIrEbaUo7eI1G29c2X+n1KtgyLsk4tqicmOf5dgboH1XY/qgCxqhmzmGHXqNTPd5hn7WcA==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr3047275wmd.51.1545135528993; 
 Tue, 18 Dec 2018 04:18:48 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id s66sm2092390wmf.34.2018.12.18.04.18.48
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 04:18:48 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 1/4] serial: uartps: Add the device_init_wakeup
Date: Tue, 18 Dec 2018 13:18:39 +0100
Message-Id: <439951b77da9a1d4cc0551af41c158ae5908b840.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041901_155793_B0F3E0E8 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNvbT4K
CkluaXRpYWxpc2UgdGhlIGRldmljZSB3YWtldXAuCgpUaGUgZGV2aWNlX2luaXRfd2FrZXVwwqBp
cyBuZWVkZWQgZm9yIHRoZSB3YWtldXAgdG8gd29yayBieSBkZWZhdWx0LgpVYXJ0IGNhbiBiZSBj
b25maWd1cmVkIGFzIHRoZSBwcmltYXJ5IHdha2V1cCBzb3VyY2Ugc28gaXQgaXMgZ29vZCB0bwpl
bmFibGUgd2FrZXVwIGJ5IGRlZmF1bHQuCgpUaGUgc2FtZSBmdW5jdGlvbmFsaXR5IGlzIGVuYWJs
ZWQgYWxzbyBieSA4MjUwX29tYXAsIGF0bWVsX3NlcmlhbCwKb21hcC1zZXJpYWwgYW5kIHN0bTMy
LXVzYXJ0LgoKU2lnbmVkLW9mZi1ieTogU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGku
ZGF0dGFAeGlsaW54LmNvbT4KU2lnbmVkLW9mZi1ieTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2lt
ZWtAeGlsaW54LmNvbT4KLS0tCgpDaGFuZ2VzIGluIHYyOgotIENoYW5nZSBkZXNjcmlwdGlvbiBi
YXNlZCBvbiByZXF1ZXN0IGZyb20gR3JlZwoKIGRyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFy
dHBzLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC94aWxpbnhfdWFydHBzLmMKaW5kZXggMzc5MjQyYjk2NzkwLi4wMTQwNjQ0MzkxZGYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMKKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYwpAQCAtMTYyNCw2ICsxNjI0LDcgQEAgc3RhdGljIGlu
dCBjZG5zX3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlwbV9ydW50
aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgmcGRldi0+ZGV2LCBVQVJUX0FVVE9TVVNQRU5EX1RJ
TUVPVVQpOwogCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgmcGRldi0+ZGV2KTsKIAlwbV9ydW50aW1l
X2VuYWJsZSgmcGRldi0+ZGV2KTsKKwlkZXZpY2VfaW5pdF93YWtldXAocG9ydC0+ZGV2LCB0cnVl
KTsKIAogI2lmZGVmIENPTkZJR19TRVJJQUxfWElMSU5YX1BTX1VBUlRfQ09OU09MRQogCS8qCkBA
IC0xNzAyLDYgKzE3MDMsNyBAQCBzdGF0aWMgaW50IGNkbnNfdWFydF9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7CiAJ
cG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKCZwZGV2LT5kZXYpOwogCXBtX3J1bnRpbWVfZG9udF91
c2VfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7CisJZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5k
ZXYsIGZhbHNlKTsKIAogI2lmZGVmIENPTkZJR19TRVJJQUxfWElMSU5YX1BTX1VBUlRfQ09OU09M
RQogCWlmIChjb25zb2xlX3BvcnQgPT0gcG9ydCkKLS0gCjEuOS4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
