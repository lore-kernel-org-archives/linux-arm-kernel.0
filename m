Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F00920661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3ZlOYPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F00920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VkIZGgwf+F/3iMInvik54SSRTJANgrqc/BbkuWI49ko=; b=S3ZlOYPxTiO3wN
	R4mt6H5wnALzZoyYT/Q8w/Z94vwPrjDN4d99KCVU3bH1dTNXG0byzsMkiwLKvCxAzr7UOlsEDODvV
	gMYwk2dWaMkQuNG5N2EHhcOBYONmorRg1yeEaMud/46Pluj6kuAObO/VIf519S/ZKpuAr93/EuFcK
	Kf6tjc3BxuSwDeTaq6Syd9txTdIysHq+pqBLhgYImdPaJNEpppFk1Vbt5T2fBzmBiUn5PmhUPVAqW
	OftWKN3jMjF8WzV+/ot+hVDN0sOA0YrL8bZBIJuXZUC8OOWwEEorW1yKloac4jJfbxFnQGktZ5wb5
	j/4/MGXkzRJma3aaNAYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIu7-0000YK-M2; Wed, 09 Jan 2019 18:48:39 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIu3-0000Xn-6o; Wed, 09 Jan 2019 18:48:37 +0000
Received: from oxbsltgw03.schlund.de ([172.19.249.20]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6H7o-1gf86O3zLc-006jA9; Wed, 09 Jan 2019 19:48:28 +0100
Date: Wed, 9 Jan 2019 19:48:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>
Message-ID: <466961447.54433.1547059708278@email.ionos.de>
In-Reply-To: <87va44ftz8.fsf@anholt.net>
References: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
 <87va44ftz8.fsf@anholt.net>
Subject: Re: [PATCH 1/2] soc: bcm2835: sync firmware properties with downstream
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:26xH0BEK4USMIuHUd54n2YyqDq5vC/zfAjZBWh37vb1/MSDv4aB
 l599WO8CgphwhJp+N7A/ZiE2J+6YltW3a4CcPsY2WbQehpsZepGH7O2WdFg1XpZIWh5VF3F
 hTuTCOOnVgIT5wkvQfrbqLmwNg+lpJkPHHnRMve010KvnPHgoBmdMfvTADknd72dEK82RKq
 Xs212W8LP4hOEHAeUlzaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9l4iPA03H4Y=:frf6Ej2cgOV4GDB2pLIiWR
 gAiczR+n1dRSGwypXBATcU8iRJwNEbCV+8Haxz9KjQ0ESumQSEhWmJBFdmRFN93s+vC7TgXAu
 hitXMs3QE1Pg2rw7ssLZ2Sw0nCL+vZhY3JlvdeCsl+ybKhlX2lkjYFj3TJ3iNsHfKeyVWOgGn
 qC7NlZW+JIqhUW3qwzbBZCNFq/iArb5Zl0kxva3P7iBKZxlHst3hPVI0JMimFZw+FIG3dWnsN
 U7D3A/67m6Tyr1R9N02fOIXyUGypwk5acLB5ihToNvbyFWvTa1kYqLQuvSaHVkAIY6gyBVuDR
 cxwUMdtNl+f8r+xEwxXczPXf8o5k4Xgw9OjLLfPnMzUPUPVpn6v0HEWEC0nEfEEXhbjpEYK2m
 7JUFrt6U+w1leIXczd/TsalQAD048v5SovHcAftj6q+cByQtGdwmCMqJO8jflMUwqEDi3T71T
 fh96hiv3Dm0+vMC2ZKwHInUQyoe6e/dQG/SuLH9FcZ+l1X5z4cKS+wFLIZ4kj/INJrv+KAHqu
 RLSMrjXHusWLjQo5WHMpOav6G4eyJYCuWLxe+BK3+KNBf1JYah9oghzuIA1rVJXlkZe3ITq3+
 0jZohCrokfR95Qq8fhaoxsYtw+O40YW50v6z+ewTqn7dym8sMxwdKWpT6qOEP641nwTdVHM9x
 D9qJw2QM07gNj7FklFziGHlmC3zHS62Y2DAaWDCLBvKU5h429tnsYNFzdbs1Q98Lg7OHBReuy
 ZOb9qx0MiaWz6aMs8+yPdLzaKpXl60j91v5j5TRj5erTHSmp6LKTGnKpZW4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_104835_548357_AA00B8A4 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 8. Dezember 2018 um 06:49 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Add latest firmware property tags from the latest Raspberry Pi downstream
> > kernel. This is needed to use the reboot notify in the following
> > commit.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> These are:
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-drivers-next

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
