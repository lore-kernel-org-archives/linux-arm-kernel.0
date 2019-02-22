Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA77C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D83C2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qb4ueS+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D83C2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KD5KXWY/rNMkH+Zgx1CuGhCj8NIxBMZsBZQV9+YBwFA=; b=Qb4ueS+sSwiUAn
	SCse8EiJQO+fyNNpF/wETJzMPkyEqfLOEcmCeBKZqUVTfVy8+ArcRUTc3VDuYgSMdwb0tnPM79Gq2
	JKir3H0FXiTJvAbIi8m8zVWBYgOMMe77VkdfCxN59fWvqb/GbBjgEtotHK0xk1PqEImXzPRCYHQ99
	TDJHKQt5skxOeEHcMj9BHp0BBaS4X8yIpv7+v1s5tfAX6CPfGKEBwV7QNGK9T8KaEuFQBiMe+FAKH
	ueWIUUHCxwZnfnVo0ggRQ1vv5TSzbLO+upYxyCTyK7ffFNmu5SBS07Rn7Y9Tpaz0Ew1pHkwkTh6yB
	o8IonNw+7ngZe/aTiTTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJms-00034z-6p; Fri, 22 Feb 2019 22:59:22 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJmo-00034a-VS
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:59:20 +0000
Received: by mail-qt1-f195.google.com with SMTP id z25so4385373qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ef2AjZ1q6Kd3Xb1MbrH/SxRpY6H7RFQJEgFL0o5tOyM=;
 b=LiSyYBk/KcNLDcVvUrKYsa9YDWxgz/mErnJ2pTY+uE4n+tpVej8x1MLpuQ0bEkECB4
 TPmPKZmW9mba7/kMSuln23eYCGNZ777gUaE8Rq4k7kqu/agXfifQWKkPxdI8Y3ZCr2z5
 5sogGjdiRS8f3JUwK06nBYvinFhBSvCRfPbtmb2UkR88pWX8NU8exBhGpJglDLznpPuO
 CfdHWlZPi4sEHxkAHmyV+wBejIOxyzFRdHOsBJB3hdqR8+keabgYtyv+WvyW1gw2YMup
 tpmGQx6XT64us9lYB5OZOtTm6Ob9c7/0qiTH4Gae68WKMfcwsu+mBiVQTuaAd9+8NISF
 +dYQ==
X-Gm-Message-State: AHQUAubV2TrXFQDDA4DRE43SxxybtY6x93ZBJgDU7OwmNAwVtl+d6+xD
 cpGQXV6YZHJ+3bQZOy4DsNionGfSvNtKMJRkY8I=
X-Google-Smtp-Source: AHgI3IbFszIB+iE0lXDaRcs/TVcY9LYdIS/XgHddkULm1e2QO59NflXeD5LNRLEpgSyi0JO62yY6NrT6ZCYVpt0wYpE=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr4971861qve.180.1550876357561; 
 Fri, 22 Feb 2019 14:59:17 -0800 (PST)
MIME-Version: 1.0
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
 <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
In-Reply-To: <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 23:59:00 +0100
Message-ID: <CAK8P3a1V4zgtC64yo-8wn5UCtDpT0B7nCr_XCWQ5X56k5ZSvmQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
To: Khuong Dinh <khuong@os.amperecomputing.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_145919_012616_76E6A227 
X-CRM114-Status: UNSURE (   9.05  )
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
Cc: "joe@perches.com" <joe@perches.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Open Source Submission <patches@amperecomputing.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 11:43 PM Khuong Dinh
<khuong@os.amperecomputing.com> wrote:
>
> Hi,
>
>    Do you have any feedback for this?
>
> Best regards,

I've picked it up for the SoC tree now.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
