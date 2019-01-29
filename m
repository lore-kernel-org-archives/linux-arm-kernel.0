Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1912084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uu/XdZCP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJ3Wosdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=esVfJKYvhCpn44zf5hS1quNjQkf1U/bBa+ZZPvSbJRY=; b=Uu/XdZCP4N4uXX
	RVHF9L/4F+K3a9+sUd9HaH0YSU/zBH3e4xIVPZi7oOfGj5PuHKsFhLpjx15rMMQ9Wdh1qWgwAAbX/
	C1YbLYzTmsDBMPBowTIZTA9g79hGd0SgktdjmFWWxf/1r29aJnyl9oygM5EEicW5pCIQLIKJl8OK+
	tCjRQDO4pVknUpzIvlH5lGrHsBhkqhvakesJsOBLSzSIjENxO+1emumUHL4+M3f0S+8OGEy+0hlVX
	K2gPcc1aNKazQ6mgEW91oQBPPqc0i9RwT8+q/shAhb1mQhjO1SqBljsZLcAIY03WnNk0wzIveA7rs
	2bM7yHIZcVCuTtg8nWbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRFi-00054h-0w; Tue, 29 Jan 2019 11:08:26 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRFf-00054I-G3
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:08:25 +0000
Received: by mail-wr1-x442.google.com with SMTP id p7so21610900wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WjtU1Mm3zQpj3UOsls+IN7NaT7AGPSLjq6+Y000jMCo=;
 b=AJ3WosdgmUgrpQwu2B/NyTgjDH125y8IC7oxJqsAnhB25SPVawC5e2C/EuPvvd4054
 k8FuXQ4XTG7sqdXHGXiyJR/yhYGG9Sz3H68NAxsyuCJaXruAjcgj398tXDWJ6t442EZw
 Wzej80Mj+c0eUgA1RovQ8cTaqRqeJR1HJlQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WjtU1Mm3zQpj3UOsls+IN7NaT7AGPSLjq6+Y000jMCo=;
 b=BIUzt6NEK9A8kyxcxENkH9sHTVd9HdkBAECk3o7oE70SIiS79uv0Ti7r6FV0BkzGYC
 FaBdV06d/HFpCHL4EayG0LjUDLMYtzh9ZpzsvLri6ZxLtQl7MFZd8AxxewiaM8zKFvot
 ADa6uq0WcCvKj6TLqU3pXjwKE41rRdQFKvCF9UzpRGyn+aY9t2r+vWtMqBJp4HbhBKOq
 p+KNMCa4899pmRo1rfq2OjkqHh/bj2EsTAK6tFM61QHrXP10nwOOh1GkkywYmnXutdwA
 +gmmoIk1VKbKFbE4vBYSNMnobQuNlZOdzRFd2YqWXJfkL7RRBepa9CyiK+S0NiEGM7D4
 Ixlg==
X-Gm-Message-State: AJcUukdJwxt7CraMxH5F7CvtXtY5tthpYk6VUXeB8QPHU74KVFUZaqGf
 G0XnkpIsZdfl3Yolz0ZXd/0ztw==
X-Google-Smtp-Source: ALg8bN4/jltB+S9Z+KXyl7gKeeZGkQB1YEcqLIoejd6PhF30E6oaMBRDtvtCe8Mnf6uoOuLbU95MLA==
X-Received: by 2002:adf:c452:: with SMTP id a18mr25992412wrg.145.1548760101091; 
 Tue, 29 Jan 2019 03:08:21 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 141sm2913886wmb.5.2019.01.29.03.08.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 03:08:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaro.local (Postfix) with ESMTPS id EA0F83E171D;
 Tue, 29 Jan 2019 11:08:19 +0000 (GMT)
User-agent: mu4e 1.1.0; emacs 26.1.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>, "open list\:ARM" <qemu-arm@nongnu.org>,
 "linux-arm-kernel\@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm\@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Kernel boot regression with PAuth and aarch64-softmmu -cpu max and
 el2 enabled
Date: Tue, 29 Jan 2019 11:08:19 +0000
Message-ID: <87va27n2l8.fsf@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_030823_539936_7AFC64AD 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkhpLAoKRm9sbG93aW5nIHVwIG9uIHllc3RlcmRheSdzIGRpc2N1c3Npb24gb24gSVJDIEkgdGhv
dWdodCBJJ2QgYmV0dGVyCnJlcG9ydCBvbiBteSBmaW5kaW5ncyBpbiB0aGUgcGVybWFuZW50IHJl
Y29yZCBzbyB0aGluZ3MgZG9uJ3QgZ2V0IGxvc3QuCgpBcyBJIHRlbmQgdG8gcGVyaW9kaWNhbGx5
IHJlYnVpbGQgbXkgdGVzdCBrZXJuZWxzIGZyb20gdGhlIGN1cnJlbnQKc3RhdGUgb2YgbGludXgu
Z2l0IEkgb2NjYXNpb25hbGx5IHJ1biBpbnRvIHRoZXNlIHRoaW5ncy4gTXkgdGVzdAppbnZvY2F0
aW9uIGlzOgoKICBxZW11LXN5c3RlbS1hYXJjaDY0IC1tYWNoaW5lIHR5cGU9dmlydCx2aXJ0dWFs
aXphdGlvbj1vbiBcCiAgICAgICAgICAgICAgICAgICAgICAtZGlzcGxheSBub25lIC1tIDQwOTYg
LXNlcmlhbCBtb246c3RkaW8gXAogICAgICAgICAgICAgICAgICAgICAgLWtlcm5lbCAuLi8uLi9r
ZXJuZWwtdjgtcGxhaW4uYnVpbGQvYXJjaC9hcm02NC9ib290L0ltYWdlIFwKICAgICAgICAgICAg
ICAgICAgICAgIC1hcHBlbmQgJ2NvbnNvbGU9dHR5QU1BMCBwYW5pYz0tMScgLW5vLXJlYm9vdCAt
Y3B1IG1heAoKVGhlIGtlcm5lbCBpcyBlc3NlbnRpYWxseSBhIGRlZmNvbmZpZyBrZXJuZWwgd2l0
aCBhIGJ1bmNoIG9mIHRoZSBWSVJUSU8KZGV2aWNlIGRyaXZlcnMgYnVpbHQtaW4gZm9yIHdoZW4g
SSBhY3R1YWxseSBib290IGEgbW9yZSBjb21wbGV4IHNldHVwCndpdGggZGlza3MgYW5kIGRyaXZl
cy4gSG93ZXZlciB0aGlzIGlzIGEgYm9vdCB0ZXN0IHNvIGRvZXNuJ3QgcmVhbGx5Cm1hdHRlci4K
ClRoZSAtbWFjaGluZSB0eXBlPXZpcnQsdmlydHVhbGl6YXRpb249b24gZW5hYmxlcyBvdXIgdmly
dCBtYWNoaW5lIG1vZGVsCndpdGggRUwyIHR1cm5lZCBvbi4gQXMgdGhlcmUgaXMgbm8gQklPUyBp
bnZvbHZlZCB0aGUga2VybmVsIGlzIGludm9rZWQKZGlyZWN0bHkgYXQgRUwyLgoKVGhlIC1jcHUg
bWF4IGVuYWJsZWQgYSBjb3J0ZXgtYTU3ICsgd2hhdGV2ZXIgZXh0cmEgZmVhdHVyZXMgd2UndmUK
ZW5hYmxlZCBpbiBRRU1VIHNvIGZhci4gSXQgd29uJ3QgbWF0Y2ggYW55ICJyZWFsIiBDUFUgYnV0
IGl0IHNob3VsZCBiZQphcmNoaXRlY3R1cmFsbHkgY29ycmVjdCBpbiBzbyBmYXIgd2UgaW1wbGVt
ZW50IHByZXJlcXVpc2l0ZSBmZWF0dXJlcyBmb3IKYW55IGdpdmVuIGZlYXR1cmUuIFRoZSBjcHVp
ZCBmZWF0dXJlIGJpdHMgc2hvdWxkIGFsc28gYmUgY29ycmVjdCBhcyB3ZQp0ZXN0IHRoZW0gaW50
ZXJuYWxseSBpbiBRRU1VIHRvIGVuYWJsZSBmZWF0dXJlcy4KClRoZSBicmVha2FnZSBpcyB0aGUg
a2VybmVsIG5ldmVyIGJvb3RzIChubyBvdXRwdXQgb24gc2VyaWFsIHBvcnQpIGFuZCBvbgphdHRh
Y2hpbmcgd2l0aCBnZGIgSSBmb3VuZCBpdCBzdHVjayBpbjoKCiAgKGdkYikgYnQKICAjMCAgMHhm
ZmZmZmY4MDEwYTllNDgwIGluIG92ZXJmbG93X3N0YWNrICgpCiAgQmFja3RyYWNlIHN0b3BwZWQ6
IG5vdCBlbm91Z2ggcmVnaXN0ZXJzIG9yIG1lbW9yeSBhdmFpbGFibGUgdG8gdW53aW5kIGZ1cnRo
ZXIKCklmIEkgdHVybiBvbiBleGNlcHRpb24gdHJhY2luZyBpdCBsb29rcyBsaWtlIHdlIGdvIGlu
dG8gYW4gZXhjZXB0aW9uCmxvb3AuCgpPbiB0aGUgUUVNVSBzaWRlIHRoaXMgYnJlYWthZ2UgY29t
ZXMgaW4gYXQ6CgogIGNvbW1pdCAxY2UzMmU0N2RiNTJlMzUxMTEzMmM3MTA0NzcwZWFlNjVkNDEy
MTQ0IChIRUFELCByZWZzL2Jpc2VjdC9iYWQpCiAgQXV0aG9yOiBSaWNoYXJkIEhlbmRlcnNvbiA8
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KICBEYXRlOiAgIE1vbiBKYW4gMjEgMTA6MjM6
MTMgMjAxOSArMDAwMAoKICAgICAgdGFyZ2V0L2FybTogRW5hYmxlIFBBdXRoIGZvciAtY3B1IG1h
eAoKICAgICAgUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4KICAgICAgU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc+CiAgICAgIE1lc3NhZ2UtaWQ6IDIwMTkwMTA4MjIzMTI5LjU1NzAt
MzAtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwogICAgICBTaWduZWQtb2ZmLWJ5OiBQZXRl
ciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+CgphbmQgYXMgeW91IHdvdWxkIGV4
cGVjdCB0aGUgc3lzdGVtIGJvb3RzIGZpbmUgd2l0aCAtY3B1IGNvcnRleC1hNTcKCk9uIHRoZSBr
ZXJuZWwgc2lkZSBpdCBicmVha3MgYXQ6CgogIGNvbW1pdCAwNGNhMzIwNGZhMDlmNWY1NWM4ZjEx
M2IwMDcyMDA0YTdiMzY0ZmY0CiAgQXV0aG9yOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBh
cm0uY29tPgogIERhdGU6ICAgRnJpIERlYyA3IDE4OjM5OjMwIDIwMTggKzAwMDAKCiAgICAgIGFy
bTY0OiBlbmFibGUgcG9pbnRlciBhdXRoZW50aWNhdGlvbgoKICAgICAgTm93IHRoYXQgYWxsIHRo
ZSBuZWNlc3NhcnkgYml0cyBhcmUgaW4gcGxhY2UgZm9yIHVzZXJzcGFjZSwgYWRkIHRoZQogICAg
ICBuZWNlc3NhcnkgS2NvbmZpZyBsb2dpYyB0byBhbGxvdyB0aGlzIHRvIGJlIGVuYWJsZWQuCgog
ICAgICBTaWduZWQtb2ZmLWJ5OiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgog
ICAgICBTaWduZWQtb2ZmLWJ5OiBLcmlzdGluYSBNYXJ0c2Vua28gPGtyaXN0aW5hLm1hcnRzZW5r
b0Bhcm0uY29tPgogICAgICBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJt
LmNvbT4KICAgICAgQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgogICAgICBT
aWduZWQtb2ZmLWJ5OiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4KClNvIHByZWRp
Y3RhYmx5IHdlIGZhaWxlZCBhdCBlbmFibGluZyBQQXV0aCBzb21ld2hlcmUgYmV0d2VlbiB0aGUg
a2VybmVsCmFuZCBRRU1VLgoKSSdtIGd1ZXNzaW5nIHRoZSBrZXJuZWwgc28gZmFyIGhhcyBiZWVu
IHRlc3RlZCBvbiB0aGUgZmFzdCBtb2RlbCB3aXRoIGEKZnVsbCBjaGFpbiBvZiBURiwgVUVGSSBh
bmQga2VybmVsPwoKSSB0aGluayBSaWNoYXJkJ3MgdGVzdHMgd2VyZSB3aXRob3V0IEVMMiBlbmFi
bGVkLgoKU28gaW4gdGhlIGNhc2UgdGhhdCB0aGUga2VybmVsIGJvb3RzIGluIEVMMiBpcyBpdCBl
eHBlY3RpbmcgYW55b25lIGVsc2UKdG8gZGVhbCB3aXRoIFBhdXRoIGV4Y2VwdGlvbnMgb3Igc2hv
dWxkIGl0IGJlIGFibGUgdG8gY29wZSB3aXRoIGFuCmVuYWJsZWQgUGF1dGggYnV0IG5vIGZpcm13
YXJlIHVuZGVybmVhdGggaXQ/CgpFaXRoZXIgd2UndmUgZ290IHNvbWV0aGluZyB3cm9uZyBvciB3
ZSdsbCBuZWVkIHRvIHJldGhpbmsgd2hhdCBmZWF0dXJlcwp0aGUgdXNlciBjYW4gaGF2ZSBlbmFi
bGVkIGJ5IC1jcHUgbWF4IG9uIGEgZGlyZWN0IGtlcm5lbCBib290LgoKLS0KQWxleCBCZW5uw6ll
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
