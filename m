Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CEC205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X98u0HNd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U66aGGMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CEC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zNQiMYCrpfbvoosSkiHS9DBkllqf2dQ7kZpmw22fdmQ=; b=X98u0HNd9HPc2O
	u8If052XZLoqAOqqqZYclesh/Pih1i5QUInR+a/iBjcWjkSxwt4Ka+bPX8vtAwYDuPgzhLjSDoyqZ
	Z0IK8VaFLAYTOIyqZBgyV2BLtjI1vFX8OvFA44teUVRSwAlbqBkpRFgCzffqFccbB1N2CJQ+5CYqx
	VRntcpig34+iy5PbOch2Uc69O+k1NAHnGtGYoH109r4lW3PbPI3fsQyPO209SL+tjYOaZWH66BJZF
	mIOgMor/d6yHemifd0eUnRrTHQ1tdNPVmKP5Vo5wveIlfgoEbsvEBOWRSnCNRXY77RDDN6DXYeSa5
	lhcpSx4t8gDwbewYI2IQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9RL-0005QG-IM; Thu, 17 Jan 2019 15:18:43 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9RH-0005PG-Oh
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:18:41 +0000
Received: by mail-qt1-x841.google.com with SMTP id t33so11656787qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 07:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YjvaZ9G1FSwHziIyQYueDHCrTavQC6T5hLnDZZ3kn1E=;
 b=U66aGGMBzHV1m12IXV2YA92+Nf8TF5rBr12sDl8wFIqf9srrAdSTPxF8+T0bl3jfLC
 b5PkzQburC4/cE5kuTR+wftO6WnxiDVkt2TJ5+GgKjQMaiqRDpBG2OBRg7XnuzQBYrGg
 BW/YAJ9FkwCL5M7YVjuub+VC86V1eDuAU5edg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YjvaZ9G1FSwHziIyQYueDHCrTavQC6T5hLnDZZ3kn1E=;
 b=eYrAUPz+38/jrPcWBGT0D1TCfhfYprcSULmfkZLhLy+lscttWW17IVc1uBMAlIC7t3
 8ZagEv3TVIJB37mgnj3eYlkuMWd9+mDSONPjBqS4U4s7v0X57rQMdtaud9AQ6WeUdwSA
 caWXa2tSPCbdB/kciW+4J+QqQfz5H06INZULcKUEyFuB+HJtKm446FLN3BDJ08xS8l1j
 rUV2f73410RcW6PLyuUNnsE2XdZs9weIzl6q+tICjWEGNZm9lqhlmO9z+L8ZmrbYQsWU
 ALMVS+Os/5ali0iWg16fRCjFSBQtfM19abh9uh+WYxM1qxhDPTlcRK+M/0kQmt4H0H44
 PLeg==
X-Gm-Message-State: AJcUuke1WdXEa6Cla2fNCSafpSQnY8ixEeH3XYWMphTMAeOWHVB4Fk9s
 nYqXj9Oz/38Mfo24XWnDMRehfQ==
X-Google-Smtp-Source: ALg8bN719NNaOzVPLVOVrtxrVxlWhRpYRukdkLOqd4unC9l+LfxKJbSG5wH08zPvxKGdacxDmDiJaw==
X-Received: by 2002:a05:6214:c7:: with SMTP id
 f7mr11976285qvs.44.1547738316551; 
 Thu, 17 Jan 2019 07:18:36 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
 by smtp.gmail.com with ESMTPSA id p8sm57925042qtk.70.2019.01.17.07.18.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 07:18:34 -0800 (PST)
Date: Thu, 17 Jan 2019 10:18:33 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous
 boot logs
Message-ID: <20190117151833.GA51139@google.com>
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_071839_867477_19AFB0AE 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: Tony Luck <tony.luck@intel.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
 Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Colin Cross <ccross@android.com>, Guenter Roeck <groeck@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 11:56:20AM +0530, Sai Prakash Ranjan wrote:
> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
> arguments") changed update assignment in getting next persistent
> ram zone by adding a check for record type. But the check always
> returns true since the record type is assigned 0. And this breaks
> console ramoops by showing current console log instead of previous
> log on warm reset and hard reset (actually hard reset should not
> be showing any logs).
> 
> Fix this by having persistent ram zone type check instead of record
> type check. Tested this on SDM845 MTP and dragonboard 410c.
> 
> Reproducing this issue is simple as below:
> 
> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>    record in the mounted location which is the current log.
> 
> 2. Trigger warm reset and mount pstore. Will see the current
>    console-ramoops record instead of previous record.
> 
> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>


Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> 
> ---
> 
> I guess commit msg can be improved.
> ---
>  fs/pstore/ram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 96f7d32cd184..441a44215456 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>  		     struct pstore_record *record)
>  {
>  	struct persistent_ram_zone *prz;
> -	bool update = (record->type == PSTORE_TYPE_DMESG);
> +	bool update;
>  
>  	/* Give up if we never existed or have hit the end. */
>  	if (!przs)
> @@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>  	if (!prz)
>  		return NULL;
>  
> +	update = (prz->type == PSTORE_TYPE_DMESG);
> +
>  	/* Update old/shadowed buffer. */
>  	if (update)
>  		persistent_ram_save_old(prz);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
