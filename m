Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80707C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CD52192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvL4mmDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CD52192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ERcfzkyHwuoXovn6TwXNEvnEfD4AgYP52iYag8cphRc=; b=lvL4mmDgyIARlm
	5rqtVoM0uUNrkcp2CstOwfRKWDTvAaoH3dJC6BsuFt9LWpcPrQWjOjvhiTUWo2mo7Za3M4ODUznkk
	xl3al2WW8xUmNQ3Q9rApHnVdobEK0FuhDd+lji5MSA/RNoWOPym5HF096ndmHGjTafVS6431e3j5d
	xkxvFuQ9uWfWxxNAAGCmerf8X3KVebp0BWPArFkNYj+BgIBQMxIy3Wy6uL9bvITkOCkKNFuS6Ct7A
	EvlzKho5W8uXS7N+HamYNu02uyYT54nfkxzk7OYzQ5aKlkc7fox9HC41F9EutmaAmn/pnC2sPBY9e
	2WEniAniyO439QPheA/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guegz-0003Js-7d; Fri, 15 Feb 2019 14:42:17 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guegr-0003Ix-Vb
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:42:11 +0000
Received: by mail-qt1-f174.google.com with SMTP id p25so10803155qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHeiByyqppvpAPHd1dy0pr5ngtRczwVzajYPyO5noPg=;
 b=cZtLUAe8udDm+QmFd/3dM0H+aHtfuWaMPktWvYyiXN4JvvCfHewCyK3rE3w22UOrd4
 37MUVedb0AIr+YtuCjNlARdyLif467BK/hVm76kkL4BQBtCr/3eIVGPxejgcpRzJ6BZn
 hkPPw3L+KyvJRWmyokEZN2tvUcJzOHbQTUXmhzbhV2Y+WjXQOboWPYUNTrsIqWUgY424
 /5qNIVD+c2PWIPT4lwUZw3wC7VcxNSOEosvt52g7Tr+GW2mHeQf3UgQids05JDxX3l7K
 0JXxAd/n+n43ZJvvz7qxFXB1xhU6M5ZCLF1f2kjZH70uSU8zarEY2XArx4TlPlAUxQ9L
 n7lg==
X-Gm-Message-State: AHQUAuaMKMdnLchcV4ohKgSYHthdD0cdDeDumN0jDzRYam3uOgxuRLxL
 a+4fONP41/2CkERDuTiriTe9GxsiRISJHpAmUZKfww==
X-Google-Smtp-Source: AHgI3Iann4cLIT0/2KIGNvtHAbi33GQuWQqUZX+QXzATh5FvsIFZuCklS/ZqSSdgkPngRMi7lrlPRARGo0+b6QS95og=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7675030qtb.319.1550241728854; 
 Fri, 15 Feb 2019 06:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20190208102933.3op53lsvppizl6b4@flea>
In-Reply-To: <20190208102933.3op53lsvppizl6b4@flea>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:41:52 +0100
Message-ID: <CAK8P3a0WDqB=suJz1a59NzYYRStmKQeizuxUrLvDOLGMDkUUwA@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner arm64 DT changes for 5.1, take 2
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_064210_012237_116E770C 
X-CRM114-Status: UNSURE (   8.69  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:29 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Allwinner arm64 DT changes for 5.1, take 2
>
> Our usual round of DT changes for the arm64 Allwinner SoCs:
>   - Enabling of the various power supplies on most a64 boards
>   - H6 SRAM controller support
>   - A64 CSI support


Pulled into arm/dt, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
