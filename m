Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A60DC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD78220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="csB0fBR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD78220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lUDgJmkGbcwBdnT3GTo5Sm2hWZamL9/w1Mhar4S6NsM=; b=csB0fBR1mAdERJ
	p7FU6vQ9M2aW4l9q7qdHoQoTNuf7bmEhPyAKYzLTb6Un/TH5ZU53lJCsGgbiQJivH8Ia+vudZaKpZ
	Ut2rKObSgJRcR/h643gpXEgKGoikJb2LuNW3TLmuOtfOX6q9njknKK+BQ86s713m8KguYejNe/aX5
	+/D/B3Nzeh7t03RhyAYZFKZw63ZkIJPB1C31PuvznyYOKDTfqyIMh7up23fbQt2QijgIJO3+yJDBF
	AYH7kfSzkos4sROi72frQfKqssAVQNTHUOeJjWEmj/A/TKVMt0loYSosWnoS0jduAcRvqNlIfxLp3
	qVf2YtGkTV+qdwO7X3Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvpey-0002tl-3C; Mon, 18 Feb 2019 20:37:04 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvpeu-0002tH-Rg; Mon, 18 Feb 2019 20:37:02 +0000
Received: by mail-ot1-f66.google.com with SMTP id g1so30413140otj.11;
 Mon, 18 Feb 2019 12:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mxTMXYrQIwaNJervkd9UktCFa4U1xZCoJrS9clPs9rc=;
 b=OgHeUZxBD6yu2BHzmdfgSGqvACUKj3aq+Muk3GML98QsxqHRBKW6hwaRLTXmyVm7Ld
 gxYfQsVyAhjgQuTcj+giFR9VGAaaWKQwMhB4ZdfR45VRaKdMqbn8IpY/7v9gtsnB1lpf
 gcjO1Qdfl1g6gC9DybQcxmLFjjU2ycGwzihZGribJCid8Yu+tO0KiAOLGGAMLiTKlsD2
 azm+nL/jSw0lF3lPWRd3oIQTt1ynP0Ip3b5HxxYRf/ZNpyIURQ9G6uMYV/M5yN5e8tME
 zz+LphG0zsZBiz1d5fo7muJzHuKPC7zx4U/EYVt96vwy3DKkq/ejfWuo0kXjtNE5WsOK
 xNfA==
X-Gm-Message-State: AHQUAuaIIm/hLD7/qpcyq3LfG3K706AqImsCEFckPFQER7EmIDD4uRIb
 dP2J1fsdD8n3RocFcTzZbQ==
X-Google-Smtp-Source: AHgI3IZidzAY1kaiVabOklIT35gFFtEIRuv/9Ogn0zphHxPV4aZb1e1q912vUQv4RpYplx8xgWsBOg==
X-Received: by 2002:a05:6830:1092:: with SMTP id
 y18mr15795045oto.125.1550522220168; 
 Mon, 18 Feb 2019 12:37:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r132sm3524453oie.20.2019.02.18.12.36.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:36:59 -0800 (PST)
Date: Mon, 18 Feb 2019 14:36:58 -0600
From: Rob Herring <robh@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Message-ID: <20190218203658.GA20434@bogus>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_123700_898645_C6BF9246 
X-CRM114-Status: GOOD (  19.44  )
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
 linux-pwm@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> 
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" in example so that we could
> > set the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> > Changes since v1: add a Reviewed-by tag.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 991728c..f9e2d1f 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -20,6 +20,7 @@ Required properties:
> >   - pinctrl-names: Must contain a "default" entry.
> >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > + - mediatek,num-pwms: the number of PWM channels.
> >  
> >  Example:
> >  	pwm0: pwm@11006000 {
> > @@ -37,4 +38,5 @@ Example:
> >  			      "pwm3", "pwm4", "pwm5";
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pwm0_pins>;
> > +		mediatek,num-pwms = <5>;
> >  	};
> > 
> 
> Wasn't there a comment in the last version to use num-pwms instead of
> mediatek,num-pwms?
> 
> Uwe I think you requested that.

Perhaps, but why is this needed? Typically, this would be implied by the 
compatible or the driver doesn't care and we assume 'pwms' properties 
are not out of range.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
