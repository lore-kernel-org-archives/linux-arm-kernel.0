Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C622C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625E820837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyrQhKNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625E820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSVYx09/jVjjvO+eCF13wl6KxhYcL8k5nsgQTsDtm1I=; b=PyrQhKNzvr9IGR
	BGysu9zpQTIuh2Wi8MBwv1EhKmvgreongdjcltTl2Vk/YeFYK1MFBtsLdi3Ulx/62AixCt6tFFxug
	TD8FX79d7uutYP7kH8/Pl8ZV97qUa7elBWv7JeRrFvpPTx6vxiWH1QO3gduvule7+81eezjdKveak
	+JM2ncVMI8TSUg29Vf6rW2J7GzSuaGrYNzOfIUoEm0RxHveXiqnAjMxK3OLBfuHBF3yBdfc1t64H8
	3qS1IsvpSC8rLeh/jURzlW8ly17CM6YKep6qqQr7ormeAgX6+fqD3jy3N6PKpQK0/BLV3o4RSN1Kb
	3BHlf+qDbSa299gAh46g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEy0-0005eS-B7; Fri, 07 Dec 2018 12:10:48 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVExw-0005e1-8p
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:10:46 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 6AC8013F8C2;
 Fri,  7 Dec 2018 13:10:09 +0100 (CET)
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: WIP: UFS on apq8098
To: Evan Green <evgreen@chromium.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
 <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
 <7a7ccedd-c6b2-6789-c76e-ad2ddcd53e2a@codeaurora.org>
 <6b8898b9-a9cb-8a72-0c73-f8a956cf629e@free.fr>
 <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
Message-ID: <bf10cc14-75f0-05b0-dea7-cb19beef5d5d@free.fr>
Date: Fri, 7 Dec 2018 13:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_041044_500156_8244A448 
X-CRM114-Status: UNSURE (   8.16  )
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 17:45, Evan Green wrote:

> I'll throw my random thought into the hopper here. With one particular
> brand of UFS part on SDM845 we needed to make sure we banged on the
> ufs_reset pin before the device would re-initialize fully. My hunch
> says this is not your issue, but it can't hurt to make sure this is
> happening.

You might be on to something.

Downstream handles the pinctrl nodes, while upstream doesn't.

$ git grep pinc vendor -- drivers/scsi/ufs/
vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:static int ufshcd_parse_pinctrl_info(struct ufs_hba *hba)
vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        /* Try to obtain pinctrl handle */
vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        hba->pctrl = devm_pinctrl_get(hba->dev);
vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        err = ufshcd_parse_pinctrl_info(hba);
vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:                dev_dbg(&pdev->dev, "%s: unable to parse pinctrl data %d\n",
vendor:drivers/scsi/ufs/ufshcd.c:               ret = pinctrl_select_state(hba->pctrl,
vendor:drivers/scsi/ufs/ufshcd.c:                       pinctrl_lookup_state(hba->pctrl, "dev-reset-assert"));
vendor:drivers/scsi/ufs/ufshcd.c:               ret = pinctrl_select_state(hba->pctrl,
vendor:drivers/scsi/ufs/ufshcd.c:                       pinctrl_lookup_state(hba->pctrl, "dev-reset-deassert"));
vendor:drivers/scsi/ufs/ufshcd.h:       struct pinctrl *pctrl;

$ git grep pinc master -- drivers/scsi/ufs/
/* NOTHING */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
