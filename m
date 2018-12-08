Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D0820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8vubla6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTE4fFiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D0820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XqedLBJPvUk7V3JLl774BMpm+t1e4VKfx7AHVydQ7CI=; b=R8vubla6PriZoX
	YPg5egGbyODfjgxhLowNImO4whM9e4Cx+4nzKsjRuzNpS74rZAdyc1PbGOabltYQZ3WLO+jQdN08r
	eE5FXofCZOLOUkYakRdurQwcF3ATfLjlHxJnVsA9HHK108+py5TxT8Ff7QfsCHwRWhG9nLQ4vk8pR
	YVYd5B0TP332jdtyHA4Bbq1OO7kdv0SQRHqZpSZGMsf98BkzsyD8r6qjc0TasK9EcJvBBa2+pF7c2
	WXXtZqjGDSM7cY9S1jcnbO4zfqqczKVfeTFWyQqeU868XkVBM75fvd7iiKtd7rvGVOx8WKSVsZbnT
	f5jrEDvPiYNZSUAyP/+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVbME-0002oP-NU; Sat, 08 Dec 2018 12:05:18 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVbMA-0001g0-Jx
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 12:05:16 +0000
Received: by mail-ed1-x544.google.com with SMTP id b14so5788895edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 04:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=upJ4W9sZXaJvX52jmKfQ0MU6kTlF2DPCYP7RKfK3vyk=;
 b=JTE4fFiF/IaCbl5cD3qvnNTNYXu8pwCgcEOmiBC2HiFRRhUxImN+ED6Zvuvc2j2aEn
 2WChYj+62MQGKAJJ2Nbm4E5pmmpu5a/XT1MGNVV5+jCrIbTXBdUGbec9zpVN7fVcchSF
 9LzmYXbgg8ZNFOKNP4+2fhWLv29ZSErTwP7ePNa20IWA9UyHJjmuVNsZIbOzeXhgYgzR
 o7UXLVU1YbeCkF/amxyWgEBv79ZSD44O/NVdpsHorPpgpLlYRpALMDek6uf6cK0oCrqw
 UZf6H/V3NKAyBD7Khdr0izpc9jHMtIiS0ZzSX8blxmNM7wLV7OIclp2q9mxvaza7+8mK
 1ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=upJ4W9sZXaJvX52jmKfQ0MU6kTlF2DPCYP7RKfK3vyk=;
 b=Qb8nEQClhOVsLFpXkKcUnh/Jy7wPJ9572eRTHOTuH1M+T2C8H36vyKkO8KPRPytkbh
 7+HlOa6O5W6eai5ABxjHYvROwR7awRckZDOSUPb5El8yLVr5zwJdMsZ5exA4tpHCGURy
 R8TWN13Ha+xG7iBNW2pdaobvfJQii4ufvnbiiHw9kaX7kI8FOAQwBEiC/JZNm42cCOTO
 tOS/ErHULd/ZOXRNsYDgjXSeUfBujNP7lKJ13v0PrzXZ4eoMnynIB+SyGhbUK83uSrEF
 0NTG7AtCRNBwvTEJVM0X2Ro97d0+yaycC9ybeM/gevDuSuP+D+QBzhhqvncyMw7FCyDx
 UKUg==
X-Gm-Message-State: AA+aEWZTiyPrn/fH0sv5YHunXC/HpP+Ss6+hasfOGl6pBgvQ/su3AVGp
 brPv7O8DD02UJysi+/cudOnotQP+T5BwBeTZ/AU=
X-Google-Smtp-Source: AFSGD/X6SMQXPVPAjgMXuMWPZRs7MbPz43K2YnqoRZGjIpGqgvcnIpKI7d2yqiduV+JYxU5SFlHrtpniU68zwHkQmTY=
X-Received: by 2002:a50:9ac4:: with SMTP id p62mr5338602edb.179.1544270702165; 
 Sat, 08 Dec 2018 04:05:02 -0800 (PST)
MIME-Version: 1.0
From: Lei Wen <adrian.wenl@gmail.com>
Date: Sat, 8 Dec 2018 20:04:50 +0800
Message-ID: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
Subject: Coresight etmv4 enable over 32bit kernel
To: mathieu.poirier@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_040514_660459_8656FE82 
X-CRM114-Status: UNSURE (   6.80  )
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
Cc: leiwen@outlook.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
And I am following [1] to do experiment regarding the addr_range feature.
The default addr_range is set as _stext~_etext, and it works fine with
etb as sink,
and etm as source. I could see there are valid kernel addresses using OpenCSD.

But while I try to store one small range of address pair, which contain only one
kernel function. It doesn't behavior like what said in [1], the write
pointer would
grows rapidly with the read pointer. And I dump the etb buffer and parse it with
openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
I_NOT_SYNC.

So my question is why ETB continue to grow when there is no trigger at all?
Is it normal? I could provide more info if you need it.

[1]: https://wiki.linaro.org/WorklingGroups/Kernel/Coresight/traceDecodingWithDS5

Thanks,
Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
