Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E86DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C885B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HC1nL1Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C885B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FsQoAhCmzya386G9sUH7T28mvcS8YRPwzlyyWRZ/3hM=; b=HC1nL1SmR02Oyj
	iUqOC0s3Tna/sLQsl7YeAuJAgTGfLEbEXZe6FUi2JS2gVEaofhZ5uh05v6PWyqxCTJq3mIHjNWrAH
	JkQUW/CKKF5eDPc3i374JzMShMhhxpkKbMpOW8OfmbLNTuMS+NFLByLfuvlgTZLQ3HRwxLsa0fL0D
	Uioc7dVbVzpHoXApBMwjGzXTcRzVLXaynYpOBCz5xIprSOqggVSKP5mclOndcLZxhbeVSxwewR0kb
	wbGHU+1fRuuX2leSRDvWLguHDbIFEpoM8B7g9og13oJyWATsdvVCSQ6whk4t9Qr3Qqwk8UGSfbBJR
	qM1S69cnHchC46S+RLXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyGR-0003WG-A3; Fri, 11 Jan 2019 14:58:27 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyGN-0003VU-Pl; Fri, 11 Jan 2019 14:58:25 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so12434040oib.0;
 Fri, 11 Jan 2019 06:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ds23Kc4NbLJYAPLR+KmNeecEzQBYJ4yctQTt7YXJ13Q=;
 b=nYQPRrO4LTce31QGSGAIjvWsZa8n7zpAWwqUjRLi9Oy2bN29lh58JkkdWQ8RLpQle5
 8eTinB7TRJycXNexMRLaIomobJRuEdhukXSCbtfUmdlH/T680qyFKYb7V3n1gVgVu0FE
 ARMZBYehEOuwk33dr8t9JPhAnoCJEGb0ogNw9SsIERqLMnKY7vW03YFgE6i7se6+3WFM
 AsHraonoEYs7UsygU7a1eTdYXcAo3ZXQmZkV+bp61rzYNAE675Gk+DvcNTgBMwy05N+o
 brojM2hyKMebBtkET/66/a+uHR8Qov6GdE+xOaM+ynHgoL9ChG+aRroc3vgH7sMHF04G
 5Vrw==
X-Gm-Message-State: AJcUukfMBEQf7Jt9GF1Fx7u3w6OpNBEge4giFxcf5nCfQod3HIY/1wtG
 ZtOFSJyyZSyy7FH6Py8JZw==
X-Google-Smtp-Source: ALg8bN7ds9LSvRfrJD7MU0qK2pPHyEmsatuDj3+W6hbmoC1qaq1dlOr/UVD+djOSk6uc0RMct8cHOw==
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr9687526oif.173.1547218703091; 
 Fri, 11 Jan 2019 06:58:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t8sm36295060otp.69.2019.01.11.06.58.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:58:22 -0800 (PST)
Date: Fri, 11 Jan 2019 08:58:21 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek, larb for
 multimedia HW
Message-ID: <20190111145821.GA32150@bogus>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_065823_832972_06AC217B 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 1 Jan 2019 12:51:04 +0800, Yong Wu wrote:
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
> 
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> I guess it should go through Matthias's tree if the patch is ok,
> thus I don't separate to different patches. If it's really needed,
> please feel free to tell me.
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 ---------
>  .../devicetree/bindings/media/mediatek-jpeg-decoder.txt          | 4 ----
>  Documentation/devicetree/bindings/media/mediatek-mdp.txt         | 8 --------
>  Documentation/devicetree/bindings/media/mediatek-vcodec.txt      | 4 ----
>  4 files changed, 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
