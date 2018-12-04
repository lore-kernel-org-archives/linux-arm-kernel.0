Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98DEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD27D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J+ICNJiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD27D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oH/SzhSKY0xcnpl0qSKRkrOKCmGZX3kd4F0RkSxf5hE=; b=J+ICNJiAvOimkE
	TVBL4Pa6WMJQDqUMd0Piv/vo0TWzZERu1Chu0JK3cY7yaiuGbn7lqRadnjRwJy/p5YgveC34ptXvI
	fDwtbhQNH+DdiX1Mzhdm1hbYDYHAgDwrzGDyIAZi21H5I7mjGmN+9mqAsHT+TmhH447CAw8KDCFvk
	4Nz3NJEuP7CeN+4vybiU3rOuHX8LHUBswv5GPRb+kXz5mQInmLnc8BSGReK1dmt2oWX/9gi+6pfQq
	VVsdClfsXx7mgl339veeJ6wo88QE87BbpXCn3WQKPh2qqEr5BtndysVUv+pDi6VtyoSdDhkfr63+5
	Rbrx/Vuoewtdd7nFJrQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFK4-000180-JG; Tue, 04 Dec 2018 18:21:28 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFJy-00010V-Qs; Tue, 04 Dec 2018 18:21:25 +0000
Received: from oxbaltgw37.schlund.de ([172.19.246.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M58zc-1gT8qv0x0O-001Aij; Tue, 04 Dec 2018 19:21:01 +0100
Date: Tue, 4 Dec 2018 19:20:59 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <1382521023.341849.1543947659588@email.ionos.de>
In-Reply-To: <87y39d5czn.fsf@anholt.net>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
 <87y39d5czn.fsf@anholt.net>
Subject: Re: [PATCH V2 7/7] mmc: bcm2835: Properly handle
 dmaengine_prep_slave_sg
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:YF4hewuibrCGvxG/Bu1gCnNeiiwPBGYXYNhVyW46Ynty0Ek94Po
 MhPDzelXSUmdGzu77IjvM2JAtBjyXnGgHSFsH6qfr6ghkVWIvdPy1bg/tiDo5vWhpU5BfVb
 3MFkmMY7NCddIFAIA+gOYFNafKRVZRdr3fJ6gDAaaj0V6rgb865UrGlmWVB0GXzITsm3h4g
 VSEmxLLR6a8pTmezEspWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QkaC1LOpew4=:H7qb/VZ+H1EfSFpH7gstPA
 HaBzxS618aT4HsfjNQeT2QV5AmeifWWv1jGwyTEoUpZKmlPgRAf2EDZ/cFSha77X05ehdixyw
 5nxUDCR3UWOv03A/eVIoMPjx/esI0ou4zNkyoIbckLUhpcrKCBFy7+ezY5wfuAp8RJLRJbTjX
 SWMoUkm0Csyb8V9QWreS8aLWtNmUAzvhS0JPrWSoZ9aoLM03oSWRf+eQUQ0vYeT1lNf3/n3/X
 KmYN16khZkhVZSKyd9WpktMFCdr3NFnXemzbJkKkTBXk9AhM0nIHpkjrSic3dgLB54n8kGcqe
 qJJZpw6v2uiG/4oAGL7ybv7OcLERhumiBCWbidHAru+LfLhgnehqRIQc2EknYXhrgtmqObLZ7
 fw+tWNQDAxo3/gYugbjXqNHEll8akcQ/9dFn5HzEBc1y1ZXZ/zXmnRE8gogUz/3s6KNnMIaiF
 kI44tKL+HYuNHgDLAXs/gAIAMRapxPNP9G/dzDpv/lFT7DlE7YAE8aCDpQMJf8pBHs+Czc2BY
 51s+eCmGFCLVd4kwrnwINz8rjwHTjMTm7qS+EhgsJtMj1P1NGBGpbABJO3djVMt6QbEGYXC8V
 yZ8Omk187Rlsa5ajZiTO6QlEf3SsAHvxOoJfMR8t8A5lbe1hJQfeWdayIGBjpTVuu3TAGh9GS
 a8dXDRaSeQPiuJo+IrZvdwjQa8Rt32U1RmmUrunTFJ74B4gZe0lAXjFyo1tyA+3kCwogePB5N
 XzHpKyOMx4zJ4eeJQH9EfOtJ2BgdtuwKITxpqO6vuyCgzIWxbICh5Wb/Uqo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_102123_333572_ACB564E4 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>,
 linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ulf,

> Eric Anholt <eric@anholt.net> hat am 28. November 2018 um 18:27 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> This series is:
> 
> Acked-by: Eric Anholt <eric@anholt.net>

should i resend with Eric's Ack?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
