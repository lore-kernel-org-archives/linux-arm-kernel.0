Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EAB21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f8uuNb0I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS/yiuRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EAB21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wHyMGuiKNwftAPC8IyWMDSZRfpY6bJ0J5L4ddE2vCBk=; b=f8uuNb0ICexZ5h
	OIqUJj0y8BndhMyQQ5gJOx67FZobSAtMWx+QGVFeORaiHTjdSkBV27QPqGi1SLw4O/LzgkSda0NdJ
	3g8BAlsaf6khf7lDeJ1/SNbNypaeomR3FeQ/TRCNfIynuvKtfsNi/TTCUaJo4irpq1lgeIIVXyy5X
	WtcUr3iDeu+KFHbPtbiRNO3cRY+WjhVfhE621aonwz5jUwbp/b4a5pLjO8xyx/6/FuqXvTdI4XwO/
	lpzCIr9qrg6EpKX3qlNmDxfafYJygvw2k3BkJiQKI6Z4VkNUyj1WQnyTB/T7jzR6Z+FjBH9FD1bD5
	w48eQbqvwTGHFyp/CX9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGu4-0000Il-4U; Tue, 18 Dec 2018 15:03:24 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGtq-0008Se-NB
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:18 +0000
Received: by mail-pf1-x444.google.com with SMTP id z9so8267478pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g+PXOceOUR7U/rQANrR+vw2A964XlQSf8XMtPCKMYHI=;
 b=VS/yiuREOc8OeuaqUfIW05DBA0mGj+sRt5yGJNaUKLAnV+1tASE31acji8rxx5iu/g
 WPPL1nyUBjv6bhpKgvJ8q6ObDIf3fuH5zgTvFFmdWODYtwfYKHnv8xPyLgD/6nB82jcB
 uvzC8SlEW+sEJZiNiLqOiR64K2+bHTLkag894=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g+PXOceOUR7U/rQANrR+vw2A964XlQSf8XMtPCKMYHI=;
 b=npdozEQ9nWZqrieQ8yxM+GclX/pnzTzHembIjFF/MCZIv6oKouAQgdXbrNNQ6XYpiJ
 pZT7RYEG72YXjEgz2bOb+O8v1LSmnvIAkbDeBcu1GeCm3W0rksFY0lFb4Jmu50pWX0t+
 H1mfOCMcLPJ57UQG2QGCvNAUUdTRDDpsNQ2bnzaB9GDUU1zOlV1GAZOl53CRu9otnszS
 v+clHqJcmuRSHlK1O+BDv0lPaGIhEemShK+IiKBMDNH4y2CcJZAe1CzHa0C6+kk+FM+k
 LJX6w3ATSy5o+OYWJ38NLosg5hQqthnqQ6N25+efAz3nmPPSXsbD5P/tCmE8vHxe+hUG
 jT0A==
X-Gm-Message-State: AA+aEWZMatTUrSmmU1Kle2/75QIhVkOsBU9O0iIrG37OHyacn379HPe6
 Ew55sC1fSmsYQknH6IC23yo9
X-Google-Smtp-Source: AFSGD/UlRNA2nubwSWRzd8OyLINe5DM0EYTgNrrYuRaVzUV1RGPfDkzhU+T2dvJYCXYhuMbjxJm5Mg==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr17101796pfb.55.1545145380020; 
 Tue, 18 Dec 2018 07:03:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.02.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:02:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 01/11] dt-bindings: Add RDA Micro vendor prefix
Date: Tue, 18 Dec 2018 20:32:28 +0530
Message-Id: <20181218150238.23010-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070311_330559_BC37A419 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIHZlbmRvciBwcmVm
aXggZm9yIFJEQSBNaWNybyB3aGljaCBub3cgbWVyZ2VkIGludG8gVW5pc29jCkNvbW11bmljYXRp
b25zIEluYy4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5k
ZT4KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+CkFja2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CmluZGV4IDRiMWEyYThmY2MxNi4u
Mzc4MjZmYWM3Njg0IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdmVuZG9yLXByZWZpeGVzLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dApAQCAtMzIwLDYgKzMyMCw3IEBAIHJhbGluawlNZWRp
YXRlay9SYWxpbmsgVGVjaG5vbG9neSBDb3JwLgogcmFtdHJvbglSYW10cm9uIEludGVybmF0aW9u
YWwKIHJhc3BiZXJyeXBpCVJhc3BiZXJyeSBQaSBGb3VuZGF0aW9uCiByYXlkaXVtCVJheWRpdW0g
U2VtaWNvbmR1Y3RvciBDb3JwLgorcmRhCVVuaXNvYyBDb21tdW5pY2F0aW9ucywgSW5jLgogcmVh
bHRlayBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ29ycC4KIHJlbmVzYXMJUmVuZXNhcyBFbGVjdHJv
bmljcyBDb3Jwb3JhdGlvbgogcmljaHRlawlSaWNodGVrIFRlY2hub2xvZ3kgQ29ycG9yYXRpb24K
LS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
