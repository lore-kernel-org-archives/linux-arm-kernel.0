Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9112080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JrtDHm4y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXlk7uNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9112080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nu3NEdk1Ff49AaTz6VEFTISP9/SQ4R2JTpSjEWOa3C4=; b=JrtDHm4yKxnnZ4
	9amHQ+VHJhbkPt5TdEV8K0L+rkCg1uGsuzwDvwZ2PrigMn2H/Kghu+7NjPkvol/htYIMBVIHuHPgl
	anZ4tGILxMlY78YvWuEeKxcopbmH4/j4Ha6trDwwW/KHsFrlnpAxKiAUzzvA8hgiU8RcZEENU2OY8
	RCWSNvmoNQFyGveLn78rYUOmG+4OgYCs2wIR8O7cnOfZkdHdw4CNVg4/rWw32zJ4YMs8XdK+1xwU2
	MDzg9kfw+hlHFVZloU4WE06BS59joNsWYlqDUL7i+/UjUbtufypBL7eUHBfadYE1/MlCKpmiwEsyw
	Z+F2b3fSp68/z44G2Q0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvUId-0006c3-DZ; Sun, 17 Feb 2019 21:48:35 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvUIY-0006aX-QD
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 21:48:32 +0000
Received: by mail-wr1-x441.google.com with SMTP id w17so16162473wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 13:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3Ulo8XvsRN/4EFvyv9ZkpIMBsSSfHRzXFDGXuQ85ggE=;
 b=qXlk7uNubIi9Q4kfdP3tgElcV8gmyy9681yP0bYT9YpsxATtCIXAntiPjVWXdcP375
 7ppLbzsbFsTDjgA5ObybSEL297MBfOzpScfWm4RsDjOS/A/T/c4G0ricNP9CO3KwCzOq
 Ll0gZ+6fv1uAkkljbOECLl9EFCS/5ClC3liT/WnQLhqwj7BFaCp4x59IAQLJsD3majiT
 TTqxF/VhBYs1EyRiriY9TKTGEQ0WoOK00hOdirq79jtwUe0tikvvvXijXsRO4tRCFhcQ
 LQzU35BB53WNCEp0EmNb0fDAQRyx1rJKmYXBfNzyPNffQHkyp/ydGHGrMbGhRNxhvXOY
 d8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Ulo8XvsRN/4EFvyv9ZkpIMBsSSfHRzXFDGXuQ85ggE=;
 b=QTPZCcLsFFDvRcrk9gtSAVL9KTechz3HGEOxnXrNC3Nysd44SdVKLJ8inMjk0dBOHp
 Uf43Jq//yaBLoqEBppMSy91cvf6viaSl58DrLkPO/4K8SIldSMUO52Y3sXFdRPICcS9G
 70/HaglfjE0/kOd4nF2cvqlPvk9Lp0a5HJyadRF4kRRQRdJF7swnaH2iUpQEdbvX9fu+
 bPLo6vXcfXQIAE3/t3+r3whM8oBmsHIqBB89EUpftkDUBN5N1sKza5dmV9MKD0gFUdJb
 AA1JlEpmC1YFSRF4X5RPaVm5CZj0GjFsq5IzkeUYTmPjSObEgMkYOAKKRSIf39WNzu7F
 Y7dw==
X-Gm-Message-State: AHQUAuYhiTdltKReprqEG43LSn/2wu47DbffAM1PJZ6F2i+pCkSTwA8Z
 ngZLXQzknabdnkWela1sjPtGbQ==
X-Google-Smtp-Source: AHgI3IZfI4mU0q2wzMbokm1soc542SgMf5MCPfS7OjSQetmIiKmDqUNnvTFj6YZpIW+xfU8nPZ+qhA==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr13055272wrs.85.1550440107843; 
 Sun, 17 Feb 2019 13:48:27 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id j15sm7497217wrt.1.2019.02.17.13.48.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 13:48:27 -0800 (PST)
Subject: Re: [PATCH 3/3] dt-bindings: timer: mediatek: update bindings for
 MT7629 SoC
To: Ryder Lee <ryder.lee@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
 <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <05377892-7434-f74f-c28e-ebada2596b51@linaro.org>
Date: Sun, 17 Feb 2019 22:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_134830_976229_B9BC6754 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTcvMDIvMjAxOSAxNDo1MCwgUnlkZXIgTGVlIHdyb3RlOgo+IEZyb206IFJ5ZGVyIExlZSA8
cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4KPiAKPiBVcGRhdGUgdGhlIGJpbmRpbmcgZm9yIE1UNzYy
OSBTb0MsIHdoaWNoIHVzZXMgZmFsbGJhY2sgY29tcGF0aWJsZSB0bwo+IE1UNjc2NSBTWVNULCBz
byBhZGQgbW9yZSBkZXNjcmlwdGlvbnMgdG8gZGlzdGluZ3Vpc2ggaXQgZnJvbSB0aGUgb3RoZXIK
PiBTb0NzIHRoYXQgdXNlIEdQVC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVy
LmxlZUBtZWRpYXRlay5jb20+Cj4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPgo+IC0tLQoKQXBwbGllZCBmb3IgNS4xCgpUaGFua3MKCiAgLS0gRGFuaWVsCgoK
LS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJv
b2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xp
bmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBC
bG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
