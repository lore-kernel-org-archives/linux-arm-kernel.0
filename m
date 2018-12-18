Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25269C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:19:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EEB214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NweTw02q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUA8CghS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EEB214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uXG8JJF7ZLt0RKi3cUS/xh6/rB2acj0tVatVM19cQCk=; b=NweTw02qK0r4m8
	PHCc0MAsEfTlXEg986pPOfkHHGKYwr4ce9pnUuGtXmwRNlICcSuT/JiWApq27CYLGHKnDlco5gsF4
	SpRo2p6DYVIQLiDQfM9S2N0+hrjnkNdkTDhfkKOdIWAUyYw3SyY9THEQ5TuuVqRcneV1nYOUKjRIy
	3YK3yNdKQisa6yZWgw/2MxJVPPd67RyKROsmXm2qWwnb/I/PAAvbkzWRUaYtX9Kgj1feAarNwfplO
	yEjkS/lJYKuHoPulg9S+ZbuP2iNp0x+wcqcsTotvkfnmvew8WzTNUBpzhVICGRm+LEA15Sf0auKVs
	H3vmzaozgUx5vuu/K/mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAb8-0006aG-P2; Tue, 18 Dec 2018 08:19:26 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAO9-0007d9-Nf
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:07 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so7428959pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
 b=TUA8CghSP+7HrGdLnbar8fZ477bOwyppf+zSVdT/+D8IlxEaCfCoRdSota1f+qYDlm
 L+RCg4ozkswYFCh184d2BWOW8zFn38ZMD3yN3yq0Rsk5FJcP2S3xllk3ixUZQdojZZvV
 ky9vRpnL1oTApb+yDYAyca0VgWUjhPoaWMMiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
 b=ag3vyjo4GMFFleEuzqDpMnBGQXYVF3Unsi5rknmqiyPDJHQxEP6pHqNmdUmPtOLzW+
 NcXbPNHzXDZF1v6vJDnyqdP7BN1hPgzKVdw+D+zt1Uay29ZqV6UiXp3a1Eu5ZOjDI53Q
 l/yE4j8/dGuNXafrGphoSnbyqVHSy8VKuIKS4foNY4MXIPR10JBjP2eWbbbIRqBu2FvX
 RL/v/A+T6WYflp33sSo3yuQS3eDHaLpeP1ivSs0lrKtghENkPaTApcA0SJvyevBRI2GU
 aYSqU2f6sQEw5CgzpXhMSm4orA4oSci0EM1u6q8dFYYid/5b3LdeP4D4NywA7VkQiBHs
 TYsw==
X-Gm-Message-State: AA+aEWb+A1sc1ylzP2ytgdpBY5lBh8/6xVLPY1zsOreZRDoviL3LXvl6
 kauIfFRxCclhugu/tn3A3e47
X-Google-Smtp-Source: AFSGD/Xj+yIt+l4wPKbQ1v6bgulp2QO9ETSS+/s9mDaHVU6SqQoCHhX/JUn1Bg61nEwvULSthzJyTQ==
X-Received: by 2002:a62:8096:: with SMTP id
 j144mr16046934pfd.140.1545120350918; 
 Tue, 18 Dec 2018 00:05:50 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:05:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 01/11] dt-bindings: Add RDA Micro vendor prefix
Date: Tue, 18 Dec 2018 13:35:17 +0530
Message-Id: <20181218080527.10801-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000601_972829_80CF1C3A 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIHZlbmRvciBwcmVm
aXggZm9yIFJEQSBNaWNybyB3aGljaCBub3cgbWVyZ2VkIGludG8gVW5pc29jCkNvbW11bmljYXRp
b25zIEluYy4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5k
ZT4KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhl
cy50eHQgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQKaW5k
ZXggNGIxYTJhOGZjYzE2Li4zNzgyNmZhYzc2ODQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CkBAIC0zMjAsNiArMzIw
LDcgQEAgcmFsaW5rCU1lZGlhdGVrL1JhbGluayBUZWNobm9sb2d5IENvcnAuCiByYW10cm9uCVJh
bXRyb24gSW50ZXJuYXRpb25hbAogcmFzcGJlcnJ5cGkJUmFzcGJlcnJ5IFBpIEZvdW5kYXRpb24K
IHJheWRpdW0JUmF5ZGl1bSBTZW1pY29uZHVjdG9yIENvcnAuCityZGEJVW5pc29jIENvbW11bmlj
YXRpb25zLCBJbmMuCiByZWFsdGVrIFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3JwLgogcmVuZXNh
cwlSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uCiByaWNodGVrCVJpY2h0ZWsgVGVjaG5v
bG9neSBDb3Jwb3JhdGlvbgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
