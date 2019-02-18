Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA02C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF1D217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYEKZyqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF1D217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NAMB8Qge6edSmhYm7yw3GrHzLqzjCY+5c7QIvwI7QKM=; b=XYEKZyqD4y8a+Y
	dOFSHUkj7AIU9E8Md8xB/eUjyz5BQTVn6JGZ1QzfT0XTrd/xxfpqx2f/SYp3OY1s3gTuoAYeeyqBX
	UwX6gXyahEKbWpeZAkFn0kH9Ecq7Ve0I+lW/ARHKu4NHOhsA3z3c6U25RPBs4uKD2IfYxIB1glJ45
	4alrQ8SHbhlaYY37S3/5nYA6AixBRuvnyamEOsVEDuH3IAE10vOPQugwEWJ6yWDUgyEN7GjCSpIVo
	s6IDb8oZoUCAynXoSHWj3fO9Tfev/Wf8lk3jxfNLxWuY2AgQmiusQCJSIoDMdz0eQZuvEdU5Tlkmx
	WTXrc4miYSDyuTlMf3kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvpgR-0003Hj-PJ; Mon, 18 Feb 2019 20:38:35 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvpgO-0003HK-SA; Mon, 18 Feb 2019 20:38:34 +0000
Received: by mail-ot1-f65.google.com with SMTP id 98so30597531oty.1;
 Mon, 18 Feb 2019 12:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+iubiBzRbH/fHfgfShr9Oh6WrzhFtDL9VNH6fDaBPdg=;
 b=mS9m5qLtifMkFGBavBvg7dSoVWh1cqQ9kCeJ8HwdAjybNGzty5YFvCQj/q+bRG6lMa
 W4mukTcGe3h2hC2lawtRtnQFpi0NyUGQf3+L+fOWJJ2emrhLVdkivug8eBogbPV38z2U
 5XWiRPtqC8ZzpzywsQMq1es2RIXLNuzYLMdIcsMZ8D8/PzWBBDD5l9YC6pzJCo41OWJr
 eB7OJb1QDizK4mNR3CKX0H20zeuUSEqkLlsq4pQMvvTHofkG7cPM9oX+jIp3aVJbrBgw
 +W+6zswoAwvzZgkXZBMo8K3u+sBxVTsl95KQErZzEh3WUWsI3Fwkg85WXTJdZMAP3fzg
 MXHw==
X-Gm-Message-State: AHQUAuZysLAbwLKwEGJHictDfWCtZlQE45mswxvS7tcIzEj6iYtul2+n
 hicwQiSIazQPaSoGlyRYXA==
X-Google-Smtp-Source: AHgI3IacNmoAKEddLhbkOEtx94sthcrdDVgeDCUg1UD+dKeI/oKG0dMDH0Ja1x0bMwn+yplyAmF9ZA==
X-Received: by 2002:aca:6c04:: with SMTP id h4mr436056oic.10.1550522311952;
 Mon, 18 Feb 2019 12:38:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g3sm8145493otb.66.2019.02.18.12.38.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:38:31 -0800 (PST)
Date: Mon, 18 Feb 2019 14:38:31 -0600
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 5/5] dt-bindings: pwm: update bindings for MT7629 SoC
Message-ID: <20190218203831.GA26838@bogus>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <e7a59d288a4e23130e0303fec3aeba1f46ed1c26.1547781007.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7a59d288a4e23130e0303fec3aeba1f46ed1c26.1547781007.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_123832_908751_BFC3203C 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 11:24:45 +0800, Ryder Lee wrote:
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> Changes since v1: add a Reviewed-by tag.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
