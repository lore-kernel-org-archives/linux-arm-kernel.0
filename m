Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADCC37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:04:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766B420861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Smn4lTt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766B420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=idMn1Hl4Vz+6+VWY8j+WYxWUso2C3Pk17Mh9fpwenPk=; b=Smn4lTt/owOZZx
	824ulycRsTLhozuwvH1MH7Kff6wxb2EMvnJW4M/4GoXHGOUnh/vBYmY9bWYkwMhzx4ARXy5/+wwNY
	S0Hd7hoPuAS0AktaozyauaKUFhtyz+Ao6H/3ZjzIFAF21SAzEHZHiTiBxaodEzkUc2bDq9+wJ1/k2
	ueijAcarEd+8ccLxjgHL2LJlOVB071THMmDcdDazidfcLQR+JnSYdfhJKk1PJcGvN/0WKlVtvM2O9
	mQ7DGNxyBI09gViyO1efLWFTOkIcvAgHUzR7KkV90HxoWBOdWjw+jSAu1jwK+iv6Jlo/luDbWXWj2
	Jl5H3BCeKFSx3N2HU3bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgkb-0005Ge-7M; Mon, 21 Jan 2019 21:04:57 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgkW-0005GJ-Bh
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:04:53 +0000
Received: by mail-ot1-f67.google.com with SMTP id n8so21739698otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 13:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v4yzYvAFmjYSXucy1AcnsqmlP7OsOTnOYguk8hvUVyo=;
 b=JeG/3lL2Qqthr8Y8ebz/ujSPb2z+KjaMLmoHh5hdfZLYGcurZygegVYp48tfrTac5S
 BfsybVhrOo/ZovOB3/9knq0UOR+XgPTo+8eJjKqJe0NqFpswpDFgI95rs5GUjvOpvohU
 vXWXF/tvciKjFUCocanajdk4NpG9XKopXnA3y51FFgl0dSf2YsmNTaBe2H9cv2S6bhJt
 Yh0xClBPeeAIy8h/9wHgVhdeWeuYDrZKHfg9HuA8ANbuxvrv1FxL1fY5zH6W/ss6HTQW
 muq/CKi2+otkXTMViFNsJmQwTeyzajGZxcm1e3pkVqtiNU5QLsMcI+7KFJGP0MpSNG6+
 izWw==
X-Gm-Message-State: AJcUuke5QPKtpuu2emR7Kw5pjcHQg+NsrwoBirINxjlaTK0PmVuUWtWE
 gBFTfKL+qWndm+dcFLxRvA==
X-Google-Smtp-Source: ALg8bN7WGPqEXqoSBCUcw4Eyvblt6N2iYUD762Y8i0ZeEM4p9SpBqvaGCwhfhMAIVt18ox08NBajGg==
X-Received: by 2002:a9d:42c:: with SMTP id 41mr21486488otc.41.1548104691140;
 Mon, 21 Jan 2019 13:04:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w62sm6069766oiw.34.2019.01.21.13.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 13:04:50 -0800 (PST)
Date: Mon, 21 Jan 2019 15:04:49 -0600
From: Rob Herring <robh@kernel.org>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: ti,sci-clk: Add support for
 parsing clock info from DT
Message-ID: <20190121210449.GB7851@bogus>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
 <1546954223-9738-2-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546954223-9738-2-git-send-email-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_130452_395831_FA29D172 
X-CRM114-Status: GOOD (  20.21  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 ssantosh@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 03:30:21PM +0200, Tero Kristo wrote:
> By default, the available clock info is queried from firmware, which can
> be quite a lengthy operation if there is a very large amount of clocks
> available. Add option for parsing the used clocks from DT instead, and
> only register these which can improve the boot time of the device quite
> a lot.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/ti,sci-clk.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> index 4e59dc6..c757ae1 100644
> --- a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> @@ -18,6 +18,13 @@ Required properties:
>    and clocks IDs for 66AK2G SoC are documented at
>    http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
>  
> +Optional properties:
> +-------------------
> +- ti,scan-clocks-from-dt: Scan clock tree info from DT. By default,
> +  clocks are queried from firmware, which can be rather slow operation,
> +  especially if there is a really large number of clocks available out
> +  of which only a handful are ever used by kernel.

At first, I thought this was an either/or thing. Use firmware or use DT, 
but it is really only get the clocks used in the DT from firmware.

Why wouldn't you just always do that? I can think of 3 cases: 
reparenting, debug and overlays. This breaks reparenting and overlays, 
right? Debug could be handled with some userspace trigger to get all the 
clocks.

Why scan any of the clocks up front? Why not just create the clocks on 
demand? If an unknown clock id is requested, then create the clock and 
query the firmware at that point. That would avoid the DT scan too. 
Maybe there's some issues in the clk framework preventing that, but 
that's not really a DT problem.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
