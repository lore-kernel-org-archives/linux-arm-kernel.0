Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE43C2F43D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA0420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqgMSe5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA0420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lk8lsLBi3G4jM++qR5105LrO138WvmGns3HnPKkbxaY=; b=qqgMSe5z3Oa2GG
	WllNCZdVY1FIiT/LJw2MtBDr7X0RotaaV3qaeD/Tgtu9NmvHVn21hZYirJuwPF2T9YZGQMXIaeJha
	3AkAGTj/KfTTJv3OhJA/ox+wfxpSBs60UNzxKbGpzO1LKTZNJfeJEMsSj7/waCitCz6WlPg3/Egbj
	SbvOs8OvPIVz2PfWecNMdFBGB1c3KJnT8LWc4zjLq8NCpKVWIKNkVWyb8SVvBLlmLUjXAZLyMM0ey
	m8XBcYVdUMIByWlgvhB9YHqJz8Exfnk1dgYRE7KmJ/Z4VKN4kk3inKowGye0W6ALEbFC5m5ajgYvq
	C1uxFaPbBrNllOPwZY0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbjZ-0007LE-0f; Mon, 21 Jan 2019 15:43:33 +0000
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbjW-0007Kn-3e
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:43:31 +0000
Received: by mail-ot1-f50.google.com with SMTP id v23so20864890otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8r1bE/FoC++ZCZLSs0NmJddaJqyjiHBoSZEJsiuyYEc=;
 b=XcBQHG/M811l9hyut/eNXSH65HnbDq+W2bP0lv30/XYHZILc4PvyqhHQcsEszwy2yA
 PZ9a1mw1NDgk8a3c1XCa1GKhS4q36BbA9ELFR91Y4r2vCVINXBS0Wk1ie/Ty4wAmmR/M
 W5gZk77LX7XnynWmWKuq9EmTr4bG4iDDz9933mpRRUJCN3yIQoc1DOk5rl+09MeQy1m3
 rCxkdoJR7iMOrqHBM7TO91CLUK36CJ7x5nr45ovjFkJe2itHOL6ag+lHTEY3rldWFdJ+
 9MryQ3gted+XKA+idPFudrOyFBUDt0XrvLcZhOgiTyQJNelr5kDdFzckTxL8BmoU6hZ4
 OOmw==
X-Gm-Message-State: AJcUuke4vVu85d01cMDqkxsJ2X/UWsJL7VTfWGNeKMt+5ZCKY5AkWoPe
 a05yhAdlbzyNqNwX4oHdog==
X-Google-Smtp-Source: ALg8bN5oXfJ02mRJTc9uX3lwhkgXWiiJVbFrCHyK3mpn6swhk29hu7r1M6riWIQ6iff/W1vF0l9sAQ==
X-Received: by 2002:a9d:7597:: with SMTP id s23mr18429747otk.370.1548085409141; 
 Mon, 21 Jan 2019 07:43:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a1sm5362923oto.71.2019.01.21.07.43.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:43:28 -0800 (PST)
Date: Mon, 21 Jan 2019 09:43:28 -0600
From: Rob Herring <robh@kernel.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v3, 3/6] dt-binding: ptp_qoriq: document "fsl,extts-fifo"
 property
Message-ID: <20190121154328.GA25901@bogus>
References: <20190121104143.46782-1-yangbo.lu@nxp.com>
 <20190121104143.46782-4-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121104143.46782-4-yangbo.lu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074330_150968_840FD661 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Yangbo Lu <yangbo.lu@nxp.com>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 18:41:40 +0800, Yangbo Lu wrote:
> Documented "fsl,extts-fifo" property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Modified binding description.
> Changes for v3:
> 	- Rephrased fsl,extts-fifo.
> ---
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
