Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D35E20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pKTmt+Rb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zOHTL+bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D35E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j2oliUOx+dUvxJjZhsOGP7qRhIV+hBRxgb5kNf5o5k4=; b=pKTmt+RbYNBv3Z
	unIyRsvpb3snxMoCQ5tbkDhX2gcFBZL8YtbAUArtZNeIT27l7w67HiOEjsG71NXOfVrLUHzRVFZN+
	9ol3dhrhqjTNF1B8UnSuwOWI39X1JJOD3sSYOR5KfjQqYNp0CMQEcNUFf5s9MlPJDKkEvPXAWJwPX
	wIzhC0U1+q2erP3sGQxLrE5d8wi0GWIgTJeTE0/564MWLyl6K8xVLxcLziHiEV7vl7SX7po+byIdc
	No6HfFjuSMS9/cwPjGV9+GPQUVKW8IwdPlj34itGfJUuQv+uiW5reV6GQDzk1N3a+iw2Fwy+PFZG6
	HZy106H5WL3zT3siRrXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrke-0005so-0W; Fri, 30 Nov 2018 22:59:12 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriL-0003wm-Ow
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:52 +0000
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so6407988ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wqz6Hz/qvhwKWRmkkj197fjEJCJwBjwxL/4ZA4fi6FQ=;
 b=zOHTL+bdcaROj8j6vLT7DdGkGl/dIStH33MIWolia1kQNBQVTG1kizk4aiZwc9yFOv
 /Wdufg/tdf9hWpqZIYV1ss21tJWYSSvV6plmXxXz6EQ4DyW2VoFg12favxbx9dUuPcBO
 HJnZPAlWZSayxjO5uBRgiG5AsWUOP0WM47Y8vNGtB1v+H8K7xBHg7a8QbNGRZ0zfdTgu
 loOtHLP291gTz9r4vtW6HTtLcnIwTprg46icgu3UgKSwrjNQ/04bRd69ADgjhGEJxfdM
 MlpXRCmUsvKtwVk8FVfqwMqR6QTOFqvBPPQ+NWnVirhRqkBDgowZXL6ZdlPSoCp6KB0J
 Ss/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wqz6Hz/qvhwKWRmkkj197fjEJCJwBjwxL/4ZA4fi6FQ=;
 b=j2j7rN2xmaU1zIKwHEkBqdFD9SaOTL0Dp+WqIBcHtf7ufVJ8hqF97UsIzUXsBFMXBG
 2a7DIPoPYkkyevqOBlwX21AWIoyHxwat/yA78hHpDyRR7SyU2N+TOXZNVGxM6TJg/GVJ
 mdn7YCM2TRYrqPnfm6saSJEIUX364Lea4NA0u9JQc6o/HTKbDXY8hkv0Z+6CRS03ivTn
 tEc8oaieEtA3TxHXGXED9aKlK2HScomXB4AoOEQOLdZ0YHve4YEEcCf/ufJP6FwTy+xB
 NJOiW6pgPGpOc5Kx0jKjZl3Rcd/Ai1nhhfkG+w+PE45/0p8G5Vz7IzF5L8dOECVInFjm
 OsqQ==
X-Gm-Message-State: AA+aEWYDfLtJPjeReseoJ0d2WQ0ksANPDtwj9jTxRVo5anuWGHZeX7s0
 93WWXrXUS4HrKqyh/kAloZdJWw==
X-Google-Smtp-Source: AFSGD/XPz9w3WmBfpJVAJGeDcWnl8lEsiVHOxZXDQSBrUV58SWEobEbWkCOJz2Ah6X2A0aGapN6B/g==
X-Received: by 2002:a2e:7d15:: with SMTP id
 y21-v6mr4372757ljc.77.1543618597422; 
 Fri, 30 Nov 2018 14:56:37 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q6sm1027219lfh.52.2018.11.30.14.56.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:36 -0800 (PST)
Date: Fri, 30 Nov 2018 11:57:21 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Remove unused Qualcomm SoC mailing list
Message-ID: <20181130195721.omkxvvin7iu3be3u@localhost>
References: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145650_458052_E3010B24 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, arm@kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 04:31:06PM -0600, Andy Gross wrote:
> This patch removes the linux-soc mailing list from the Qualcomm SoC
> entry.  We use the linux-msm and there is no need to have the second
> one and this clears the list for use by others.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Applied to fixes. Thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
