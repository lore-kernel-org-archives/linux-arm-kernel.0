Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5C21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eEqQ6dwu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhHbd5rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZK9GYWbl0eF9KstvV7FzI7jJDPB5VC8BgWJ1Z6E+kD4=; b=eEqQ6dwu1CGiMe
	Xc6Hq+REWeoS44Ma/bq+H6hK3sikXIXlQj6qh5ovn8W5zqWOnDnUKsthPz96ZBWtPqdThC6LfJ9p/
	wKNdmTMbCzxfod6nC6blVD4OKBkM0yPnj8nQVvyMi612BcKUSbgdQJ+TaCvMZBBEpD6gh9UnU7FHV
	N8MRkgVc1g0REV6ebm5OIOFijHnCoYm4Sd0WN8pd8aLNy6mgNbrGJSmgpPAQc/R0xF7yxFH2x/wv1
	5iafMZfPG1LP0WSDrEXzEaCBEF4f+IyUYN0XMUuAykiGjhryBzJKLaVmh47QmHVXRD8k3hKLy5+sc
	0Ka3LaMeR2CY33RRNmPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwD3V-0002md-0u; Tue, 19 Feb 2019 21:35:57 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwD3R-0002m8-HR
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 21:35:55 +0000
Received: by mail-ot1-x341.google.com with SMTP id v62so28029729otb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5HYmvzbnKIow24DKrYdnLAqrqZpJLlHEB4G5x+LLN5w=;
 b=VhHbd5rWmfwjqhDNdOrwdQH7N3In5UaB2iMNbvorvkzmaLgfojyJe2d9rHFr/G27Ez
 xCtqGN+YQciOHou4djov8XzBbBpRQxEcrINthavdYV/pnlcTgmw4dC7TeEzU7FPmh0qz
 V9+y3uXHWWbSBhjJJSwd+eOu3mF0/2e9WREOP5XNpFj+6hCnKfG+i6viiUpxGLpI/580
 GKcGjndojIEIfvJXADsgiaiAOK7xkjG00GQk2uu0GzMcIrpPgxW/cc2zXiza9wxjSLY9
 in8B11CGrhOBBcWKvq1nBTnxutZQ/XP0m3AZEOr36b7ijfTOlYfAVuUQ0WWWXDxX06Eq
 +AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5HYmvzbnKIow24DKrYdnLAqrqZpJLlHEB4G5x+LLN5w=;
 b=bSe79wakCnh6LTNYVzb5DgYsJoUAYww/3KNmPh1yuue5NMSgc6KbouQfsbNYVqUpqz
 EL/Lr2TqmBTP8R7dYfJ+BWSt7KzUARaCeR5eZuTtwsjgUlTJmr+9ALi4Qi2qkjSfo/r4
 bl5st25PMxy4KB5SokUK8sB801iuOBw9N+PQdjCfrPxujd9qxEuVtuVLog076kaiWFdz
 pcNZ0gAKEv/Z533l5P7kznFY5IND4GlnXLe/6QbYRe3z4zM80VtV0RrLuEmOr2pmy3G/
 6uMG6xEW3OM1mCKBkD4tL+pV6f4HT8Io5NSrsh5URQmSnThKygQra7pdzliMWEyvxEQo
 6+kw==
X-Gm-Message-State: AHQUAuYAleMrNP/r4CWwHo6W2HycnTETER3RcriFz53wtp1Vhroe5G6Z
 S9Pe9whuA54Cfi3sYW/ykaQMt0Q+IlBOu/IAjnk=
X-Google-Smtp-Source: AHgI3IaONa83nw0UXBwSOFbNxOkgPgKP+o0WC7gZceg4tP+s9NsQEYK9zgq/6G3kKO08k34DKIPx5+Ez+3XsYjfoA/o=
X-Received: by 2002:aca:3c83:: with SMTP id j125mr3975990oia.34.1550612152083; 
 Tue, 19 Feb 2019 13:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-11-anarsoul@gmail.com>
 <20190218183301.GA5480@bogus>
 <CA+E=qVcdDQJvssZgu23gM_gKvz2G5GAWcmjFBokE_V=WGJ4h6A@mail.gmail.com>
 <CAL_Jsq+pyAd_kMMz+yKjqY=asAi1X1XguM58VjfVhPwD-xi-2w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+pyAd_kMMz+yKjqY=asAi1X1XguM58VjfVhPwD-xi-2w@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 19 Feb 2019 13:35:26 -0800
Message-ID: <CA+E=qVcmLnr9sL7UjG2PSC0Ji5PhW=xOLQHGvRUG3yMMZW1hnw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics
 CO., LTD WJFH116008A panel support
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_133554_116723_65945C5D 
X-CRM114-Status: GOOD (  14.32  )
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
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 6:54 AM Rob Herring <robh@kernel.org> wrote:

> > I believe using eDP connector binding wouldn't help much in my case
> > and it won't improve accuracy of hardware description while adding
> > unnecessary code duplication (edp-connector will be pretty much
> > simple-panel).
> >
> > Since currently there're no standalone connector drivers, implementing
> > one requires significant refactoring of the code that I'm not
> > familiar.
>
> I'm not talking about drivers. I'm talking about bindings. Those are
> not necessarily 1-1. There's no reason the simple panel driver can't
> have an 'edp-connector' entry.

These aren't independent things. Bindings are useless without drivers.

Also how are you going to address mainlined platforms that have eDP
and use panel bindings? E.g. rk3399 supports eDP and uses panel
binding - see rk3399-gru-kevin.dts as example.

> Also, since you have EDID, you should be using that for timing data
> IMO, and the binding needs to have enough information to support that.
> It may if DP-aux comes from the bridge chip or it may not if you need
> to describe that connection. Again, this is independent from what
> Linux chooses to do. If Linux chooses to have its own timing
> information that's its choice. Another OS may choose to use EDID.

I see nothing wrong here - anx6345 driver reads EDID (over AUX) and
uses timing from it, if reading EDID failed it fallback to timings
defined in panel driver.

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
