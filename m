Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB0DC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6502192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QaVzOrVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6502192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sWaVhR0KzsGWjxUZZK1mZ/o2wrG/InM22f7/DSM79J0=; b=QaVzOrVNBGSpB5
	PF/eLQNT7DXzHEtUbFD760Hvi+1+stofLFh7nqP8kgJnveEreExT2sqqSh8vDy1Jw1R6hGKtun/o8
	0ggivP+qar7IwoJo/C1IUTiVLW4DmilGfllpObmg5Jv0+LbiktY2VPXzW1jvnwzTkpW0bCC18bRDs
	2ShB7GKPgF24zdnYGf7PiflfHl3ZjpXAJgEUP+TIMJPFWHv8tMczympAomh/ADHc85UvrTWYy2pHp
	Xtx1LFesHmkqOg5LsxLMe/DpZqGIl9eAw+WFaEnGjipOVjIms1u/6s3Wtn5LtNTT+/TIHOpUS7KHV
	mdpvYfx4d6YWFLZW/IWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueDp-0005xW-4W; Fri, 15 Feb 2019 14:12:09 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueDe-0005n5-P5; Fri, 15 Feb 2019 14:12:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 03E0CFB06;
 Fri, 15 Feb 2019 15:11:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K68eWVgKyERr; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 3835148DC1; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bastien Nocera <hadess@hadess.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Date: Fri, 15 Feb 2019 15:11:50 +0100
Message-Id: <cover.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_061158_979816_1C2CC9D9 
X-CRM114-Status: UNSURE (   8.64  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QmVzaWRlcyB0aGUgc3VwcG9ydCBmb3IgZ3Q1Njg4IHR3byBtb3JlIG1pbmltYWwgY2hhbmdlcyBw
aWxlZCB1cCBzbyBJJ20KZm9sZGluZyB0aGVzZSBpbiBoZXJlLiBPbmUgaXMgYSBkb2MgdXBkYXRl
IGZvciB0aGUgZ29vZGl4IGJpbmRpbmdzLCB0aGUKb3RoZXIgb25lIG1ha2VzIGl0IGEgYml0IHNp
bXBsZXIgdG8gZmlndXJlIG91dCBjb25maWd1cmF0aW9uIHByb2JsZW1zCihsaWtlIGxhY2sgb2Yg
dG91Y2hzY3JlZW4tc2l6ZS17eCx5fSBpbiB0aGUgZGV2aWNlIHRyZWUuCgpJJ3ZlIGtlcHQgdGhl
IG9yaWdpbmFsIHN1YmplY3QgdG8gKGhvcGVmdWxseSkgbm90IGJyZWFrIHRoZSBzZXJpZXMgZm9y
CnBhdGNod29yay4gQWxsIHBhdGNoZXMgY2FuIGJlIGFwcGxpZWQgaW5kZXBlbmRlbnRseS4gU2Vy
aWVzIGlzIGJhc2VkIG9uCm5leHQtMjAxOTAyMDguCgpDaGFuZ2VzIGZyb20gdjIKKiBBZGQgJ2R0
LWJpbmRpbmdzOiBpbnB1dDogUmVmZXIgdG8gdG91Y2hzY3JlZW4udHh0IGZvciBnb29kaXggdHMn
CiogQWRkICdpbnB1dDogZ29vZGl4OiBQcmludCB2YWx1ZXMgaW4gY2FzZSBvZiBpbmNvbnNpc3Rl
bmNpZXMnCiAgKHNlbnQgb3V0IHNlcGFydGVseSBiZWZvcmUsIG5vIGNvbW1lbnRzIHNvIGZhcikK
KiBDb2xsZWN0ICdSZXZpZXdlZC1CeScgb24gJ2lucHV0OiBnb29kaXggLSBzdXBwb3J0IEdvb2Rp
eCBndDU2ODgnCgpDaGFuZ2VzIGZyb20gdjEKKiBBZGQgdGVzdGVkIGJvYXJkIHRvIGNvbW1pdCBt
ZXNzYWdlCgpHdWlkbyBHw7xudGhlciAoMyk6CiAgaW5wdXQ6IGdvb2RpeCAtIHN1cHBvcnQgR29v
ZGl4IGd0NTY4OAogIGR0LWJpbmRpbmdzOiBpbnB1dDogUmVmZXIgdG8gdG91Y2hzY3JlZW4udHh0
IGZvciBnb29kaXggdHMKICBpbnB1dDogZ29vZGl4OiBQcmludCB2YWx1ZXMgaW4gY2FzZSBvZiBp
bmNvbnNpc3RlbmNpZXMKCiAuLi4vYmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LnR4
dCAgICAgICAgICB8IDE0ICsrKysrKysrKy0tLS0tCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVu
L2dvb2RpeC5jICAgICAgICAgICAgICAgICB8ICA2ICsrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKLS0gCjIuMjAuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
