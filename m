Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47857C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6B22087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gstn64fw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY/7NrM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tcSVJ1sY7KrRQ8fAiqJ6UvfuimKnxSaUq8zrcmGBUkw=; b=Gstn64fw1+ivjI
	c/fyfa49oQ13/S5uWt+sgTEJiaB+Cg0r5jB14THTSYlLaLd8USOJmOPI+1b5vKRHfeaqaE9wlPAdj
	dqLGZ9ry7Ic3jw/be8RLUX57brHzSUsXP7mcihfUAa1B890epC2lJmnBXulVlW7HmW55bTKGmtr9v
	plHVUFpiTiHMT/+06RBzxpTK3chAegN6SQOV4A0G9EMWoaSFFpIfgvCz694rCmkkolAeVA/5duIFO
	fBsHtoLxNDRIS/aCfRB+qi9T0uNVxbtL7oDg9uJiiCOtoi9qF0Up96sASY+Q0gNnpN1tzrLzCwQtY
	lA6sgOdEY54yL/vRifiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLPf-0000PS-1T; Mon, 25 Feb 2019 18:55:39 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLPc-0000P4-4n
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 18:55:37 +0000
Received: by mail-wr1-x442.google.com with SMTP id d17so11119338wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=giJy1kMzcY3WLSpkxWjWbbjfE7h0U68/r8WSJhwCy8k=;
 b=dY/7NrM/w6DytL8DulIXio+AbeNzxA9r+ww6UZx/fdLsN8IYWs/zX18pS2a4Gklci8
 NTfFjuI7MZyORcsHedWlvIzuV/SZZTA0EEJJIzxQ64WWoTblIu70Zut3BzbuwV96Lxn1
 ZKt/OepQ9YpSiC39PLYczSFTAGmwKYkAx4f5k243vLMTd306MiykSjXGI+45o4KxYpvr
 nSCe2gvPC1Objtz9sK6S3RI4M3q8G47dlJaCq99BgnC/4B70E6GU+bzkdM2upD3mUQfw
 VJKkj1SetVF7KNi3qyXR8Zbr3NklQ469kytKr3uMSn80Dhb95veKXLeNi/oGc7PArnfA
 i0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=giJy1kMzcY3WLSpkxWjWbbjfE7h0U68/r8WSJhwCy8k=;
 b=WuQiC5Xy7EnRpv0VrQ8/lawsVRVti8f690bgF/PaAq8DqaxYEVVDqGuUwyFS2AFWAe
 IVkz4d3Sd7ihf5HSRVqgwH8jps25pFYb6qvVNkqcJksyVVhfHPsYRVgVNRc3E5GRYRFD
 /HmbnBeS6H1O+8qU76RP3+xpoOtMQ3RmDvAhd+MKmXaKI/nqoEsM9k7Go+9ig8jp7R6W
 LSzTg3BzZ3uJnPQss35gEcv6v82oAvF9UVSl/CGVfewT0I4298GeIFuU/JKAWFtif4rz
 KPmS0oFWKB6Z+aa4l/1wjQmDomlCmC69jjiHgarMWeh1TuLe2tp27q7DbGE5It7/j3lB
 k6SA==
X-Gm-Message-State: AHQUAuaC/0JJNb6Sy1iqvj38JMXnaI02taKwa1AHn79tNhx7bnwoJbKq
 Th6cTVbe8T6Y3+HrLyMo0tfN9z3PjzhpUyfMMzY=
X-Google-Smtp-Source: AHgI3IY4tfdkdsQoqfagtHyOGx+7Hg5Cf+SOj48lsKY2D0fw2+ZFYIlNLYerItgeTvKcRexWc3z9u6Btu8lO3aXy5SI=
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr13504622wrn.13.1551120933952; 
 Mon, 25 Feb 2019 10:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20190222122147.27132-1-andrey.z@gmail.com>
 <c4fce9a2-2d9c-ad0a-8389-cea795af9f74@kernel.org>
In-Reply-To: <c4fce9a2-2d9c-ad0a-8389-cea795af9f74@kernel.org>
From: Andrey Zhizhikin <andrey.z@gmail.com>
Date: Mon, 25 Feb 2019 19:55:22 +0100
Message-ID: <CAHtQpK4oCoMKKcfH0wNm_QMg5LaQT=GNSMzOz9FbzjBrEF8cAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga_defconfig: enable support for large block
 devices
To: Dinh Nguyen <dinguyen@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_105536_179920_1CBFFB8C 
X-CRM114-Status: GOOD (  17.66  )
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
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Dinh,

On Mon, Feb 25, 2019 at 5:35 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Andrey,
>
> On 2/22/19 6:21 AM, Andrey Zhizhikin wrote:
> > Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
> > hanle both ext3 and ext4, and ex4 requires this option to be enabled,
> > otherwise the filesystem is mounted RO mode.
> >
> > Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
> > ---
> >  arch/arm/configs/socfpga_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> > index 08d1b3e11d68..b4b387486cd9 100644
> > --- a/arch/arm/configs/socfpga_defconfig
> > +++ b/arch/arm/configs/socfpga_defconfig
> > @@ -21,7 +21,7 @@ CONFIG_NEON=y
> >  CONFIG_OPROFILE=y
> >  CONFIG_MODULES=y
> >  CONFIG_MODULE_UNLOAD=y
> > -# CONFIG_LBDAF is not set
>
> CONFIG_LDBAF is turned on by default for 32-bit. So all you have to do
> is remove this line.

Thanks a lot for clarifications here! I suspected that it was the
case, just needed a confirmation here.
Is it possible we would have this config option enabled for
socfpga_defconfig? If you would agree, then I prepare a separate patch
to have the "CONFIG_LBDAF is not set" removed.

>
> Thanks,
> Dinh

Thanks a lot!

--
Andrey.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
