Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1952C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D9F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxRAq78p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D9F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rSgCQu7lz553cBiKxQD5d+FtQ03oWmjdfx+mhPBhYIk=; b=FxRAq78pQ+Do2a
	5CBqr+TE//hDxJMKwtsYLtkc8qcpdEy9xgsVc7FiRKvbz3yxHv67Lt5B24QO7o0RPqGrAMxKON/iU
	0XBoOP9UYt+0S+fQeKsFsJ5lUte9WFPwki11H/zUAfXPkReOGNzTbq6B5ib17LBCfMvtNmHEDGKHg
	i5gJHjdjlgkcFJ0bpNb9+kzEZOtaY88KKLbetlRFQ8UA+q846V494qCy5TS3DpcArxIklU5uhPMUy
	LbLiHmyAscEurasCvlwRcl23FRhGzIHcJDSWIyjQmnACjfSdnUgRE8pEaae2OvSvnbcnw/dwx++3C
	YXedugykmr/TleSNu2gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlfz-0006up-4o; Mon, 03 Dec 2018 10:42:07 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlfv-0006rj-U0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:42:05 +0000
Received: by mail-ed1-f68.google.com with SMTP id d3so10270471edx.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Im80WWWkrd2/JvoAz7JLYb++LqOvBai9fapBNVVQADA=;
 b=TaR+jpaGkRsC07LlxFY5uHsJw81FOgPRn9RdhrnoWrTwRabWEe4VPeefrg5Zm95NI0
 x/V4avqoJ4QJ8jdOYvZ7U1yJQ+bckICm7E+eWw+IZawcsNYENoiSNjFDUAgV9zvof7TN
 FPAwEvS5XKIYVAO5JDRCJiCGNRlj6YSBXTKDg/C7uTiTEQUVuclGXeoTcuDU2tEVWwBj
 t+l4M/k/L9HrpF0SVXfaolmz4qBc+/jAGN34HcdS3taa0krmgm3ErO0CxuLar4/e26Cu
 8/8+d/5GTdEBBhgHWvcVyKzpxbLtACPqKSV+ldEQDv0lP0BWjAHJgYheNWfwrh8viqxI
 Ts9A==
X-Gm-Message-State: AA+aEWbt25Z++p2pgGIHs8/MRXfDfVKvG/lpgFnkH5DUfsl7ofX9Xmi6
 a1jymKh3UGv8U3B4rY7dGx8Buf+9lvaHbQ==
X-Google-Smtp-Source: AFSGD/VqJjmVoWAXVsxkJLwkWNwTYxXUAZ3wjMVLvEDfTkQawLNBWbU7TpikWp/IDTpOivO8wCtXDg==
X-Received: by 2002:a05:6402:1347:: with SMTP id
 y7mr14249489edw.114.1543833712389; 
 Mon, 03 Dec 2018 02:41:52 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id g5-v6sm2133967ejm.15.2018.12.03.02.41.51
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:41:52 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m22so5110509wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:41:51 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr7543181wmh.124.1543833711378; 
 Mon, 03 Dec 2018 02:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com>
In-Reply-To: <20181203101547.16835-5-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 18:41:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Message-ID: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_024203_961864_266DA3ED 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.

"External pull-up regulator" sounds fishy. Chips have power supply
pins, either combined, or separate rails for analog, digital, and I/O.
For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
and description you provide match none of these.

If a regulator is needed for pull-up resistors on the I2C bus, this
should be referenced in either the I2C bus master node, or if the I2C
bus goes through a pin controller, in the pin controller node.

Putting the reference in the slave device node is wrong, since it
doesn't actually use it. It becomes even clearer when you have multiple
slaves on the same bus, and you reference the same regulator in all
of them.

Or, as a last resort, you could mark it as always-on with a TODO note.

ChenYu


> So, document the same as optional property.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..604766e347ce 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,7 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - vcc-supply          : 3v3 regulator phandle for controller VCC pin
>
>  Example:
>
> --
> 2.18.0.321.gffc6fa0e3
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
