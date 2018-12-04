Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15001C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F7B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2U1UTEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F7B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PyWDqhHU+GlruJLSWPAYFyR3Oux47eY8r/sFEGZIs4o=; b=e2U1UTEd+IvfQF
	NrKsaFRuD/ZAYZhy3lKA2leddAdDiHOsWaKA/CqpJ+RViA/NoGIwAuy85IQuCJj1rqFv2TMpjMpYB
	mgr+UxU8Oe7y4VxiJvnVa2C60PAmjJZqgEBJTfE4qlaXA1A4PMrs7mtlSn/P0+W4ec+UkHfVMjzWb
	04gxITuaB/wyxANY7LTj1KzW/pgKQ8G8Ynr4NDr/1p6tQnVG9cMlJ4OO0bp6JTt/j0BtMp16xe1x1
	8Dea/08/2b8fS8WNc3Hp/nl5IVCE0t+9M0OBvvhVkKaW8ysawLAGpMb7RfZls22a2ONEzA8RRXTfL
	tuQ2JS0W2oBP/vlPd7LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIXP-0002kL-Mx; Tue, 04 Dec 2018 21:47:27 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIXM-0002NK-IZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 21:47:26 +0000
Received: by mail-ot1-f67.google.com with SMTP id s5so16669798oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 13:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yVUJodPAOpNCa1SKM6GXt/gdr2CgnzPhl3+TDP57p44=;
 b=LSE+BMliTwL8haMDfv57wLyOuLSiW0C+u2UqMiwK8XhU0vYlmBCysOYj0SX0AC5Z+8
 8roQoX8NTCws0Kz79LdB3x0CWZ6QS1UCxbgX4d4uUHe8+IBsxBU56QnVYO9XTjEccLNv
 tMUYtbdUjZlhUh5CxtEouJ2TXgc6iHmzQBHJY6+KxVeRHTHdPkJCeV4eKLQ/VJ6RBi4k
 cDG3kmkx5jAvGhPqxJHC5BPs/Moy5bnN/h5s+TjDuq9wOlURPaTL8ReCN69Pmtb/XBOJ
 WEenoWAvf8omnOQLxdWi7UQIi7azXKel4m5p+hxPg94M+Ic0oigtj74rsM6sJV8yzvDA
 zc8g==
X-Gm-Message-State: AA+aEWbssEbqgtBklUl8On+EYu3s6mhmuAPTQ2m2ttTkzQMrw3r7MKBZ
 58blFZw6c7Ose/bTqB5TgA==
X-Google-Smtp-Source: AFSGD/UuAGIWngwkzkYmLayZEs56iX8DKwGYfgU2uqoR2asba1dwu+m+nb+ngnEniBQgSaLfaca/NQ==
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr12765534otp.17.1543960033884; 
 Tue, 04 Dec 2018 13:47:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x92sm10213690ota.55.2018.12.04.13.47.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 13:47:13 -0800 (PST)
Date: Tue, 4 Dec 2018 15:47:12 -0600
From: Rob Herring <robh@kernel.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 09/15] dt-bindings: sram: sunxi: Add compatible for the
 A64 SRAM C1
Message-ID: <20181204214712.GA13571@bogus>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-10-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115145013.3378-10-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_134724_610768_E7C099A6 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 15 Nov 2018 15:50:07 +0100, Paul Kocialkowski wrote:
> This introduces a new compatible for the A64 SRAM C1 section, that is
> compatible with the SRAM C1 section as found on the A10.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
