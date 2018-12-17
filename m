Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77192084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qbegiEUb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ZRELySwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77192084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GJAhppzI9fNeOcOWzs8Z/kzeyB8Qot9/bxeEjIzOVPI=; b=qbegiEUbbtIEis
	5afaQQz4khbxEN49tnZyWrlGnHOoZw2lOtysH0AfMOC2zApN5XyCGEQi6wOHC0lmILm0tTEUHyXiN
	DBCwJHQG0kH8OPXYiuIYCK58O2iMHy71/pycfyBTMGFaL4X11K/iaoN9QH6enfCSdSDGq1GuxDlvM
	TnxeIri0I6zwvCGenW+WR6yVX5foATDmIK/RFXbQjBp82Cn0Uq2cG2NvfR/D2Gfas7KxriKrVZ1Uq
	BWbAzhay/s/5uy8kMm5Fb/DBN8p+gYNnYI/YQZVh9aBWH3xtcyzOEBTIWB0laXoGpvp3mgftWnImK
	TCkhvp0sn699EXbnM1uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYp63-0004ov-Ml; Mon, 17 Dec 2018 09:21:55 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYp60-0004nt-9h
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:21:53 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B15B425B781;
 Mon, 17 Dec 2018 20:21:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545038501; bh=p3HLIKUQb5QxJUoTQ/uch11n8f64f/WTjQY02KCx8bM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZRELySwuS9+MhLIOnBuHEMdqXDFhzJELQ/wh06h8Ty4WKxwZ0B1PQWxJPdH9+dx+t
 M1yUwkVUEUZaJ3zT65vxoEORaeB/eGxD2WIHXzaU8KuYgGYAGdSj7JVWpI3Pin3hNN
 Dr0JPxRd005JX0W4HCQYYZKX9OKBwjaHyMch8fuQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id C56C79402FB; Mon, 17 Dec 2018 10:21:38 +0100 (CET)
Date: Mon, 17 Dec 2018 10:21:38 +0100
From: Simon Horman <horms@verge.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
Message-ID: <20181217092138.g5kwssfxabiw7g7f@verge.net.au>
References: <20181214115650.12443-2-horms+renesas@verge.net.au>
 <874lbdj97x.wl-kuninori.morimoto.gx@renesas.com>
 <20181217083642.6s34yp6dh6k56iie@verge.net.au>
 <871s6gk0mr.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871s6gk0mr.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_012152_485300_C36A0DB2 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 05:49:34PM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Using renesas_defconfig as a base I find that without enabling
> > CONFIG_SND_SIMPLE_SCU_CARD the following are enabled:
> > 
> >    CONFIG_SND_AUDIO_GRAPH_CARD
> >    CONFIG_SND_SIMPLE_CARD
> > 
> > But I see:
> > 
> > [   12.209793] ALSA device list:
> > [   12.212799]   No soundcards found.
> > 
> > With CONFIG_SND_SIMPLE_SCU_CARD also enabled (in the defconfig) I see:
> > 
> > [   14.087191] ALSA device list:
> > [   14.090195]   #0: rsnd-ak4613
> 
> Thanks.
> 56629fcba94c698d8c5be3413981506479566869
> ("arm64: dts: renesas: ebisu: Enable Audio")
> is using "simple-scu-audio-card", but it should be "simple-audio-card".
> Can you add and test this patch ?
> CONFIG_SND_SIMPLE_SCU_CARD is no longer needed, I think.


Thanks Morimoto-san,

I confirm that Sound on Ebisu-4D appears to work with a)
CONFIG_SND_SIMPLE_SCU_CARD disabled and b) the following patch applied.

> 
> --------------
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> index 62bdddc..649d3fd 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -159,16 +159,13 @@
>  	};
>  
>  	rsnd_ak4613: sound {
> -		compatible = "simple-scu-audio-card";
> +		compatible = "simple-audio-card";
>  
>  		simple-audio-card,name = "rsnd-ak4613";
>  		simple-audio-card,format = "left_j";
>  		simple-audio-card,bitclock-master = <&sndcpu>;
>  		simple-audio-card,frame-master = <&sndcpu>;
>  
> -		simple-audio-card,prefix = "ak4613";
> -		simple-audio-card,routing = "ak4613 Playback", "DAI0 Playback",
> -		"DAI0 Capture", "ak4613 Capture";
>  		sndcpu: simple-audio-card,cpu {
>  			sound-dai = <&rcar_sound>;
>  		};
> --------------
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
