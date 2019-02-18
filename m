Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B51217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RaTFxDCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B51217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=swhiWidR3lc7tfXGsZNHLKpwKQcJupaUnVKijhw9tNU=; b=RaTFxDCE90li1g
	snnVeikJt89GjRTP07ZOPqedhN940exJxLOXWisPHK0d+ROvJKIVk5HPa2aPFV6QORWv2hdbzefe2
	OiN9N5NJJoXHqL3gYaiMfJMV9s5S94Cq7lUtePrt01dkfmaEZnZIF7F696bt5SArzRxWMnRWXQxnP
	TVTAwwcjJLGrG9JjF3YWKsjA0/0+9831W1Qzfe4b0D0ec9KMT+drAnyhM1xM9YCDqtSgtvcw+Y0XM
	liBLQr5l3rG2ZQHMu8Vr0DpVkfa/nkJ5J/Bi1fhV/7pmQOKgSA+ly0MJcNa3BvD7+1LRjajPlOJbf
	hI3GiMijsQq0t++Ac0yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp7i-0006TB-W5; Mon, 18 Feb 2019 20:02:43 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp7c-0006Nc-TP; Mon, 18 Feb 2019 20:02:39 +0000
Received: by mail-ot1-f67.google.com with SMTP id s5so30325563oth.7;
 Mon, 18 Feb 2019 12:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9sN1PzQyGZWC4Lda8UzrAJ1dy21aR/IgJKNfZHpWfdU=;
 b=tXyElEdyuqhKfmcAATpmRK9vYVhC/+otyDoY3FpV+m/+4QZybDxJuwVtsEfGtQKJ0o
 DNufiU5xam/WlwAajZ3A1F8GWohfty0o/pzKj7Uby1AkSmYyPJ1D8MoeEdX+bYx3M78U
 Vzy52rogYAfmnu+ojgmLBve81IZ9tm1bVeV9n2uRKPLtCqElTXTr2XJ+4T3H8fXLfl5q
 ZMCXbEmK4kTaVR8Eplrfq62c5dpUNYX0gRQJAkWDSTovAifcu6KUhUJ1o10GAuwEPKdl
 ujQN74kx88uoU3mLSoTx8mUhTou9J63OX3ynwGyDrjz4sHuQW58fAOAoIZjZLvyCQRue
 CFVw==
X-Gm-Message-State: AHQUAuakOICISakD1X9alCL6cNN8598DwF2tvDHGeNPBuqb7qDmLa7qk
 xU16xPuW4dyCo28pSCidBQ==
X-Google-Smtp-Source: AHgI3IbiyoqNf9hEcB4xNlZl6uUdFBC5ktBT4xQpgX4YFbENVetrJTXfqm7T4B8RQy43rLSHx7AWLw==
X-Received: by 2002:aca:c7c2:: with SMTP id x185mr329197oif.25.1550520155890; 
 Mon, 18 Feb 2019 12:02:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d10sm2680085otl.69.2019.02.18.12.02.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:02:35 -0800 (PST)
Date: Mon, 18 Feb 2019 14:02:34 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: add G12A AO Clock and Reset
 Bindings
Message-ID: <20190218200234.GA31723@bogus>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
 <20190212162859.20743-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212162859.20743-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_120236_987498_51A135A3 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 17:28:58 +0100, Neil Armstrong wrote:
> Add bindings for the Amlogic G12A AO Clock and Reset controllers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
>  include/dt-bindings/clock/g12a-aoclkc.h       | 34 +++++++++++++++++++
>  include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
