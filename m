Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19754C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4F32133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQQrRqn5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VDR7sJzX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mGv+7yYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4F32133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=06sCY+igPuKZqO7EkTBUqYtQTLQJeihDMPTeajrvj9s=; b=NQQrRqn5C3N0bw
	b4b66irGTG3Re3RISsOPDxgDRDE7qBkGP8lN1PoqWxdvkIviBhMUNpepVL2ugTuMQAFLoY/wNIEPt
	yxoIQRURuEx5ZeXSjzBASt4WoNWKv5eQTf7GZfvsj9Sx+JKZAjMITiiIuj/TCL2QtU/tF8/HQNmvU
	dwqms7Z6U5bGX/nVcCciehzWQm5oFid0z4AeARgPJAoH3k6wNAy+z5GG16J4EPNhqgfErILg1YXan
	vpl9s5T0D51cuXvRJZgw+3iPCb9QbU47dRopgGtpCEovw1bH9zdL1U14WD18HwMCTWPl+UlvGN07X
	GDygE63rgvQUloCXqdog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJmm-00079w-Lr; Tue, 18 Dec 2018 18:08:04 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJmk-00078w-81
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:08:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id AD6C260591; Tue, 18 Dec 2018 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545156471;
 bh=CZWJMySt0adfy6+R4ymfNXsAxv6GOEecswNObgzYxjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VDR7sJzXpL8J10LGF/z1pDa6iheWLVYscquLE7y4n+Rw52PMMrfbRGH//bNlMZs/U
 oD0D21LNJbUpcwXv5szH2F+zCSTQZ+kpU/4Zv9gcpuW8dX28Aj68TGmpPOypbD6HEH
 FL27jaAO6GtgwpMZ2KTCaDXV+bOspNzwl2AFce2M=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D14EC6055D;
 Tue, 18 Dec 2018 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545156470;
 bh=CZWJMySt0adfy6+R4ymfNXsAxv6GOEecswNObgzYxjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGv+7yYi3xVGTNUbKeFfe482GlT8AyUCGr1I2/g3QlE7Td3nMSv7c/gnHKeJyDFCA
 OO3MnHVGG8D6LFkciFLsJP6TA7zMgN79wxk18usYIh0UTFKPLURCSCiPPVIREEIPYJ
 QUnQDAuW6PQ0/JfxdSMNmmqocwNVdYUT3x9pehPs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D14EC6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 18 Dec 2018 11:07:47 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
Message-ID: <20181218180747.GD18380@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dianders@chromium.org, vireshk@kernel.org,
 linux-arm-kernel@lists.infradead.org, georgi.djakov@linaro.org
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-2-jcrouse@codeaurora.org>
 <20181218172201.GA16590@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218172201.GA16590@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_100802_327058_630F7B8E 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, vireshk@kernel.org,
 freedreno@lists.freedesktop.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 11:22:01AM -0600, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 03:16:39PM -0700, Jordan Crouse wrote:
> > Add documentation for the interconnect and interconnect-names bindings
> > for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > index 8d9415180c22..19b5ae459fdb 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > @@ -19,6 +19,9 @@ Required properties:
> >    * "mem_iface"
> >  - iommus: optional phandle to an adreno iommu instance
> >  - operating-points-v2: optional phandle to the OPP operating points
> > +- interconnect: optional phandle to a interconnect provider.  See
> > +  ../interconnect/interconnect.txt for details.
> > +- interconnect-names: Name string for the interconnects.
> >  - qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> >    control the power for the GPU
> >  
> > @@ -68,6 +71,9 @@ Example a6xx (with GMU):
> >  
> >  		operating-points-v2 = <&gpu_opp_table>;
> >  
> > +		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
> > +		interconnect-names = "gfx-mem";
> 
> There's not really any point to having *-names when there is only 1 
> value.

For the moment we can only look up the path from the DT by name. I guess we
could add an lookup by index but I'm not sure if that had already been
considered and rejected.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
