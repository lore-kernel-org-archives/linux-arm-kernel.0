Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E10C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84862147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gZaxV7lJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJnVjA9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84862147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fHMeRaS8k7eAj/iP1lpao1+EWvBov1s8ykSToMJfvfo=; b=gZaxV7lJqNnpnM
	wuhhv+Q6rm1unL1YdlalVi3RC7LKrUr2nS9JT/Q5vQW2A0wDtQ0Q7opDk0D8R890QByLdQBNsS+Gw
	QNomiqalORKfs9Ywn0LQGX90ZoBeNb08NiUPQcpn+qXQ9FVXbOYbhVgfegm8i+PgYeBWF/9c+IgBA
	G/j2An3p/9uB/eS4QGpadkayw/4xSpuC1vUjPJSvTVUuyY3OmBYrlUA3m8sf39R4V6jgCxyqCL5Y4
	sTZf7aFQKXB/M8NjZVEvq2LshRR1dh6kiiuOKX4fyHICsa0Oz1cX+LfXe4tVU9Djm8lT1cnkdyDRG
	MnBoItIJ6DAu1C4hNxDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu0td-0000uS-6h; Wed, 13 Feb 2019 20:12:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu0ta-0000tE-45; Wed, 13 Feb 2019 20:12:39 +0000
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80745222D0;
 Wed, 13 Feb 2019 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550088755;
 bh=5HR2C3e4hJr1yVsmV0xaF+8a/dJVoOCrXShZHRHacic=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KJnVjA9YDqFccKxwrgRwI04Fr4yhhT1Qz0csqysttuFelq6p4qTDPekwxKek1jmiw
 6h5UUC871VqkCklWp2ivarl/Gd16t1ICGXI/NyFwyWMojAwvFbI5OIWjo6m9J5aS1q
 iM7/qOummP94tyBa9sPhSFb8kj7VqXSxSBHFyzcA=
Received: by mail-qt1-f177.google.com with SMTP id z39so4242242qtz.0;
 Wed, 13 Feb 2019 12:12:35 -0800 (PST)
X-Gm-Message-State: AHQUAua6w3axg5W4jf1hnDfEn0SE3id1KnTAzS7+l6lo7GAjXilHqbBJ
 s6Vb9QSckOwu+mxpTJz0VAgbiyXMBaSH3mkNaw==
X-Google-Smtp-Source: AHgI3IZJB0f7syeg+bjn05P781cDIn989qaoNJ0kBC+GwvszhBYfp+QvjHTDY/vgj2xyzNS/VEk/iactrgayroblrwI=
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr1908599qvn.77.1550088754747; 
 Wed, 13 Feb 2019 12:12:34 -0800 (PST)
MIME-Version: 1.0
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
 <1421bc57f9f4d5f3e087a1fd38c5fa9ef087dd1b.1548735271.git.ryder.lee@mediatek.com>
In-Reply-To: <1421bc57f9f4d5f3e087a1fd38c5fa9ef087dd1b.1548735271.git.ryder.lee@mediatek.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 13 Feb 2019 14:12:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLan+-p661a=p2Ss7tsQHdu7YGqwe3OmYkwAKE=LeqT=w@mail.gmail.com>
Message-ID: <CAL_JsqLan+-p661a=p2Ss7tsQHdu7YGqwe3OmYkwAKE=LeqT=w@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: arm: mediatek: add support for MT7622
 BPI-R64 and MT7629 RFB
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_121238_183275_0EE02BBF 
X-CRM114-Status: GOOD (  10.92  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Roy Luo <roychl666@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 10:31 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Update binding document for MT7622 BPI-R64 and MT7629 reference board.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Do you plan to apply my patch converting Mediatek to DT schema[1]? I'm
not planning to rebase it now that this one is applied and resend it.

Rob

[1] https://patchwork.ozlabs.org/patch/1007257/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
