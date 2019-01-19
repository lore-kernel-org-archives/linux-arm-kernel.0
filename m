Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D575C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:27:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1232E2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A3vuHw+K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyGWAWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1232E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ABC7SHcSNBODIq2Aq7HayI0QZCFYQnToXy4u9WzP/n4=; b=A3vuHw+KsZ2mh5
	XM63gOkH9tFk0uCETuE87bJFpd6sbjS72G0nhYkSU3Qx37r48H9VfQ/gur7DH98nF7tf9pCDWEnwu
	HSm1MFXi14YJ7mRW9lJAq3RtTqyPmMxS4rd8/vsMMKDMessn+vTMqlCftFIly4WV9WBzd0ivU/5tL
	yt+he79pmEGFOM0sFaAYaYde5gHRW1R4sFMKwhB7vLgQvBF6VjMtAJZY0Q5AIQC7vERkdYi++YOfX
	7V3Fa/73CZnf/KBkjNLbM60LLCqHkN4rlr0tklvX2n1s/2/XisEQQbJptfufhftJ7/qwuivkWLbAV
	mWFM75B2InMZFNXNcNUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkz4v-00050Q-4t; Sat, 19 Jan 2019 22:27:01 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkz4s-000504-5z
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 22:26:59 +0000
Received: by mail-oi1-x244.google.com with SMTP id x23so11824630oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sC2lgsRG/6Y/xz61JsT9wpZ3ebWqOk7wzNKMpksxNQE=;
 b=LeyGWAWjo/gXv38ht3V+sWmNj1rRPoH20zj/9wZhZWYsJODYQH2xKCBa6ngsE27z93
 B8odi1qqKm2asdQLvETObu6mD2Dbbxh83dkUfT9ShL9J9wJ4eKmnF5Ht2+OmTROK5emb
 QBYgqrkptcBf7O7+oLF/+NXOgD9Gr3OD5+AJGSikKsrNh9vDi683SRMJyoICbnOwmDUP
 8gSaSqZ8ARxkWIgrlSv7djGesw0NmpUY9F0JC78AO5JQ05RAfwCGdloxgpGz6aQBmHIQ
 cHWp3S1KPGyqreFOS2eZuJ7Ld5LacPo7Aa75/acOA7PD7PioQg7bFAmsj5T0QBqJXimH
 rtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sC2lgsRG/6Y/xz61JsT9wpZ3ebWqOk7wzNKMpksxNQE=;
 b=tvMxrA64ZmGHKsBSzfNL08PtoGP4KXxjh8bLKiX/d+ptCAgUsPNo39zHXIJTP2B7lt
 yWhyX8DW7qUR1psAEMTRM4HBpqckKKRvB6RhQ9efWWzHkD5CeP7w0cg3Vo55+k8lMR3J
 nhON/isRQ3tiO3WOXGWjZKN3P1AAa4A+xACCTsmjWIeP24jprh5s1Ki6t7UdlOLM+/UA
 yUbg8veDhsoG30rKogI6MEas/CeL8u4pqMF7S3aq7AQdGX2Px4tpJB7vQ1RZJdZ5oapZ
 JyJHNlXSDbf16HVapkdwb5lIb0rwuPyiWVdFRcZXwrEG/BnohNGb8hjRrQ12HWtFYaQU
 wcWA==
X-Gm-Message-State: AJcUukdBrT/jS36zOBv7jAJYhlTm/y8ZzWl3KUKyfNcuiQn8bXHjKMSn
 Y+nCiGqUvDQBzT8gtvccm3NEGwhziRxSOGeWtHY=
X-Google-Smtp-Source: ALg8bN4SmOr6F1zffT8J2Dh+dxyPK7N4+e3wU8p9BXncSwOAEkvdGPagZmL/OzepcyDWGXxohn5mIIivFzYD4TOWiUw=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr1969833oie.261.1547936816216; 
 Sat, 19 Jan 2019 14:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20190119211815.25101-1-slongerbeam@gmail.com>
 <20190119211815.25101-2-slongerbeam@gmail.com>
In-Reply-To: <20190119211815.25101-2-slongerbeam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 19 Jan 2019 20:26:47 -0200
Message-ID: <CAOMZO5D-2ygYBj3OuYF4pj7=HyO=aodpY2g+AjCt1EEpX5rk7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx53: Add capture-subsystem device
To: Steve Longerbeam <slongerbeam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_142658_262401_ED74E01F 
X-CRM114-Status: UNSURE (   9.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On Sat, Jan 19, 2019 at 7:18 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Add video capture_subsystem device node, and include both CSI ports.
> Prepare for adding sensors by adding the parallel sensor anchor endpoints
> to the CSI ports.
>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
