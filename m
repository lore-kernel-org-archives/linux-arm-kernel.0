Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA8C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F9920857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXXaPLOL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyAcaseE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F9920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wfGqTfgImKtdPvKyCH4+tvN49S3gosLKf+WY/h05qj0=; b=BXXaPLOLW9OLzl
	YLw5qy3hpjA0GFmzXKMuCkmkFu1175AY+FnmXUZPjAC85L60gwtQd51y+6CqIOj3yzfxmZgZfj2p3
	lswhcHKlMJzSK02JcvR3WkH1+4BqJcGG/3SXOt00Zs8+ORGBN9gLDNwk+c9XqQgY+CdRJctnOxJaz
	cXKs1Jm3+7KeaRa+eJk+ky1f48hIPn8oay/f9SbZQ3eqTxQ2HCwSyPe1NXzNuRbUgzMhVlYjMDSH4
	j0uO/mqGVLcLT5OYqpRfuOAm6JsDfZjwddDl+rv38REAjkXJ4QuYWTvb23RHq+IIl9VJD4GtnV0xt
	ElHriu1bS6EqT0CSwBFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpR2p-0003EE-4a; Fri, 01 Feb 2019 05:07:15 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpR2L-0002xD-1v
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 05:06:46 +0000
Received: by mail-ed1-x542.google.com with SMTP id f9so4394699eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 21:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
 :references:content-transfer-encoding;
 bh=rNBSVjkdZgBVoZvG2wGx0w02dYtFEMmlTT5ibMJrZrE=;
 b=PyAcaseEZb6VWCiPu04SfvYB39XH6bVPPRoMlBS5BSVoDNlq0t926O1i8eeg/z2ZIC
 6rdFfi2SBZVlVBh3tMAodPjpC188ZgOrbHu/w9DffWQyBCeZ2uH+HplCUikoLoyr2pNS
 rf9+7IUSRE2okMVmfOSX/ExPTa6gXRxF8PV3fCUvRdrY0v4lwSFH8g9R93qUAwq3Khbi
 1LAu+8xuXbXjmHKLu36NUmzy2nIe9AE2SqB3eZkwFxFzS9Ah/mA54ajjJDRmsc+fMfUs
 XbGZXf+YnVGNIPzfN5a3J9c+TdbSQzZSQMgxQMtRvZ+tuKA2BrC4940j41kkYTrEDqxs
 +cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :in-reply-to:references:content-transfer-encoding;
 bh=rNBSVjkdZgBVoZvG2wGx0w02dYtFEMmlTT5ibMJrZrE=;
 b=rLf3YAZztUkX0MtA4mKkzOdqeqoax8l6T1rgW1qnjf5hm/UnCGtvhdO2pJqMRP/aPn
 oVX3HkrWR+Jn1QNB8dH7kPnOJarx5psvtdhj31K10msRFKFrmQ9ddPloRiLlES17/IeV
 MKybfwRSHSSIQSyTQe4DuM7ZtGy7kFPUtKb0E9vrJZtBl7dTL0vtXNSW4qUKDMCI7wN1
 FTm0XxcemIG9R98jNmoTNofpO7d+mzLCx9wTTLKbj0PG43KI/fijkBQBqXHE7PebJmhY
 7CC80+ZL18US1jE5UWoET1L7gy5vuomWekmfnUAm+pmfnVl2qWoMBZakPP9uxZUIDe4F
 Q7IA==
X-Gm-Message-State: AJcUukc5RYtrB7GIuyKWxnVnMIpeJug8zrN3JmvbXs684hhqb2p2PIt3
 E41S4viq+ICco0pQn79W3v8=
X-Google-Smtp-Source: ALg8bN76YBeA4CO+zt5JXCewoCoCkThykEPc9FAhpYW6C5iMcnuPaUKSkkN0LLga83xHsy50dLaNWQ==
X-Received: by 2002:a17:906:54d3:: with SMTP id
 c19-v6mr32603119ejp.116.1548997603138; 
 Thu, 31 Jan 2019 21:06:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id z40sm1769618edz.86.2019.01.31.21.06.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 21:06:42 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
 =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add basic DT for Phicomm K3
Date: Thu, 31 Jan 2019 21:06:33 -0800
Message-Id: <20190201050633.7420-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20190120223327.14999-1-zajec5@gmail.com>
References: <20190120223327.14999-1-zajec5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_210645_090245_0E5B48E8 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Hao Dong <halbertdong@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Rob Herring <robh+dt@kernel.org>,
 =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
 Hamster Tian <haotia@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCAyMCBKYW4gMjAxOSAyMzozMzoyNyArMDEwMCwgUmFmYcWCIE1pxYJlY2tpIDx6YWpl
YzVAZ21haWwuY29tPiB3cm90ZToKPiBGcm9tOiBIYW8gRG9uZyA8aGFsYmVydGRvbmdAZ21haWwu
Y29tPgo+IAo+IFRoaXMgcm91dGVyIGhhcyBCQ000NzA5QzAgU29DLCAxMjggTWlCIE5BTkQgZmxh
c2ggKE1YMzBMRjFHMThBQy1USSksCj4gNTEyIE1pQiBtZW1vcnkgYW5kIDMgeCBMQU4gYW5kIDEg
eCBXQU4gcG9ydHMuIFdpRmkgY2hpcHMgYXJlCj4gQkNNNDM2NkMwIHggMi4gVGhlIHJvdXRlciBo
YXMgYSBzbWFsbCBMQ0QgYW5kIDMgY2FwYWN0aXZlIGtleXMgZHJpdmVuIGJ5Cj4gYSBQSUMgbWlj
cm9jb250cm9sbGVyLCB3aGljaCBpcyBpbiB0dXJuIHdpcmVkIHRvIFVBUlQxIG9mIG1haW4gYm9h
cmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogSGFvIERvbmcgPGhhbGJlcnRkb25nQGdtYWlsLmNvbT4K
PiBbcm1pbGVja2k6IGRyb3AgY2hvc2VuIHsgfSwgZml4IHdoaXRlc3BhY2VzLCB1cGRhdGUgY29t
bWl0IG1lc3NhZ2VdCj4gU2lnbmVkLW9mZi1ieTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxl
Y2tpLnBsPgo+IC0tLQoKQXBwbGllZCB0byBkZXZpY2V0cmVlL25leHQsIHRoYW5rcyEKLS0KRmxv
cmlhbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
