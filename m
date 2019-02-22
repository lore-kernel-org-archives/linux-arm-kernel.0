Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B06C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C682075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o87LcaAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C682075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wNOzpqJ7/O2oFuqXHSWlsQOul1UkBjZcFSNCe5dYocs=; b=o87LcaABloStMj
	j+UXfvL7xXMsfocRM9h5dvWEpsH2AXNSKJhKVmVx9kzS/yv+HcrC4T/NrNHol7Cgm8+wa4nOQSCH6
	RxtW++maSfwraoyB1GrGjdkow7v3twy70vuzjhWl86PQ26yDVuRBLiokg4z6iPkK8Jq+wU8cRqsmu
	8FNODkGIxn+BCDZ6m4tfxvEP9VeOBlNbhaMC1gWi+O3Gl8TCfsaOUSQAOrKWRdoQr/0cGS5aDABzP
	GTyfgDBO/i2GHOKUMaAJ4HbdjoTUVbca+yf8c2m0+0Cpx9hmyVFz7nE10BUm8mdYynWAyl4rOXzPu
	VI6VHPKAF4cUN0c0gRAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBzG-0003Iz-Fb; Fri, 22 Feb 2019 14:39:38 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBzD-0003I7-Nu
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:39:36 +0000
Received: by mail-oi1-f180.google.com with SMTP id e7so1850491oia.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 06:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nu6VebetlhJ9cLzYds+vNaZz+y5MqaLXo4Gpxoo6zOQ=;
 b=OTz/fCOL1dvMbEp1ynmTuOZRfeFTtSKDDtRQJfxGTE8py4U4sL3uSdhD9FT2McLTHM
 OwE85oIk4x37+qPoX4gLsTdCVlpVkmYywxIU4gUmm0jcV0YnEsVBqKJIfJRQpI3JahpU
 WPZ4pwCPDQU3JTqE3ClyfgaEzVUE7AyWEaC6IUpwDkBcd8zceK7fSKS1p2QrzwO2mnvr
 dytjKuceKWzJOXDCKfhblRnLzTExfnZ77hqkKf8YlTzGGDcy4qCYxY8YdkJ7ZQ0f79kB
 Lkxdnk7z2nKkuass5oNSOXqzYG6deFcCgFQeOiPyo1JLG826qS6wNy78CfsR5/ddkNkT
 hZDw==
X-Gm-Message-State: AHQUAuYk3zf6N4RcnN9P7tIwdAteyz9TPEGb7UmyQvb0mtmZlE1lC3fS
 MP0LNGxWSTmBZamwI9wIcQ==
X-Google-Smtp-Source: AHgI3IbxfDo6Ox2SU+yN/pMzkTo4t/ym2gfG9I+6DU8kSSPB3lLT0VdDR7VD9L1uicny/KC1cKkfcA==
X-Received: by 2002:a05:6808:315:: with SMTP id
 i21mr2776517oie.114.1550846373286; 
 Fri, 22 Feb 2019 06:39:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 81sm639149oti.27.2019.02.22.06.39.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 06:39:32 -0800 (PST)
Date: Fri, 22 Feb 2019 08:39:31 -0600
From: Rob Herring <robh@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Message-ID: <20190222143931.GA17132@bogus>
References: <20190220085607.31582-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220085607.31582-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063935_771223_573AF99E 
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
Cc: axboe@kernel.dk, mark.rutland@arm.com, andy.tang@nxp.com,
 devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-ide@vger.kernel.org,
 robh+dt@kernel.org, yousaf.kaukab@suse.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 08:56:05 +0000, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V6:
> 	- no changed 
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
