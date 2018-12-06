Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:07:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814F32146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ol7OWJRD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScPD+18m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814F32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijXsz5w9jvVnJPvPtpqaiyGFW5MZq8TWs9El5+4e3o4=; b=ol7OWJRDOnpwqI
	DI5fBUqOVlZvsLdwABNr9eK6Il2qyVwHSVcdQZRuG5LeDtC/AQP1GmUKqhJeKQVW0ITPyog63vs/I
	s+1cUJR5MkmXmoW3OviYuVEwTuJb0HmBtyw3+ECyRXZ6uCbAnZbP4GRJDdzsKReWICaxSgPZRUSlw
	JdFitSuqIRXKmDPUTyuwjEF2Nn0hwsf/FtK9K/EzGboTLd+6fd864HOZixzYD/sMGmodqSr1tMstl
	g3TEpDAE1R4iW7qo02jjw0YCxW5CUSBnogGN/OO2lRnQl9Jjv2BVRYqT2En5DECbmes9h+V7+cUBR
	yU5JEieNn0U1WdwN8ARg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUnlG-0005cb-8C; Thu, 06 Dec 2018 07:07:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUnl9-0005bZ-Pg
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:07:48 +0000
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBBF5214DA
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544080053;
 bh=p89x8/Ecj0i3f50IaduVGZLPzHHtU/3du/xVUJMfbDU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ScPD+18mKALaPyireSPpkekGXTFNbLrDefJ73u0ivtvJJ3f0XuAO/NFMSmI9aaUei
 5BTzyKC32jRYWezcBYJclnDgg7aPW7LGiIr28VAiPEF73ovHGgnImz+eyhTFIK8AGO
 3gXSBu/2E31C0Wza/Kr+t/teW1OlOtjwJPTKB0aA=
Received: by mail-lj1-f170.google.com with SMTP id l15-v6so20689646lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:07:32 -0800 (PST)
X-Gm-Message-State: AA+aEWadBIoxwsSYN3xZvYaMYxMs9zyhD42Tlejrxb1zE8XA18iUHdGH
 xEVQ9GD6qvgHJTKiw3cQPK3CnifYX44piyaQWyA=
X-Google-Smtp-Source: AFSGD/WW+BnZTCM6YbFT7FuFSFNmMVzf0AeG6stFhtlf2ZpNzPMgSsvoXoPPxx4gfc01vASPL2b5Xe7q9vjLxkLkytE=
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr16931330ljb.153.1544080050900; 
 Wed, 05 Dec 2018 23:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-20-robh@kernel.org>
In-Reply-To: <20181205195050.4759-20-robh@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 08:07:18 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfzAFqQX-WHkEmvhp4OGY_tFtouG7d1JOD+_SRjYzd3cA@mail.gmail.com>
Message-ID: <CAJKOXPfzAFqQX-WHkEmvhp4OGY_tFtouG7d1JOD+_SRjYzd3cA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
To: linus.walleij@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_230743_953350_67444006 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: robh@kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 s.nawrocki@samsung.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 20:51, Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Linus,
I do not have anything queued in pinctrl samsung for next release, so
maybe you could apply this directly?

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
