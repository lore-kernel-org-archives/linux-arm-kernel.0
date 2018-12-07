Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDBC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:16:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CDE2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cbpA6xXX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U25NSF00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CDE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nrIFjl2isoEFPGSDiW4sJvIqY8MQLVPXE3V0wv2ezjI=; b=cbpA6xXXGrmCPh
	luQLcArCTwZxMSIr8mOKbNf+NFaOOt4gYJ8vEQrkllA31RJEcDZlYjAXF4AhHJY0IkXMhLAjOSoFb
	JKluUb6Ekrma5fPSK//Zi5uhZvGCPNcfg/ICLnLebbB7S/v6bTizDPl6ZiETk1cNfOAtduOk5sUfd
	5vrq0HqwuaBpAJhn7R1bXIbRcodI476KnkK2QtPLQRe5cMlAnPF9819+EhhLsWCiYkDechkezpuGr
	7qGz0kOaVA5uqPZWVEnjQUdSoiAVTv49IHoWfRBlftBjrQr0rvWlmeFB1lVyNUblYAlSGPI0NJDtG
	AUw7PC3KaIwfzVi1LajA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJjE-00032f-Rv; Fri, 07 Dec 2018 17:15:52 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJiv-0002lM-NB
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:15:40 +0000
Received: by mail-lf1-x136.google.com with SMTP id e26so3571039lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FOoBqBm6/h6OkJGWwYaUfJlWsiK14J1dPqY93kVgwPg=;
 b=U25NSF00bVFLrCjTbrKYtqoe9y4LcgyGKNDtIAz2cxTTIXWu5Jb8AkG/JlaSObt/P2
 dQI9wF7MJXDqsmSLR6vN4I/dnL+JO5uYwaHRf05eBrOfOzHY9/mTenQkbQ482MdtO4El
 JKHHMk47FisvpwQbiP+jwNFFpf56R06xmVuIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FOoBqBm6/h6OkJGWwYaUfJlWsiK14J1dPqY93kVgwPg=;
 b=g0maLIZvOqiWT8nqDx1lkipL5I/Kq40Sj7xXrAWZFyCfjiEhR13dOszi47+0yER3vF
 Rt1o11/V2VjgX0grtzrQC/zzt3V99jzUtGyIda7KtKw5iwEEaCsL41uwo13KywByVynN
 I5CQbV1FDcFIuHhw12ECvqffTA/YYKPa/iMlFlettXWBr5B/N4idcqpi1mXWSjVaZwhU
 La2FUO2G5wBjbRYwlzcVXDjz87MatfcU3cIoHHktjnMSZLSDbkme9gCaT8hq5J+ejwHD
 rA3Q6OqfqZNxHcP1QI/8F5Loh/a8CfYG/gnz7WVtL/9UFtDbvT/ge9H0ohK8k5WRr7T8
 tntg==
X-Gm-Message-State: AA+aEWY1YulsQ8THds47dHKztZiZH5qv7z5QuRKva+T9tReFAwE8fdyL
 PhidYdVckzJCFtclfnQXYZI/v5g/EKA=
X-Google-Smtp-Source: AFSGD/Vy1zcYsEdycTEhDCwrKr2aoBRun0C+OMitHolvg9Vc6YmFav9IpGx39MnQKBmFmKrXczR3tg==
X-Received: by 2002:a19:945b:: with SMTP id w88mr1721539lfd.15.1544202920020; 
 Fri, 07 Dec 2018 09:15:20 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id c22sm696111lfd.88.2018.12.07.09.15.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 09:15:18 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id i26so3579255lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:15:18 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr1723152lff.16.1544202917806; 
 Fri, 07 Dec 2018 09:15:17 -0800 (PST)
MIME-Version: 1.0
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
 <bf10cc14-75f0-05b0-dea7-cb19beef5d5d@free.fr>
In-Reply-To: <bf10cc14-75f0-05b0-dea7-cb19beef5d5d@free.fr>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 7 Dec 2018 09:14:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft6VHtVZ=L4wnEpWHVDp6PmRftpmuyxgr23ZhrKWWE_7jQ@mail.gmail.com>
Message-ID: <CAE=gft6VHtVZ=L4wnEpWHVDp6PmRftpmuyxgr23ZhrKWWE_7jQ@mail.gmail.com>
Subject: Re: WIP: UFS on apq8098
To: marc.w.gonzalez@free.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_091534_623422_E8394777 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: jhugo@codeaurora.org, linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, nicolas.dechesne@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 4:10 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 06/12/2018 17:45, Evan Green wrote:
>
> > I'll throw my random thought into the hopper here. With one particular
> > brand of UFS part on SDM845 we needed to make sure we banged on the
> > ufs_reset pin before the device would re-initialize fully. My hunch
> > says this is not your issue, but it can't hurt to make sure this is
> > happening.
>
> You might be on to something.
>
> Downstream handles the pinctrl nodes, while upstream doesn't.
>
> $ git grep pinc vendor -- drivers/scsi/ufs/
> vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:static int ufshcd_parse_pinctrl_info(struct ufs_hba *hba)
> vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        /* Try to obtain pinctrl handle */
> vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        hba->pctrl = devm_pinctrl_get(hba->dev);
> vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:        err = ufshcd_parse_pinctrl_info(hba);
> vendor:drivers/scsi/ufs/ufshcd-pltfrm.c:                dev_dbg(&pdev->dev, "%s: unable to parse pinctrl data %d\n",
> vendor:drivers/scsi/ufs/ufshcd.c:               ret = pinctrl_select_state(hba->pctrl,
> vendor:drivers/scsi/ufs/ufshcd.c:                       pinctrl_lookup_state(hba->pctrl, "dev-reset-assert"));
> vendor:drivers/scsi/ufs/ufshcd.c:               ret = pinctrl_select_state(hba->pctrl,
> vendor:drivers/scsi/ufs/ufshcd.c:                       pinctrl_lookup_state(hba->pctrl, "dev-reset-deassert"));
> vendor:drivers/scsi/ufs/ufshcd.h:       struct pinctrl *pctrl;
>
> $ git grep pinc master -- drivers/scsi/ufs/
> /* NOTHING */

We did this by abusing the "init" pinctrl state, which I think gets
handled automagically. In our board file we have something like this
(forgive the paste butchering):
&ufshc1 {
status = "okay";
pinctrl-names = "init", "default";
pinctrl-0 = <&ufs_dev_reset_assert>;
pinctrl-1 = <&ufs_dev_reset_deassert>;

vcc-supply = <&src_pp2950_l20a>;
vcc-max-microamp = <600000>;
};


&tlmm {
ufs_dev_reset_assert: ufs_dev_reset_assert {
config {
pins = "ufs_reset";
bias-pull-down; /* default: pull down */
drive-strength = <8>; /* default: 3.1 mA */
output-low; /* active low reset */
};
};

ufs_dev_reset_deassert: ufs_dev_reset_deassert {
config {
pins = "ufs_reset";
bias-pull-down; /* default: pull down */
drive-strength = <8>;
output-high; /* active low reset */
};
};
};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
