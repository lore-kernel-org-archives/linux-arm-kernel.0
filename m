Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76BC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YbvwDsnD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2791II8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76BC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gd9eyfuTpV6TrXS9GOeKpHXhVLbOrs5ergR9a/5sEx8=; b=YbvwDsnDA0vBbA
	HTtZFw2pSrIRNm8rntLxkrG2qjUx2pS1PhvAFZBA36tiTnL+myy7xELhgYDqJAHjEhw8PCJsQ3Ivf
	fQtNPPH3QyHclcscNzHvlaZ/hwYqiB+0/UX028GudeRzge101jEeEAYha/btS9tIZCWqlZZ4Kqtff
	f93m0Jfx1WTZFLeE4cYD7O+r40JwABXSsBQBuEiXEcF4Tm4UzYeOZSh/JJt+1DzSUv03cXHJjl/vj
	LhUgUMLdC5yPbIlaNR/Q25oD/O294JhNm+J/p9DHGZTUqv55Rzf7cP/FMZgHf6TF+2o12li7gC3Bm
	rxfPYvI6do5creyZmd+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggfX5-0008PX-Eg; Tue, 08 Jan 2019 00:46:15 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggfX1-0008Ob-Er
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 00:46:13 +0000
Received: by mail-pg1-x52f.google.com with SMTP id w6so907622pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Snvh6Ow7n3uk2POMbNVXitzrCaFvEq04lk3zzwRJXcM=;
 b=k2791II8ShxWskzTaqJFueGmHUnsV3hTJ9t40Qse9ilQTsVofbhtEJ94ddNVe9+LpV
 rtGE3goxE6psxRjGldEhbjdas2sfdqjBmfrOz9WK97Zbgp8N9IE6sI436s/spRDvMUs7
 jTLFRa4fBUJDqvhS2bMj+Qo+VRhAxc5TEOZCXUNb+34gGIEogLGs2xiOaEy4piYyM0dX
 dS5hiJ+qH7xH4q3QIZ5DvIfDUZjTPDvXVIs37Ryvx+aYUhejLIa7eI0lPlEqXiYebyYp
 FWKUFzQAlf9jeupGHGaLZRrZFpe5r2gACvZ8f0JpbC5GySJD7t685Nsr0sRSHhmRkOSf
 0E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Snvh6Ow7n3uk2POMbNVXitzrCaFvEq04lk3zzwRJXcM=;
 b=diDTv5+KqUjlXGA41oFgt6MzqXxVUGITtI4P6Ps0SzTwfsuwwJn0EjKlc0uYL+r3IJ
 VKIt76zYTZIdR/OLDCqDAMh+ZOGhMGTI7BJUGBIFWMFcOrxdV0J3M9jB78duQGy7VxJc
 RQc/BKYyTHabEMvMK13fFK9dPVOtHyGTfP34gHK1RUQGnaGKI6cjd5ccpqEf3gyj/ZDT
 0RpavAHBPee0/7OtVdfw6EZPtZ7bacYUscHIeow6zFzNTHfANtCeblbivM82VLTJZvnQ
 +BBsLC4eSiQ7XfqXHzp0kobnPXDDXYuSaQspcR7p0qnaa/1E72iPuD9H4PDnoiU7OjcG
 bwNg==
X-Gm-Message-State: AJcUukdKAMCpwNyl5mtWE7FeiKGq/BIUz+HDu9f3NGNB4SiQcJEdu6Lc
 eivUgN3XRlaXdgtPmymnylY=
X-Google-Smtp-Source: ALg8bN7FwyZJ+F8saacMoC6xj3PEZJIeLQtbbJHC4h+w/z0VHqR6O8Rn+Ysbbg76HUWDrLX+w9rF/Q==
X-Received: by 2002:a63:db48:: with SMTP id x8mr12397898pgi.365.1546908368876; 
 Mon, 07 Jan 2019 16:46:08 -0800 (PST)
Received: from icarus ([2001:268:c0a3:b52b:e409:8f0c:a3eb:73df])
 by smtp.gmail.com with ESMTPSA id v190sm97819675pfv.26.2019.01.07.16.46.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 16:46:08 -0800 (PST)
Date: Tue, 8 Jan 2019 09:46:32 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Patrick Havelange <patrick.havelange@essensium.com>,
 Jonathan Cameron <jic23@kernel.org>, gregkh@linuxfoundation.org
Subject: Re: New IIO/counter driver
Message-ID: <20190108004632.GA3247@icarus>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_164611_502079_58BB5098 
X-CRM114-Status: GOOD (  15.11  )
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
Cc: devicetree@vger.kernel.org, lars@metafoo.de, benjamin.gaignard@st.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, akpm@linux-foundation.org, fabrice.gasnier@st.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 02:45:37PM +0100, Patrick Havelange wrote:
> Hello,
> 
> I'm in the process of adding a new IIO/counter driver, however I also saw
> that there was a work in progress to have a separate counter subsystem (
> https://marc.info/?l=linux-iio&m=153974167727206 ). But it seems there is
> no recent progress on it.
> What is the state of those patches ? Is it still interesting to develop the
> driver as an IIO/counter , or should I use already that new subsystem ?
> 
> Best Regards,
> 
> Patrick Havelange.

Hello,

I am still open to merging this patchset and maintaining the Counter
subsystem. However, I took the lack of response for my latest
submission to indicate a loss of interest in this patchset's approach.
If there are still people who want this, I can rebase and resend this
patchset for submission; the past few versions have primarily been code
clarity and documentation changes so I believe the core design itself is
somewhat stable now.

Just let me know how best to proceed and I shall be happy to oblige --
whether to continue maintaining this patchset or to drop this design in
favor of improving the existing IIO Counter code in the kernel.

I'll CC those from the patchset submission to keep them in the loop.

Sincerely,

William Breathitt Gray

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
