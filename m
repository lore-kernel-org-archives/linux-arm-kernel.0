Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC6C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB5D20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/Kw9fOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB5D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eoAMT/qcDnIM9W+0BvFyx6Qt180ceJ9oZHN73IGs8wI=; b=W/Kw9fOtO7Jm54
	XZC+Ra2noX2q1PyF4zUoj4B16HnzACzk4dnY9G4aC2HOUT0M8ZpcEPMPnH+W5SEtQdO3OiykZpzoW
	wF7qbIvHpLkPq0e2nBeS6Y7pgZ7JIH8h33/91tl0h9kCotVbKTblljvVdk4uK5hpKqgvpKxODgqQO
	VlRlE9E6LhhlSD7Ll2osOvfJytP0BzIG4yHKlOSHrRUkDyJLBaLBf0GPeTQrJfioMhyhoPsHsllr2
	cASVtM03yVwXk2OiMzzpXKJPhNxiQgr8/yCpeNRoZ+SMS95aYQmwabVUBUlnZY7xXzBB/1UOSyCtA
	hfx6oe0vXFEONjtWJNCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbrd-0007Il-Cm; Mon, 21 Jan 2019 15:51:53 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbrZ-0007IP-QE
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:51:51 +0000
Received: by mail-ot1-f68.google.com with SMTP id u16so20896869otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5cJlApinZk5e8sSAj3t8iwGI2cGG0qydhmxq62sYzTA=;
 b=doYwHBYO+mThW3p4lzwNUNky/9aINhfrYKH9tkXAa2uGqAywYqIglMg8RaMPT1we2y
 k2L3tsIQ6d6jUU0p26DEV+9PSw3jT3c+lNQzBgqU8qIi25c/oB0sYOGC5DIgS+CE57Fv
 D2HF7PSzHyiB9U9PUnMO8ibSxCyL8MRTDtnQ7byGTRgsPg3LBqMbsVHBsQOVKsmfOInW
 tYVtYatzm2g1xLZmW8q9ox/eQ0rqK2sSWlaJzE3CE3kJgVdP8CgdK1RYDE5wl2e98igj
 +/dGVbXcIN3yXp2D1GqkL0xw0jKDnMbGgk0Se9F9ISNWCnRBVCYH9I1mPn0n8BdcBlst
 brbw==
X-Gm-Message-State: AJcUukewUOZMgIlKGfZS2gT3lMgfIla8bJUmM1hRSVei4ybbc+c7vzRT
 3k6ve2X5mgnzz5RnliHChDFTweA=
X-Google-Smtp-Source: ALg8bN7KtxifRvc0HqhQ7yc83zGASGeeCs9aE8wKqVx8oavdSiDB+4dsPqe8mwwNTZJZ3j8U/fXyKg==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr18658363otj.296.1548085908597; 
 Mon, 21 Jan 2019 07:51:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a12sm5801438otl.39.2019.01.21.07.51.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:51:48 -0800 (PST)
Date: Mon, 21 Jan 2019 09:51:47 -0600
From: Rob Herring <robh@kernel.org>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: pwm: kona: Add new compatible for
 new version pwm-cygnus
Message-ID: <20190121155147.GA7190@bogus>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_075149_845244_9479A341 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
 Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 17 Jan 2019 01:45:13 +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add new compatible string for new version pwm-cygnus
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
