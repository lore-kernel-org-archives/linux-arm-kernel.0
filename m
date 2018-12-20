Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD60421903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWjgcLMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD60421903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b3+FCLHJhfkMWX1gyYNJu01EPnTJBxWeqIR2IJQntJY=; b=JWjgcLMg+NJv1W
	G+iKB3l8/CijlWhwdbhhmcDCtLEk9fZ5XIbUXJZDV6eONh9Z/XA1uXgA2HQXzvZRrF4Lhulz5KBzW
	3hVRKXZ/Y4ad4pNTclDFn8PGJLLJJofsV+Df0XJNif0wunZS5NjFJQdNGFwMdssU9hxDbh+RZy+rP
	5VjD4Q1uE0ofRvDn8CARDrBu9FZmJPcjBlbWRgP4a9xwfeMxVQgsJVE82XHs8Moe/jahg9jTq2I45
	AYaWq3cT5LD742XhWc4zYk3u3gGkQT9y35OB7+EXLS8BqicwMIUxrlXuWCj8TKNC0fjq9OpE37kTH
	xo57dAUgYVTXw7WHqJ4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga67s-0003h6-D2; Thu, 20 Dec 2018 21:45:04 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga67o-0003TD-54
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:45:01 +0000
Received: by mail-ot1-f68.google.com with SMTP id v23so3317741otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 13:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=hcv/JvV5iX/nX3mmh3kLu2dwoKXyIo05K5vlBzK5ytM=;
 b=lyWpQPjBEZWLy2fkS0LIZR9p8Uy/tEse+qebg5j+Msqipo/TQE2Bnv+ff3iWN0im4J
 anamlUwo5netVj+3zhZ7Zr7kOwa4l842YK4yAn+QEXivU/oH/JqxWT6LpBAGq/4xjjSQ
 9X9J04j/BYW/OpwbL1+8lNzfI7RVOh6iw7RS3rArVkbipyVzZpnNguZlgMwA5u3+SQWO
 AD2zZ5TZHen1P7YDk2PejB4d++vvBYW9+lvZVY51EEBGSoBW9K9uDYOglTKcxk3OL4Bb
 nZ4DhxrD9nTxDTLH4qxLWkrppqZ5THiCu3JVRhelgfuRq3ZM6y2qgCI2KbQHFHbPoFnJ
 H01A==
X-Gm-Message-State: AA+aEWZY69oDvXw3HG6l2q+Qciu314hCYc5WDUR48RQ5oD/v1mFTE6IX
 y8nwj+QXo7aLFvc/GIM77a1WzWw=
X-Google-Smtp-Source: AFSGD/Vidh7Uj11FAIbu0nMgJaHNvlmUWXUUfleb0g+hFYPXfxprte7KTumuMKBNBNixWDmeUnnhBA==
X-Received: by 2002:a9d:2aa2:: with SMTP id e31mr17919017otb.246.1545342289382; 
 Thu, 20 Dec 2018 13:44:49 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id i22sm10821952otp.7.2018.12.20.13.44.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:44:48 -0800 (PST)
Date: Thu, 20 Dec 2018 15:44:47 -0600
From: Rob Herring <robh@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Message-ID: <20181220214447.GA18008@bogus>
References: <20181217153706.25873-1-marek.behun@nic.cz>
 <20181217153706.25873-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217153706.25873-2-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_134500_199825_C65DD391 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:37:05PM +0100, Marek Beh=FAn wrote:
> This adds device tree binding documentation for the rWTM BIU mailbox
> driver on the Armada 37xx SOC (EspressoBin, Turris Mox).
> =

> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../mailbox/armada-37xx-rwtm-mailbox.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/armada-37xx=
-rwtm-mailbox.txt
> =

> diff --git a/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-m=
ailbox.txt b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mai=
lbox.txt
> new file mode 100644
> index 000000000000..2d182d61eb3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.=
txt
> @@ -0,0 +1,16 @@
> +* rWTM BIU Mailbox driver for Armada 37xx
> +
> +Required properties:
> +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"

Don't use wildcards in compatible strings.

> +- reg : 	physical base address of the mailbox and length of memory mapped

mixed space and tab.

> +		region
> +- interrupts:	the IRQ line for the mailbox
> +- #mbox-cells:	must be 1
> +
> +Example:
> +	rwtm: mailbox@b0000 {
> +		compatible =3D "marvell,armada-37xx-rwtm-mailbox";
> +		reg =3D <0xb0000 0x100>;
> +		interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells =3D <1>;
> +	};
> -- =

> 2.18.1
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
