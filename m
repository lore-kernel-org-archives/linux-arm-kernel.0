Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:00:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF96E21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9/FHjMA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABnSorKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96E21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ti0dsBtxGcHhYRGVrpLOHGeCEUUk8HM5S/FFWRpHNE0=; b=K9/FHjMASE3zuK
	EN2S47gwIApjWyZ5inPX3GzTXb+NYqErp9aF1YcFmxyykTvnvnN4obWhwJZKRl/kv0nKqhKwSOZTb
	LUVGM6zRQkKRGa3vN19PavkaSPTXTAKdv9j/K7fvFh1M0qjBQug5S7GdS0DZQhyzZsJzmeZoecWXR
	Rz24DoWqeAqr3t8/KltUKKNl7W08pykHObD2VxJFEQ2zrxs89UfZ38c0hFTmH9HFImmWPCftjNvEL
	M8rUXwhsaWwDLsTHv2MQSoi55j5cjiloy6IcYfXnI+Iy0NGJ4EYqiO2/TfYzp34nDVQaEsRLVhJTt
	JPd7p0JFSPHqkEgc4dwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glmJ5-0002m4-D1; Tue, 22 Jan 2019 03:00:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glmJ2-0002lf-78
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 03:00:53 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA1622085A;
 Tue, 22 Jan 2019 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548126051;
 bh=PFYvwxITMZJrnktk0T8+WI58+cAq0GqRCLh1zXapyeE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ABnSorKqMVdTg/SYPylHgac4p9JabI3zzRcctl6dej4AiHLaCiW0GcPECXeiqHuIc
 85WjLLBazN0m9VTVGgmfrVGoV+k5oXieDQSLvGm/MWVx8RJkvE2OrudbinRYIb7QWX
 ielok1+XIN7Hq08DY4mbTp5PJW6DTvxL0ZUuqYoA=
Date: Tue, 22 Jan 2019 11:00:12 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190122030011.GC19233@dragon>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
 <20190116101441.GH15808@dragon>
 <20190121060950.GA8713@Mani-XPS-13-9360>
 <AM6PR04MB5863AE2A3DD74882BEC680CA8F9F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5863AE2A3DD74882BEC680CA8F9F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_190052_283639_FE3DED92 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "a.tropschug@ebs-systart.com" <a.tropschug@ebs-systart.com>,
 "m.bittner@ebs-systart.com" <m.bittner@ebs-systart.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 07:57:20PM +0000, Leo Li wrote:
> > > So it seems the compatible of the boards below are missing there.
> > >
> > >   ls1021a-moxa-uc-8410a.dts
> > >   ls1021a-qds.dts
> > >   ls1021a-twr.dts
> > 
> > So how should we proceed here? The above mentioned boards are lacking
> > compatible in dts files and I guess that's the reason they didn't get
> > mentioned in "fsl" binding file.
> > 
> > Should I just go ahead and add the compatibles for these boards and list
> > them in binding file?
> 
> Please go ahead and do that.  One thing is that the moxa-uc-8410a board is a 3rd-party board, not sure if it should belong to the fsl binding file.

The fsl.yaml is designed to contain various boards using fsl SoCs, so
it's fine.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
