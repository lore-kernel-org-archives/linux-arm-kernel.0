Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D443BC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:22:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04A4218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TawMyyUC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zJ/3CJwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04A4218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TiAhaQ0bEVP/RQ1QPkgm4LgE/cAfj02YAwWKApmRsA=; b=TawMyyUCyh5dEV
	9ktd3uPUenRl3svz654JWce+vP5WBYiP2FgKTUN0faVRDZlpeAf8Z3/skVcoBfNjysyl4HgMzkmMW
	zvYxgGFH4v8VGq9GLZ7ib+RmZiIqo/u6Fgm9Jdx7/HfeIL06AO4yGH2fwnWTOXUOYInWoc4n9wI/Z
	zM4f3iorQIiBTQQ/Lomb1Hk3Ov9VEsTWYNy4KmGWk50DFNhUorUKxCada6JgXpMTuLLEFQct1HYkY
	WM1iP9xNvkoo5gvJbmkU/xwyFyNbu0CMSrfUeHSnI3Ls/CKZN962O6n100XQ7QQp9CuzhoSFwb7ko
	IItWWpH5Vevll8FUFhhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTKl-000751-FR; Tue, 12 Feb 2019 08:22:27 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTKi-00074S-RZ
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:22:26 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8MMwZ018051;
 Tue, 12 Feb 2019 02:22:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549959742;
 bh=2o3vTpwb1kX2SiD5UgKPrKFcr4aM/xnh1ySeJCw2uHM=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=zJ/3CJwZVyVvEwZzW8MmA9gF/QyMBNHcOtogMYpe7N653XzXPNalVL8QrLM/4gKOG
 lqKrrDT29LCpd5wtPhUGSVEPNaPUn7kfvOqDfhcFWHeXrLnLxRXqLNxKwXc/e9YZLP
 BJi18EBW5JW6SbaCPrKB+RR7j0zxnpdM9gayNo4U=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8MMZQ125960
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 02:22:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:22:22 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:22:22 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8MJtX016947;
 Tue, 12 Feb 2019 02:22:20 -0600
Subject: Re: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the
 legacy API
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>
References: <20190205094937.18645-1-brgl@bgdev.pl>
 <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a5c3ddd6-b7f0-d313-3ca0-54ed014858a5@ti.com>
Date: Tue, 12 Feb 2019 13:52:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_002224_935750_69E560BF 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/02/19 6:11 PM, Linus Walleij wrote:
> On Tue, Feb 5, 2019 at 10:49 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> In order to drop the hard-coded GPIO base values from the davinci GPIO
>> driver's platform data, we first need to get rid of all calls to the
>> legacy GPIO functions. Convert the mdio configuration to hogging the
>> relevant GPIO line in the da850-evm board file.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to my v5.1/soc branch.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
