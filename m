Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB13C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E283420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohp4P/Ct";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CChcZxGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E283420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8TVM/0bq8RIMuUJHDM2LbggA0dhbTi4brWT5B3fMfk=; b=ohp4P/CtSk7CKs
	OZHVRUKe1cI3DFK+jTiDPZqTMosQtKEGzXdfJ4tqMg+PqQBQP5bKNceeA0IqNnpmzW0sHHb/z523H
	ToxLShkZBDWfumerTy9cLIsb096vtkpvjuyPVeYSo+UL3POsMaOTnmaf3qbtIFn0Ghd4oQ8Pu/4YF
	74Mx2xjWHe5I8ySeVq7qrTaUbh2E/JP901K3ZkstmOE8DYzOadv4Dvf99Yl1zuVCHhPOBjIYQbRC1
	IXjF4WM59rS3dxW2pmv34MZXZXjtwMuBIuZ/kT/L7cgwCHmODjEq9Mx9nsF6Ia4OpC0MsbmGNyX8e
	/Cp6RZL97o+xrs5siBkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwS0W-0007pt-GP; Wed, 20 Feb 2019 13:33:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwS0S-0007mh-Uf
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:33:50 +0000
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B675B21902
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550669627;
 bh=q+uXsa+PqEQd6PETRf6Wmpahx238+Gu3Bou97z5f0hM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CChcZxGISMK/IavizcfUdxzQE5FUKsOWdW6LmD8RdygyQex3A9aWbl0Rk84FEm8LN
 vV1HR68pnJlqBI55TuOTEETbL/mb6m4BgtgXzr2vdQ2/jOamCZp/c0ju6qT5JCjdDV
 EpRnc5ZuwzPKDH8ohAnXIzOzZsY2Xb9hXNcaZCpY=
Received: by mail-qt1-f180.google.com with SMTP id w4so27184833qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:33:47 -0800 (PST)
X-Gm-Message-State: AHQUAua1OoCuCTSvQ9Zy7TeErxQR9QcpQIl65CMpZq5VwEJbPsMVJhFM
 ndvBt6fTdAhXYvLgDcZucibuo8WAv/1LQ6dmYA==
X-Google-Smtp-Source: AHgI3IY+piLFFNDJGG5O+6N9zvc3xOFz32YoBd1q2JLclT/yG8io879Da0ELpzXWW287DJoin1NsJ03iynhLCIq3htY=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr26036439qvq.106.1550669626898; 
 Wed, 20 Feb 2019 05:33:46 -0800 (PST)
MIME-Version: 1.0
References: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Feb 2019 07:33:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Message-ID: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: Add documentation for Milbeaut SoCs
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_053349_022092_BC488306 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 1:43 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
> new file mode 100644
> index 0000000..522396f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
> +$schema: http://devicetree.org/meta-schemas/milbeaut.yaml#

This line is wrong. All DT schema should be:
http://devicetree.org/meta-schemas/core.yaml#

> +
> +title: Milbeaut platforms device tree bindings
> +
> +maintainers:
> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
> +  - Takao Orito <orito.takao@socionext.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - socionext,milbeaut-m10v-evb
> +          - const: socionext,sc2000a
> +...
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
