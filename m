Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BDE20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jlRtZz65";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOQlCBLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BDE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1oV5B0jnmnHTxdKOkpexPWBE2tm//7Ak1AJvSuKCDJ0=; b=jlRtZz65BgFCim
	Fix0vvV5bZCMSfpL4gRq9INnwOfx2BiLnUEscm1Y0+T5gClA2UTGLAt4K1FQZi2lLx89mCkgpBecO
	toYZQAfJxDSmFxrPL/mYOT5Uh8EHweh17BHgj8OgxPpUydwqFfc6zvU+D4A97i1yvs60IvKDi0mQN
	Y5FBETKjvDjCIlpxHlE3KjJmp9n2mghBPHCu3FWas9FglwA/cSp/RlOBg07JHXMVbkB1WuVfXm5pH
	LFdD5II05OLftJDWOljL4goNnFu8zXpLeH+VXPWVAcPZDBNCt5mJ5oY5FsB9C2lq5tey7yPnaoM77
	6dCGluZmiAkxcHOqPl/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsFQ-0000BZ-Tn; Fri, 11 Jan 2019 08:33:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsFM-0000As-Nx
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:32:58 +0000
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A4FD42177B
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547195575;
 bh=azJo3pr89+SKEM362N0XLet7Y0w+F6c96PjeR6Lm2uI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rOQlCBLv5mqJhT1DVajIbXdDBdTz/C6NfKeHt2tAKIqS5EDsUcjcQ0Vo9Is96U3eD
 OycWsy6HCVV/GBcXipfYy0QjP59CRvlj0u3dasiAi6tqKm2uEgtrSA/NAkcU9a5Brl
 RPIJWP5y5Wg9FgOhi5pbqm26zS/qcNROsepUO8jE=
Received: by mail-lf1-f54.google.com with SMTP id i26so10243763lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:32:54 -0800 (PST)
X-Gm-Message-State: AJcUukevcWa5ZzfHtfn8R6UU9+gPda4j32apEUysOR3ksg5RUwvKgQKX
 cyvjJiafMDzqpZhsfhfsbKdDJ4kLM9JChgHBzcI=
X-Google-Smtp-Source: ALg8bN7DnleXAa10jFv80f5pt8kv86oa/SCKTA0ka4ni5pAL6JXCTJhpc8llfAdDAA6ujc/DGKWSBpNdYyfpNiu0HTw=
X-Received: by 2002:a19:660a:: with SMTP id a10mr8129491lfc.146.1547195572807; 
 Fri, 11 Jan 2019 00:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Jan 2019 09:32:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Message-ID: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_003256_801318_62D476A5 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAxMCBKYW4gMjAxOSBhdCAyMTo1MywgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGFkZHMgZG1jIG5vZGVz
LCB3aGljaCBhcmUgbmVlZGVkIGJ5IHM1cHYyMTAgY3B1ZnJlcSBkcml2ZXIKPiB0byB3b3JrLgo+
Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21h
aWwuY29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kgfCAxMiArKysr
KysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKPgoKVGhhbmtzLCBh
cHBsaWVkIChhY3R1YWxseSBJIGFwcGxpZWQgdjEgLSBJIGhvcGUgdGhlcmUgd2VyZSBubyBjaGFu
Z2VzKS4KCkJlc3QgcmVnYXJkcywKS3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
