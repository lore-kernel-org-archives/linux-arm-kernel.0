Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF10BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B47820C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GWdMOMbK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NITrRMNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B47820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akgpSTYbLsArVk08NIEV2abnXYEhYRm6VxpcwBCm0yk=; b=GWdMOMbKTXuhJO
	/9c+lsP2AbJS4nnQlffU2x/AuOSeg9aumjRkFVpTA7qEl7rxLkV8daS1HuLEBpqH+aTDZepxrcvdo
	c22lOahGGSTx94qXviMH2Ot1Qd2qyjnQGTgZxUuH0wwW6O7SPlyZPzHU9AtRghnevExo/SXocwi0w
	qwJEptohIUausrswHyedu/pQ/s3373m17IyURXLMirlx0DQoiJjHifMbs3gLp9pesoVVn98ABMx5O
	Y+2KzxJBgujB6vZZuyOs0wSsUd09sTjvWQ+cKNNhtZmIAVWwiKrYBw48bMgrFeRqLGOE6DwUlnyJm
	h5bwpY55PRAXzGRUrpyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzg9-0000d5-8p; Wed, 27 Feb 2019 13:55:21 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzg6-0000cY-7M
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:55:19 +0000
Received: by mail-qt1-x842.google.com with SMTP id w4so19263081qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VqQ9G7jn8vIEoJWzmCjzWXCoLqsvFZiFGobGFntymRI=;
 b=NITrRMNoHTELuOT/tEauYhW+4IXCunovN9k65RYed2lkKwtRE6VfRTINaj9loaImDL
 FWjt+d5/gXLaEgJb6y/IBLA8gwxli/ewXfcfzkkGJBVvJAv+stsO/AjkhSaDJdqJPqoi
 gdQ654mOftRNztralf0F8aoaYwyMvlNPf4B7y6iuI7oGM0MfXM0Z7bAE2HcnH5ehCqJI
 oC6sR7Xx/Sv1Dybg818BpdRrU+wmZlS/wgx9VOKLcA/WN6GsHRKKXzmrXOD+MKqw2RfA
 VJDKBmY1FtorlKBksC6w9uIMy5rF3FB9T1+VhrfBopzqM1lCReGeSsPfjXQJ73gjrD85
 T8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VqQ9G7jn8vIEoJWzmCjzWXCoLqsvFZiFGobGFntymRI=;
 b=oR2lzOLs8nitvHF9ayJZ9qXM0fzHjN0bTOyvSfgbXas0pkp3BaaXKWN6uXtP40Kqkp
 ImkOb6z73DgLeIEPSdUtAt6f4FAKOulFxo0Q/NOSTcvkpCJbBYLPz6Fx42gmEE8ho5NF
 Iyz+Z9C3/HavGhkuxZVfNhIj/Vanax61bPe15uxmjiwGkFEWmsuUiar2ndvumM8kHDlQ
 fFWaOe5DwJvRAbleEA+L9C/0aD3hkMLpd/KSEiMF6jV3pkXAEnuE4/lZhf6+CFkhg0N6
 1+1p/AxjYDI+ceVP6qCBHWm172Ix1HFZvkUhVYDxt0ifWn2NYhdSWthMrst7EWk323/G
 bLXg==
X-Gm-Message-State: APjAAAWpeiJNgA6GJfOorr2zruKQp2TpuoypTXDYniWaOXC0fqQrDs96
 AKQpkY89Iun2UpfJhrAt+lbb+iiX3gjW69bpjpLcaw==
X-Google-Smtp-Source: AHgI3IYSepXwyGn/S/pgu6u/5JTFssQ3M8yskc53xOPLC+OiqGXqsb1pMbTx0EbTFXQjaF0zTvU5dH+AxgwUaa7h+C0=
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr1789611qto.234.1551275716476; 
 Wed, 27 Feb 2019 05:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-5-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1551260094-32570-5-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Feb 2019 14:55:00 +0100
Message-ID: <CACRpkdaa4K3uoo7mXkLqjqbmP4qHfrbmqQuqc2fDCE3D=s_2Dw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO
 driver
To: Amelie Delaunay <amelie.delaunay@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_055518_271795_55CE220F 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 10:35 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds pinctrl/GPIO driver for STMicroelectronics
> Multi-Function eXpander (STMFX) GPIO expander.
> STMFX is an I2C slave controller, offering up to 24 GPIOs.
> The driver relies on generic pin config interface to configure the GPIOs.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume Lee will merge the whole patch set through the MFD
tree.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
