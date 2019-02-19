Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:55:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BEC21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mzyd4OE+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJJeF7px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BEC21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8PehOXU8J9R+F+a8+1VSoLB7lY9vgXAjcYDoYD+HE58=; b=Mzyd4OE+fs8PBK
	XWu1zrnQsjGjzSO34Ma4kuC9dBrvt6TfRbdpFld7EYM0dYN3pLkQgaXj+y0hNPKzazB0T2BFon11W
	u+6vem2OxjblmkMfd38JZk4g3RGr+3bicMzgMwbJUdlCkWi4wo78eB6jM8pA6NophlSuJ8/VAMsiq
	BMqFIZh5tsXp610jC3CVmLMDhz3846tFRlfR2PcUJ0mGScozn6W2+TVNAFR0rT6hf4O/Hhp0y0/j6
	rw4XLMyG6VQFDbN4J6EBYP1jcV3s9II6lsvAfGEC8FFXOxXAilGDfICWEwoUWD8dXrUEzvTuL9P9P
	8D1yAvCpFIX8ra2ZL/xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwFED-0007Ey-HA; Tue, 19 Feb 2019 23:55:09 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwFE9-0006Y0-IU
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:55:07 +0000
Received: by mail-lj1-x244.google.com with SMTP id z25so11339669ljk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XvAitqVF8YTDJoXqz+MECJPCjC0B0qtBCBm3syoZ1lY=;
 b=fJJeF7pxmhyxP5CMXJYWqYUgN8BQY7QRE8dWdogXcMMuQjawDaKEBbGQzjmCrEP68i
 Iq/3EH+VwQT5qWqcNNkysB7EFHtuO9t21eSbRI0ZukDb/r32Seq1I/7GHcznOmeI+z5A
 FGm46KPQixrj+ejLOjCFQ8yJqu51F0Frv1o4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XvAitqVF8YTDJoXqz+MECJPCjC0B0qtBCBm3syoZ1lY=;
 b=bmsk4C2eK3DY7fIp2Z+A7JpLfu74KPfGdShBRM0C5PIzKo3Tmc3BsXuoB3xkMVkmUL
 wdI9M4zPMJ45veRFugvwzmY78CJJkZO1R9fMRupaGZr17gRIea1F009/tsNHSmwwmkpU
 w6r+agAr7XN96pXib1BeXT4Od2jXpxEhDC1jOd0nhQOIY9HlMXaAFF5kSRnw8nWhhK2N
 RAVUNKMzxEoEryWGROpLUMf4q+SgzWuLy5icIpWNB2+bGDyXl5Js5E3+CDnGCinJ5UIt
 9YN9gGQDlF16lsLpCkdfq88F/9ExoQS7DCr+4Q7chSAn+nytRHGHce97HYiTY3aJSzJZ
 UYVQ==
X-Gm-Message-State: AHQUAuZQ+dTpOSKcqnNx4e2b0dWdOT3OR+yHT1rBAlVtwlgo7Y9rQlg/
 X1V33BXI0/hnGl6ZgnCE/Y+XKg9Qv/4=
X-Google-Smtp-Source: AHgI3IY0KnprCGrGWifI7ia95oYoq6u9ReJVMma8DtrJzdqTz0KFnCk8/xPaVwSEKChp5WZH987hsw==
X-Received: by 2002:a2e:84c7:: with SMTP id
 q7-v6mr15385908ljh.58.1550620503221; 
 Tue, 19 Feb 2019 15:55:03 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id j27sm2852146lfh.67.2019.02.19.15.55.03
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:55:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a17so2857387ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:55:03 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr2704106ljj.30.1550618970718; 
 Tue, 19 Feb 2019 15:29:30 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:28:54 -0800
X-Gmail-Original-Message-ID: <CAE=gft5pp7sUHM8P3RTeFPdY-VWVLwLM6=abS6FffZU4WSOd8g@mail.gmail.com>
Message-ID: <CAE=gft5pp7sUHM8P3RTeFPdY-VWVLwLM6=abS6FffZU4WSOd8g@mail.gmail.com>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_155505_646727_227D2B2A 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:06 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch adds decriptions for mt8183 IOMMU and SMI.
>
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
>
> The mt8183 M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam
>
> All the connections are HW fixed, SW can NOT adjust it.
>
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
>
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
