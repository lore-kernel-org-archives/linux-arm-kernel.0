Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78D821928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zydk7FV2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR5soJNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78D821928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HaUV0Htj8R1ysEcpZdo7gGw7j/M2VyTB4SVEDpHcyEs=; b=Zydk7FV2b9M5GA
	QBHqRA8+kPPZT2H5OEuQI4DO2HHGPWF8VefvYTXLv61tZSxu4f/LMrD52V1zYTvp22hOzkA8BABCG
	nbiurqEs8Iv7FvVsKdaD1ghS4a0EdZ/1S0c1a667NcxEKhCpYJpu3N1PfAvFhfHHgVESxzbBu96j3
	gQ7s7B+Q+lLA9C8Y4bmHEzLlyDfhNtOpS5+QAXE6B9V5dFsU2dZrMiZDd1K+yDiJSUq2Le+PtAtY/
	7HlKZuvm05WhPfitHtNTYzc5t/3+ZdUB0HSWBG0ZB0Rt9TL4lTQRTDOJ75HCVwBIJr2ab91YjVEVQ
	JzTQfJ3LETk7yQADf1hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKIy-0005AN-Uj; Thu, 14 Feb 2019 16:56:08 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKIv-00059t-Lt
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:56:06 +0000
Received: by mail-it1-x143.google.com with SMTP id l15so3167303iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AGa5YP8yQspqwchtP1mq0Y6YPWG3uTOaM08OkWNe0PU=;
 b=eR5soJNanPo4XY4wwUyLGcI6VNF1BvAH6trErQV1wzdHIPro/Zr5oiecJSSC9XdQb4
 a4M5x7mrKz5RJJpCvqbKw2HAJ78EdOq2SSfWcFbmz2Jyqi7E7gyzHNTNxco6o5j5QiGX
 6HdUz8nWAqlyoJtWg/WSVYKGJQzxWy/HfLaJCzcq1GQMwdNoL2Nb9qNEAyQvDafAA/YS
 sRihSuyHFyJDyF5yLohyEVXRaoKW1Cdgcbc0BdBliwUDYVB4m5GMvyz4hqpa0I1oVkNH
 0sOzE9fCQIiW9ia5a3Q8nl1Mw5xGC4MLrsP1SqGCBD6an+hda9Pjmfu5l8wXGU9m9bRY
 NStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AGa5YP8yQspqwchtP1mq0Y6YPWG3uTOaM08OkWNe0PU=;
 b=Ft/WELBSs5yN81zcjyTnbElAf7DQhGxmWCrf7g9VeiCm+2qXYkTy1tjQPvZ8ylToOh
 daZ74oWZf9uJZOmQUISJWkIoWubFlyEVPOOFUHW2haYq48nFoR0zwvvtKb1FzyH4ZYSz
 VOqqE3UJdy1pLR4Cvb5kns11V8Y+0GmcrurGLvWcm9nznaSEizh1uMii8PUedswDbclv
 pKGFlX3050xels5qZYYKj5sKZmAj6R15ElOtMdMb1Zn9EmNJaESNogB49VzvlrKRMVpK
 /Tydpnyhb12RPSwQ+VJ4EdynrGxlSL8aqMnRn9Z61jmPUBbBkq0834hJIwK1kn3Dx1VX
 WwlQ==
X-Gm-Message-State: AHQUAuYFbJ82tG94K5Pz3t3Jf3kpQi/KAJn3bTH3izzIbiX6U6gGLGD3
 rnc/A99xpITTFSdh/eyn9U6P6V8XiMQpT3Yq4j8=
X-Google-Smtp-Source: AHgI3IYLw4FVgCbzeEQEiRhx/pAKxUhrIjGr0Dg9VHyUf9hFFjbGWGQrjYlWH2Oa9Eu572t3ErWwL9zHfTkbDqFI1/I=
X-Received: by 2002:a05:660c:250:: with SMTP id
 t16mr2419733itk.78.1550163364772; 
 Thu, 14 Feb 2019 08:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
In-Reply-To: <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Fri, 15 Feb 2019 00:56:03 +0800
Message-ID: <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_085605_733331_1805ABA5 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SEkgTWF4aW1lLAoKSG93IGFib3V0IHRvIGltcGxlbWVudCBhIHRoZXJtYWwgZHJpdmVyIHRoYXQg
aXMgbm90IGludGVncmF0ZWQgd2l0aCBncGFkYyDvvJ8KCkdQQURDIG9uIHNvYyBpcyByYXJlbHkg
dXNlZCBub3cuCgpNQlIsCllhbmd0YW8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
