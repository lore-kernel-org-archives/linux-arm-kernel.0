Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E151C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03D42184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLcomx9R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tck0e3L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03D42184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xdmNPnkPXcTO6z/Ybn2p+E2n/jTQZIQy/+IUOhDHBOE=; b=cLcomx9RHwTbRG
	yRArOeNJzD7K/AwD52XID24wCQQxnSXlJBCuyCgBvtnvbeHHmB05C9JO3zfLFwO50Qgfw9NS8V5d+
	VTwHaWH027bmpbz4y0nDuyj0SQUpA2MlaQUqsq4uk9C2A8VeC0I3CR1POBwfMHOcT6rQNOq1Nl0As
	GWnZX7lDVjtFk6GIPHhcmtojpHsBv4m833W98M0fJdyFQ32NIrBAS2wGRjS+aQh4NAOXhcTpMvXkd
	MPgXBPUTjxkQjSa4k8Qxyq/sHzJEi4X91329NYsC4bEh3iu746Og8u0osVrXFQygyGYONzWQAYnU8
	/1g3CJJiHXAjIlJWXgcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtKRI-0000qv-L3; Mon, 11 Feb 2019 22:52:36 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtKRF-0000qQ-8V
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 22:52:34 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so271102plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XkKVq/8YxcrEOQwVCbuBDMgtKLsHcdS0tQuJaBdeHBY=;
 b=tck0e3L2XqSalXWf6Rot4bV0jKcZ2RvzuV/ZPvJz9mFxuBBcCiDD2MelQVt+zptdAg
 Eeh3vTGHWFmkrGo+IEuhsJ3JwWXVmrhk25IWmtVgGxT+Ho2L7M9ydSdI9vg9JBiVNQkU
 PuONjo26mNVBPrkk0LDro6DpCl6sSzDjhv+sG2WmfpT6DjYtcRz9u2u7lamMBq2NGBzq
 U4fKpel7GgrS6GEYPOMM4W+eUeIxd+Ra//3gWyn7GZhZGvcmijtWBDOxbBsF7RxR4fx1
 R1elohylhKJcGaZhDqqHpga1V2VhfHAKpcH4RfzS5LRUuyGtVlsnNy0F+2NHx2Sg26zd
 PRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XkKVq/8YxcrEOQwVCbuBDMgtKLsHcdS0tQuJaBdeHBY=;
 b=rZP2dx8moJxB1tF2Pjhqnd4q6DTKMiajWweud4l4PZuMf6HQyekNcugomp3JyeDtkg
 AVCIjmfxDIpLvoNkgFCjiRHTuX/ra9RbRJ+gLXAtfPMtZW9gJk+xQIU5hplnp0K1EDfO
 iLgscpLyWetByqPErF3S73bNycfBbFqUDPIv4NJmaVfMv0JE+J7JgMNwye0NQVtmWl9m
 NVxh3GOTKdYvysLE6XibBX+DuntzjvD5Rngb87rJ17DVJdMVyNIew7A1j9mKN8FF14cy
 3ONDStqVtkNHephFdghiMUHxLFyTGomPQnZDRCtXb5nn0uopgGHaQ5qjFM0bqbYH+MaS
 Mreg==
X-Gm-Message-State: AHQUAuYj+xQYIQ6nDbBPvqzIT7CuIvxAEAL3h6v0b5JLQHPXLenDdvrq
 Y3DY5FMbhSPkiyDlkYdH02I=
X-Google-Smtp-Source: AHgI3IaGp8/XDER5aw0klCxLBvbTMkLIn8Kk4kuIYqVnD4UI7pjORU9xJwuNlJMWAUj/rswmZDbeYw==
X-Received: by 2002:a17:902:2887:: with SMTP id
 f7mr671452plb.176.1549925552130; 
 Mon, 11 Feb 2019 14:52:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id m13sm14080322pfi.32.2019.02.11.14.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 14:52:31 -0800 (PST)
Date: Mon, 11 Feb 2019 14:52:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Message-ID: <20190211225229.GF149505@dtor-ws>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com>
 <bd0b4bf2-dc14-2f9d-1350-25996a46760d@mleia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd0b4bf2-dc14-2f9d-1350-25996a46760d@mleia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_145233_326112_E74E0FE4 
X-CRM114-Status: GOOD (  21.39  )
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
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 11:22:40PM +0200, Vladimir Zapolskiy wrote:
> Hi Rob, Dmitry,
> 
> On 01/26/2019 04:29 PM, Vladimir Zapolskiy wrote:
> > The keypad controller on NXP LPC32xx requires its clock gate to be open,
> > therefore add description of the requires 'clocks' property.
> > 
> > In addition adjust the example by adding description of required 'clocks'
> > property and by fixing 'interrupts' property.
> > 
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > ---
> >  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/lpc32xx-key.txt b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> > index bcf62f856358..2b075a080d30 100644
> > --- a/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> > +++ b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> > @@ -8,6 +8,7 @@ Required Properties:
> >  - reg: Physical base address of the controller and length of memory mapped
> >    region.
> >  - interrupts: The interrupt number to the cpu.
> > +- clocks: phandle to clock controller plus clock-specifier pair
> >  - nxp,debounce-delay-ms: Debounce delay in ms
> >  - nxp,scan-delay-ms: Repeated scan period in ms
> >  - linux,keymap: the key-code to be reported when the key is pressed
> > @@ -22,7 +23,9 @@ Example:
> >  	key@40050000 {
> >  		compatible = "nxp,lpc3220-key";
> >  		reg = <0x40050000 0x1000>;
> > -		interrupts = <54 0>;
> > +		clocks = <&clk LPC32XX_CLK_KEY>;
> > +		interrupt-parent = <&sic1>;
> > +		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
> >  		keypad,num-rows = <1>;
> >  		keypad,num-columns = <1>;
> >  		nxp,debounce-delay-ms = <3>;
> > 
> 
> if you find time, please review/ack this change before 5.0-rc5 to give
> me a chance to push it through ARM tree, thank you in advance.

Sorry, I guess am a bit late, still, the binding is already used by the
driver so we should acknowledge it.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
