Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19419C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BF9217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UTBuhvjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BF9217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s1823bK7KDtIZyogUpjZwV68Aj1rpGTBebRY7QjX+aM=; b=UTBuhvjORuSzz9
	InUcMGGxx++dfsn1EZU4+fvQcR4psB2QCR3t/SopEK5AhoGxSL3lXKXSKIwWnjbK1tU7AcHywQh4Y
	bvfEvetcOPNEg41TMhUemdVXhPkJb4KOuKbWLYTSFQ1QBvZ0dInOV4ILFEW4cpJd/Eqb6Z/ga6s0U
	o+SJis31ImTQdXcdglMkoGvDCL/WZZdWbnrmmrVLf6dzwiHb9svYBmAsryDZ3654fRlj2y8zLyQbA
	kCL2LbstuOLU9XCE0pNT1eTyw1ul7h7UGSTfAmD1m9mYXa8GV5fuf7aWzSvGg4HUoSETWE7ow7DcR
	gRf8jeBYzl2HshYQq53Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoyw-0004FJ-Uw; Mon, 18 Feb 2019 19:53:38 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoyr-0004ER-8Y
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:53:37 +0000
Received: by mail-ot1-f66.google.com with SMTP id n8so30280983otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jlCn6jkU9IcrascAKbvn8O2rZxuEgNgJdsYgsK3IElI=;
 b=qaOp5RNo3B+gKdxX+HuPSJ3+42WHCncOAt6TNzCrpO7JbCspQa61MkoyqTNZ2KcctZ
 YAQ5FFpuwvLjMaIA9anVnR5PT92E+9ZshBqvbrVrDSXe7nfKi05ezJHgpL0AIHx+tbfx
 xJmaJ2erFnmKdTjukAPxlmjMcKhan5QkKbGikpNynF0mN0Vgt3x0E6AdibACeQoNbKAS
 KNQ8atSb7cHDQfRlSAVmQIE26sIZRZHS21X8fOd2abaf0z0K23V1v0ZxpJ6CM/6F3ePr
 23tToXBi5Ikb+LLwctYpswtgfMvrxuHIJzvuNZdBAlliOVVvW1/0Fy0S0RLwnfjTowdv
 BhpA==
X-Gm-Message-State: AHQUAuaZfATFIMxEIIo53aBuQXmD5BzKc7A27JDL8RNo3F1e+qIluLtI
 DJ/wkm4q53xX53Pq4rQZtQ==
X-Google-Smtp-Source: AHgI3IbXfww3DGmS1wTGJkahwv30ASz3Kha7vmnPGZyuh+3CKl0nRO4gkvq47EYtC015ktvSNWYUeg==
X-Received: by 2002:a9d:7554:: with SMTP id b20mr14723858otl.32.1550519612296; 
 Mon, 18 Feb 2019 11:53:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t77sm4388276oie.26.2019.02.18.11.53.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 11:53:31 -0800 (PST)
Date: Mon, 18 Feb 2019 13:53:31 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 05/15] dt-bindings: timer: Add Milbeaut M10V timer
 description
Message-ID: <20190218195331.GA16665@bogus>
References: <1549628790-30960-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549628790-30960-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115335_124609_57ACB905 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 21:26:30 +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V timer.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
