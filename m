Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBA2217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rhA+9Biz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBA2217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aH6q1RzZvtjw+RKU2KEeHP699u/4/eac5fXQhfM9Z7w=; b=rhA+9BizsnKlyh
	F87UxU8XNCbAlNGlUvTHliy9t/oYNqe8bskOMB6gea+Qpj8GKQIupFLtLzLPWpxW7T/xEspGYEzAM
	QECdtrHQgV4cLLKWdddbwD2ij2r/rT6mEUdiY34fF0AOFhcRYbzW99GyUFbE6um8JSLuboxiRuvlA
	YXm4RFpQ6gJ93KNBeQLDHn2hD4bVVoFDeFTVTA0ybtTnExFFcUPOxgiNoQv7uBU1fu7z2NwFwqS94
	15R7ixuxMO/9jUay8XCVci2D2dlq3l/a/E69lrVn9rwINBODYyOD8Nt3f0jOxhjRT3lbSs6wWr4vE
	Y2PG0yRsHz/rA9XRgLBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2L1-0005nf-FC; Tue, 05 Feb 2019 15:08:39 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2Kp-0005dE-KU
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:08:29 +0000
Received: by mail-ed1-f54.google.com with SMTP id y56so3085288edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 07:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t8Z0apMRHXXh+nTlUahkqxKK3MNso4+Qj3edMSnGaDQ=;
 b=NFyyMJeH5dkYEvBv3RbsOE87iNw+DHFVQEYLzkNG1JDUOz/94UjeW7waHdCqYqPJsu
 EKk52vtpp9O7rxHALxsNE9ghzfH/LCQGbARt1pCgW9UxxpHASeVFbt06yvvcJ/S+diMV
 mf0hSkn4xg72ZCYWGwrXSMWXD/k5RvqYZDxwlckNDkOTZiV6CYDvBKLGwOoVnTHf6s7i
 t9EgM8Th4yQL/8OA9l4+5B+dsSJzZrCqEw3wzSH2AKGfpHg0N/uxIZ5uQANBj4h4pcP2
 Nc4IRNx+IFzItofmhPZa6D98tTnSbpMPF86+jv2By03JlVgZl+Usa/NTLlIiLU79qkrJ
 6vdg==
X-Gm-Message-State: AHQUAuYIll6HxHM9veje0r7VdhCnIwZReZiKjkBjyyz5vf1JlXzAOOKx
 qvuZMUkTCD7mTlL7uKWjD5+3qwB0dhA=
X-Google-Smtp-Source: AHgI3Ia1Rz3eYK+2d1lKO5irjwJJ72yVqm4ZvXQ1LrD28evBRUVyaust08iohdJNyR06/ia9o3f5mg==
X-Received: by 2002:a50:f489:: with SMTP id s9mr4326287edm.101.1549379305403; 
 Tue, 05 Feb 2019 07:08:25 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
 [209.85.128.49])
 by smtp.gmail.com with ESMTPSA id o37sm5127271edc.32.2019.02.05.07.08.24
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 07:08:24 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id m22so4054595wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 07:08:24 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr4073442wme.111.1549379304052; 
 Tue, 05 Feb 2019 07:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20190203000622.30856-1-chrisadr@gentoo.org>
In-Reply-To: <20190203000622.30856-1-chrisadr@gentoo.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 5 Feb 2019 23:08:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v64eH=UyR5rvFnuLwVJHsDeX-RJudgqw4GhrgD5LuncH9g@mail.gmail.com>
Message-ID: <CAGb2v64eH=UyR5rvFnuLwVJHsDeX-RJudgqw4GhrgD5LuncH9g@mail.gmail.com>
Subject: Re: [PATCH-next] drm/sun4i: Use PTR_ERR_OR_ZERO in
 sun8i_phy_clk_create()
To: Christopher Diaz Riveros <chrisadr@gentoo.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_070827_664338_19FC752E 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: David Airlie <airlied@linux.ie>,
 linux-kernel <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 8:07 AM Christopher Diaz Riveros
<chrisadr@gentoo.org> wrote:
>
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Maxime's reply to the patch "drm/sun4i: hdmi: Use PTR_ERR_OR_ZERO
in sun4i_tmds_create()" [1] probably applies to this one as well:

"""
While this is technically correct (and I appreciate that this is also
a matter of taste), I find the former syntax to be clearer and easier
to extend if needed.
"""

ChenYu

[1] https://patchwork.kernel.org/patch/10671757/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
