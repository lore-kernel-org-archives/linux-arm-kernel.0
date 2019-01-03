Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A674C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383E32073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EqKCIEOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FLVV+2/uiEb65HRMv1qAYBYRFJ3UqB5GjA7pwjBgwOc=; b=EqKCIEOQQWNpnq
	AN3ENyR920nc4BXi04Xoaq0wZkNZaFFM8QDtgYisV7lKvxMaQIJBi8quUHOeFY5FMnXj6oWsdwmXZ
	/mbrr7f8xb4y0hAVLLI+v8rSA4jgvs5H/lYeBmP2N3f4uR7Z+jNf9eb805yZ0D591vMzhyVrW1T9A
	XM2dLOI0UaK1sxe3bs50gqtHuZhJLd3ocV3fvm/mtCT0GAQQ4yNt+jGbZPaGar9ghXj+qVgUu9isb
	jBxRVcwNN1kFXO6bcMmc5KWu3vkMCa/cd4pCkhkaL9VSbnQCkj3+9tF1LZ5PmVGOuarPPV8oUE9Su
	YW2FyGfG9LpD7MFUeZ7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gezva-0001zB-0B; Thu, 03 Jan 2019 10:08:38 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gezvW-0001yg-QH
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:08:36 +0000
Received: by mail-oi1-f193.google.com with SMTP id c206so27331681oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 02:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p4BMsPmNVulD2wJr7uIl6oF25NRo2H9JNsEVVTR9rSw=;
 b=diMN+phPMxb8DZtqkOEn/jEFufuJjGwG6D4nD3QNI6WFjxqMed88Ujn3szFN/cHbFF
 1rMDnWnontV5YOsMDWmIuZHHzIt/2keItjxjM5yYhYq8MbAx7+Qe1NWrP3KJeX6nUKme
 f85zjKKNKtbfc/pll4gF5eikqn0U845mDR/qBpFNM3F8FYhH28ihBOB+3kiuhheOrT2q
 RLSvWYQPrGC9cEyN9dRF9CUlO7S1Wz/KSG1SOxHLv2c4+/krhnZuL3gY1LHA0b2gqfz9
 bhKTLh74GaHscOiEtXLcZaoUlGvR6coKRh5cbOUYtrXxqyuTU9YpYxIufWBsdUcvuzSQ
 ec9A==
X-Gm-Message-State: AA+aEWYPwCGEwcPs/lq2W6HzfEDa1fU9JM9wtayZJhIsox0q2RSlSACw
 c89p77nYpvBZlXxfsiGJ8Zr/PKnzYiPkj5VVEx0=
X-Google-Smtp-Source: ALg8bN7YahUbk4q0shL2kXkYHr+/V8GVJveWujGxaRriHrdh0dSE4bsshFomaZyBgQ5XJTb59+cHu9w0foHxT5LHLxM=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr32426394oia.95.1546510113851; 
 Thu, 03 Jan 2019 02:08:33 -0800 (PST)
MIME-Version: 1.0
References: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@epcms1p7>
 <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
 <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
In-Reply-To: <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jan 2019 11:08:22 +0100
Message-ID: <CAJZ5v0jAkCP62Vj_G_Eq3wG=ZfdO_NtM1vdAO-HQNovnLSMTMQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq
 suspend/resume
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_020834_853267_3E554311 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "anton@enomsg.org" <anton@enomsg.org>, "krzk@kernel.org" <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "kgene@kernel.org" <kgene@kernel.org>,
 "ccross@android.com" <ccross@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 4:08 PM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rafael,
>
> Gentle ping...
> Please take this patch, it got ACK.
> The other patches have been taken through MyungJoo's
> tree, but this one is actually enabling the feature.

Applied now and sorry for missing it.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
