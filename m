Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E5FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC3F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VpGvgCb7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3GXq7bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC3F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fgoHQGHVczjG+JyHVq5tKQKsBN0Gua+U3kcuGaIrCl0=; b=VpGvgCb7xaKkYP
	X5enITTHI/WXMx94eors1/4d7xdgvbkXHbSfsQsUdfj3N1P5bbetXH0KUAO2xwkM34n3+PRh5vZwo
	LchoVcYiL3JxGu6mvzNyDp9etM74vJQSkcaktl8Xa3QfDF0R1F/ti37tDd/aTECSL22HQAr5vN/6r
	wmvjmQQD4bPuPJRQF8oyjqCKbfjxG0Jt581fzYnTPnzG/9EK1M+ZOzvXU9drJGssoCMn3J9SZjtuv
	dq+Mor07nC0qe1a1Kk+AfFHB2ynK9NUBOWsbFu+DqYGz+DU6Mf3vz9X0AwU8XRbBqoUCu5AGPstIJ
	BtZQydE6wR2NOIKvWjDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWErX-0001Cs-Ka; Mon, 10 Dec 2018 06:16:15 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWErV-0001AP-2b
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 06:16:14 +0000
Received: by mail-wm1-x335.google.com with SMTP id y1so9573350wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 22:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=YCpIjC/pey9t7x0S3INi6bnwRsPNkYOiJUizFsxNObo=;
 b=h3GXq7bo8GhqZr7TJrTn+zAWC6rZV2HHuvjClZUSXIdiHcIveWPv0E36sWPAPmqBht
 4bq25g5Bmt1nYQ70Dq7Eq3O554uD9VK1Vl7hXuOm0MbRKGM9Buwv6Ld14YLM6PRYT1Gy
 LGTG80F4fRCb6dTa728nPgmNKXb/m5KpqpjgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=YCpIjC/pey9t7x0S3INi6bnwRsPNkYOiJUizFsxNObo=;
 b=SpFa/jEKxx9znOvL6ZKfbqpuofIgAbqhFlndFt4IbIc6NUqYBTFpfx8In7bx9egDF0
 7QpAYZEXilBDusSgxzC7jtU92Kp6XCGXVV+k5WAhSWVV5EXjRRRfB8MPuTkcIJxat3lg
 6FgpEdyc0n8gnnrAXPzqXT7LfsP5OCH71ueZ2+Lpsnsf0t4du7oo+SCY530bMDmpq+c2
 kBj3RO3ctsiCT1eDZxmj5Qgr71K/gcEKt2y2HNI/0elYqap6GuEvYJngdPXEpIcU79+q
 YVBDsIEAFDppVfcfFvHY1+VjN9o6MKp6Aj85OGK5X8MaIhbt/gs/mRTAiXLD7Y6B8mZS
 FlvA==
X-Gm-Message-State: AA+aEWYB22SrwVuD559CQfPcacRB+JI6aVdwOFjLt07vVwsi5oPVCRLO
 JkWZ45FvKLkalYxt90e7kVtQxg==
X-Google-Smtp-Source: AFSGD/VN3kKQ/J8l5IxaK1/7lseg16LjGcX9gQAHQkRnobqIe5OJqCOFulvvfE1iVOYJ1d5iiDHF5Q==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr9033693wme.119.1544422557076; 
 Sun, 09 Dec 2018 22:15:57 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id x8sm34258429wmd.45.2018.12.09.22.15.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 22:15:55 -0800 (PST)
Date: Mon, 10 Dec 2018 06:15:57 +0000
From: Lee Jones <lee.jones@linaro.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181210061557.GL26661@dell>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209063440.27820-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_221613_143188_6F9C0B6B 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
 matthias.bgg@gmail.com, chen.zhong@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCAwOSBEZWMgMjAxOCwgWXVlSGFpYmluZyB3cm90ZToKCj4gUmVtb3ZlIGR1cGxpY2F0
ZWQgaW5jbHVkZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLXBtaWMta2V5cy5j
IHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLXBtaWMta2V5cy5jIGIvZHJpdmVycy9pbnB1dC9r
ZXlib2FyZC9tdGstcG1pYy1rZXlzLmMKPiBpbmRleCAwMmM2N2ExLi41MDI3ZWJiIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLXBtaWMta2V5cy5jCj4gKysrIGIvZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9tdGstcG1pYy1rZXlzLmMKPiBAQCAtMTksNyArMTksNiBAQAo+
ICAjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pgo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4gLSNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9v
Zl9kZXZpY2UuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPgoKWW91IGFyZSByZW1vdmlu
ZyB0aGUgd3Jvbmcgb25lLgoKUGxlYXNlIGNvbnZlcnQgdGhpcyBwYXRjaCdzIG1haW4gaW50ZW50
IHRvIGFscGhhYmV0aXNlIHRoZSBoZWFkZXIKZmlsZXMuICBUaGVuIHlvdSBjYW4gcmVtb3ZlIGFu
eSBvYnZpb3VzIGR1cGxpY2F0ZXMuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBT
ZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2Fy
ZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
