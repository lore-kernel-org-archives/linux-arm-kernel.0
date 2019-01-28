Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBDB20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pGMA0nU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBDB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktvkd3E+UJwNf+DxQQoNi1iOkYIFAGWD+w2nOeHsITQ=; b=pGMA0nU8N6IJ2q
	XvSH6b3zVtsV8A/N10A3EG2NENNgZUyl4Io/SE+/X4gnOvc59gg9gkH1/D5vF2yXHOAMB7TdyvBPa
	6Ax/HjKV4Sh9pa51TV7PDii4JmK+dkwKJC6ifDTsNSYD48DQ84lC+qo+XH46+tYjYyGAggIt9LeRd
	C4nIzFtdsvxDylb5Cd8tbk0zMVE0HnSD1JqCXoweM2HVxqT/1EkvF+6hOnfciLcn30OWH3VY1MZpD
	cZgzYWaGlHstPsthv2eJWng1CAAYAMpb4vIYM0mBYE8mDKWAy7MVl8PWQG9gkVX4IgVz6D38bjyPq
	ABzgBa6qkxkuNSdC+MBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go6i6-0002yS-UG; Mon, 28 Jan 2019 13:12:22 +0000
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go6i1-0002xc-Fl
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 13:12:20 +0000
Received: from [192.168.2.10] ([212.251.195.8])
 by smtp-cloud9.xs4all.net with ESMTPA
 id o6hegsMrzRO5Zo6higK9LD; Mon, 28 Jan 2019 14:12:04 +0100
Subject: Re: devicetree: media: Documentation of Bt.656 Bus DT bindings
To: Ken Sloat <ken.sloat@ohmlinxelectronics.com>
References: <CAPo_4QDW0r22ZTqtS_NDFWB3NFLBx9YEGgWKb-P9A3t_TBAFMQ@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c4d68627-b26a-6402-daf4-5cd103ec9fd0@xs4all.nl>
Date: Mon, 28 Jan 2019 14:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPo_4QDW0r22ZTqtS_NDFWB3NFLBx9YEGgWKb-P9A3t_TBAFMQ@mail.gmail.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfNqOlEe9iW/LBZ3As+QKI1eqmbAhYgnj7aQy9UJibCeZDomK4hs3lamUow/ou4C+LJp80z+2fYCBabQbVAUAv0BlV1zNDbVZPHP0a7EDfxT7H+oVu7zb
 JbPry7gs/NSrDgUBsk5oGKz+/nMYbsfeN1t0LiwAJMfENvQL8hZLgdFKymxEx6nsK5VBwKQLjH3WMGTE0cWCdGx4qu8SCxVilmklgem7SwyOd4Fo8B21ISfd
 ANDhcFov1gDvDaH+6l/Hvkw/MRDda7rziExEkU5oD3j+Zbncc2x1HK1LhWr5i6QNtrTDIQ4xGn2kSEJzGLVtX0PUQwJUGT3jR9qlxV8gVjyEcXyNsBRqeE87
 F50OIAax3dlKqmXlPyuPjwpUWUS5xjuUiWVyFNX7U7bPqhteLBZRRKEFSs+A8NNSgO/NO3q9UgY6LrbcaMpRRyN464w4hIdFE0lTgIJVbSCzjyRIUkAcXcej
 Z/IYy0pFUXcQQRi0APHBfjRet/JClO7zcJapxvzwsUctvKJxZiU91+1OGLGUISHkVM+25zvXtXxlbjjS3Rot1UcCvOud+CFTTPLVk+jAjCG/vGAIgps/p6vD
 MKS84UG1kdm8iGPsBv/HyjsyQ11bk+E4EtL7SP+MIqCaeGvYzD2NFQbk1a09dMijz5w7OslhcWTJ/54mLkv0oGPaf/7PsPxyz/PGDLcOH8B/0zYso6jeHmTt
 /jrryYuQLeFuHiozNq8yzRLBuUViCo4r
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_051217_938846_1CA95EBC 
X-CRM114-Status: GOOD (  18.53  )
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
Cc: mark.rutland@arm.com, Nate Drude <nate.drude@ohmlinxelectronics.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, maxime.ripard@bootlin.com,
 linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com, wens@csie.org,
 robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, yong.deng@magewell.com,
 jean-michel.hautbois@vodalys.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+Sakari

On 1/24/19 3:53 AM, Ken Sloat wrote:
> There are a number of v4l2 subdevices in the kernel that support a
> Bt.656 bus also known as "embedded sync." Previously in older versions
> of the kernel (and in the current 4.14 LTS kernel), the standard way
> to enable this in device tree on a parallel bus was to simply omit all
> hysync and vsync flags.
> 
> During some other kernel development I was doing, it was brought to my
> attention that there is now a standard defined binding in
> "video-interfaces.txt" called "bus-type" that should be used in order
> to enable Bt.656 mode. While omitting the flags still appears to work
> because of other assumptions made in v4l2-fwnode driver, this method
> is now outdated and improper.
> 
> However, I have noticed that several dt binding docs have not been
> updated to reflect this change and still reference the old method:
> 
> Documentation/devicetree/bindings/media/sun6i-csi.txt
> /* If hsync-active/vsync-active are missing,
>    embedded BT.656 sync is used */
> 
> Documentation/devicetree/bindings/media/i2c/tvp5150.txt
> "If none of hsync-active, vsync-active and field-even-active is specified,
> the endpoint is assumed to use embedded BT.656 synchronization."
> 
> Documentation/devicetree/bindings/media/i2c/adv7604.txt
> "If none of hsync-active, vsync-active and pclk-sample is specified the
>   endpoint will use embedded BT.656 synchronization."
> 
> and amazingly even
> Documentation/devicetree/bindings/media/video-interfaces.txt in one of
> the code snippets
> /* If hsync-active/vsync-active are missing,
>    embedded BT.656 sync is used */
> 
> In order to avoid future confusion in the matter and ensure that the
> proper bindings are used, I am proposing submitting patches to update
> these docs to at minimum remove these statements and maybe even adding
> additional comments specifying the optional property and value for
> Bt.656 where missing. I wanted to open a discussion here first before
> doing this though. Thoughts?
> 
> Thanks,
> Ken Sloat
> 

I certainly agree that this should be updated to make it all consistent.

Regards,

	Hans

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
