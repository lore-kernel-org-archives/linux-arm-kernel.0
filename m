Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1882133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKX+YUxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1882133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xI18NPY3k14/wRHzpOTYL46ouRsZguoR8r3Wh68gn0=; b=qKX+YUxWZsPePE
	3MKCKbUlh0r3zi2WvyonZGVi7+5DlfQ03IP6fdDbT5W8F9mTRPsqQDx5P0IaKlGYuyKFctPCxKUiG
	R7jKoETyPlenv4qSH6wOOhEb4Tbrulm+LM6S/EJUva53CVMv8JtoN7zMyjfezLHIw21GwzYOYwVsD
	kuoWzgcyJn2BNY93lzj/4B8WaIPSBjVxr6zRK1+gtloYT/j5gd462OSMTj/iuFoo1dBY1BjuREi9B
	VW0kHC5C3N2/wCcfjZUXIU3LuKZp4525igR/47xZ+kDqKLVxnqprhC0jJdrYFwHUEtfeVYVwoRz/4
	sNYV5OakLtDyDSyRTUuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi37u-0007sy-JK; Fri, 11 Jan 2019 20:09:58 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi37p-0007o9-KN
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:09:56 +0000
Received: by mail-ot1-f67.google.com with SMTP id f18so14176477otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 12:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A5EATsKvEbWnAGgVmPgG/PX4c3EZhoHCL7F8x3HwTdM=;
 b=mgrsA9xCJmEatAAbkPPEw/zzDaPUg3FvrmYEPHwT5sC2pWy965C0SMi24oHM9tmrgc
 sLNzmhq5y4tl8mAwjTE41Hzunn7W1RxT5A9cSQlAlIoHvzfi/YEgEFKq5pAyYkHbXX02
 VGnVTmlbY3tBBvFE3jHm/GyFuoqJug1BtILHOVVP1Zkq25I1Vq4+BdqAqPFIH+UiOHhP
 +jl4i+uHig4y/4xv1PdyszvLWUzkS1mv7PeldQv1/N2y1OvwiFwqae1ZJulTm29gGC/K
 6gEOAw4SyKlu96G3tCssOo9d9M4O6OodMUHohO5xaRsOS2ifuLpTSi9wr5vqvE8gJE5J
 6N8A==
X-Gm-Message-State: AJcUukcci3xdjx5RhNohI4r16pFh+rYgmgEkUXBQo4k6FmZNCmXh0EQH
 sLYScQAY7ZJSlNYfNp7B0g==
X-Google-Smtp-Source: ALg8bN6QQ+o/4rIihUetU9vWCxLQpXpZXNc7NfBksuz9ssX0VWTdt7tQRljRdO0EKOiVNBM7lxDfFg==
X-Received: by 2002:a9d:225:: with SMTP id 34mr11164365otb.224.1547237392707; 
 Fri, 11 Jan 2019 12:09:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b23sm33599587otq.5.2019.01.11.12.09.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 12:09:52 -0800 (PST)
Date: Fri, 11 Jan 2019 14:09:51 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: Add ZynqMP PM bindings
Message-ID: <20190111200951.GA28752@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-3-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546638982-12954-3-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_120954_134834_ECED351F 
X-CRM114-Status: GOOD (  10.96  )
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
 Rajan Vaja <rajan.vaja@xilinx.com>, nava.manne@xilinx.com,
 michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>, rajanv@xilinx.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 13:56:20 -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP power management
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
