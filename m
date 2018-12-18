Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:01:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E21218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E23enOa/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPnmjO48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E21218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/B+aGlTfuquWOHTSNXyC0CrR+Mv61J85WSv7tnZGsE4=; b=E23enOa/IhXh1S3VBEJHcawTG2
	Xcn4H+G/0dt2SwpjqNopqFDXJcGzp/9sXL48rT/RsKxcnD7kmIIrtVO6oBuMYYIxd9yfVQ9CffFB7
	QKFhgblwJrXH412rsMGfJspNjC4cfk/dIF5ywJG1X+moroRMYmocIjNucSNOWNY/xT9Tacmf3fECs
	lkYYSklTsutRRcVb3gYMTLcd7JxgclkdzQX2wevwrznsQCPHY4iWkyf9AJkUUZR9IQK9O+S5lk6Jy
	Z7svkO/sJyWPzcEqM0IpqrtO1ClL8+9fzsEw8NZLFT2HRvz8imalXpmFlWLMJq1ExYOtHUAVPJUGk
	baaDKlOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMUd-00088x-7o; Tue, 18 Dec 2018 21:01:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMUa-00087x-89
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:01:29 +0000
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 197BA218AC
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 21:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545166877;
 bh=26VOuUcNQaHsneKjRQ6p1sM/j+p3OKUxV/F9GdMs6xc=;
 h=References:In-Reply-To:From:Date:Subject:To:From;
 b=cPnmjO48YYbwBR0kS07n35y5lE1AZ2oNb4lby0C97rsOx6Gor3W7G73HPQktHxO1v
 Y9R7YZYA3P1uvrquX0r/+UKI9mhgD7IeZ3uSKJ6ZRWYw9XgacYfNakXGC9g+v34zO3
 kpS3ZPqIFS4bOAOv/Ez1CdseTev1CsCUiIqtm2YQ=
Received: by mail-qk1-f181.google.com with SMTP id a1so10333020qkc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:01:17 -0800 (PST)
X-Gm-Message-State: AA+aEWZQFZU/otFNCO6xh8gtYreJOMFPd5VKGkuWSB/9aUDpBPLiC4xc
 24gzZaVYcg/1A/9Tzv7JseOC1E9YaDBcmqV4vQ==
X-Google-Smtp-Source: AFSGD/Vqd6QRKqCgHnPa2zOaYbvGugR8QSae2qOrY7JTogWMlpGi1FboyVpS6t+EyxyZ0rrM/7Psc327mxuQH0RkinM=
X-Received: by 2002:a37:5686:: with SMTP id k128mr16736309qkb.29.1545166876261; 
 Tue, 18 Dec 2018 13:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-2-jcrouse@codeaurora.org> <20181218172201.GA16590@bogus>
 <20181218180747.GD18380@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20181218180747.GD18380@jcrouse-lnx.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Dec 2018 15:01:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+8g4uCH+YYNJnACc4mJkK+Ogn0pHLva+6XPynWTrqLw@mail.gmail.com>
Message-ID: <CAL_JsqL+8g4uCH+YYNJnACc4mJkK+Ogn0pHLva+6XPynWTrqLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
To: freedreno <freedreno@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, Nishanth Menon <nm@ti.com>,
 devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, Viresh Kumar <vireshk@kernel.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_130128_323622_AE7060A4 
X-CRM114-Status: GOOD (  19.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 12:07 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Tue, Dec 18, 2018 at 11:22:01AM -0600, Rob Herring wrote:
> > On Fri, Dec 14, 2018 at 03:16:39PM -0700, Jordan Crouse wrote:
> > > Add documentation for the interconnect and interconnect-names bindings
> > > for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > > index 8d9415180c22..19b5ae459fdb 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> > > +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > > @@ -19,6 +19,9 @@ Required properties:
> > >    * "mem_iface"
> > >  - iommus: optional phandle to an adreno iommu instance
> > >  - operating-points-v2: optional phandle to the OPP operating points
> > > +- interconnect: optional phandle to a interconnect provider.  See
> > > +  ../interconnect/interconnect.txt for details.
> > > +- interconnect-names: Name string for the interconnects.
> > >  - qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> > >    control the power for the GPU
> > >
> > > @@ -68,6 +71,9 @@ Example a6xx (with GMU):
> > >
> > >             operating-points-v2 = <&gpu_opp_table>;
> > >
> > > +           interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
> > > +           interconnect-names = "gfx-mem";
> >
> > There's not really any point to having *-names when there is only 1
> > value.
>
> For the moment we can only look up the path from the DT by name. I guess we
> could add an lookup by index but I'm not sure if that had already been
> considered and rejected.

You don't have to support lookup by index, just support a NULL name.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
