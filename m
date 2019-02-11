Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A1B20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GeRXXOKt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="FNbZIcye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A1B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OfNTgR+zAYfl+WPYrkd+DofRInzlKZ/t7ssYHq0mK30=; b=GeRXXOKtq5JCCBLJA6biL3SxrU
	GhDR/CnlkVN+//a6LDOOSjGkAlvIA8PG5hcRxtRYp9CTD10JXt3jdUS2MAZQG2yfSWSHPivLpF02I
	IHicE7hrHioVMxFlyiv/CIxowbO/Zd9QJ95dHgpvn4gY0kRQ9a5D14o6h+rqlz17+t/hMYomCCcS2
	z1p7n/2Omjd5t74bOnvw3RPYTVF0tUi24GlbFBXSR+i8HadlvH1YUAw+aWO+KZOPSAndRPa+JDfE9
	23W/2w4g//ifAecfZbPUy4v664myUBUGTMtl8xV9eY01sHjIHwFPMzOYbrLlf6ya4PLJMHSCtSgyr
	tD8ZRwgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCcB-0007Oz-8G; Mon, 11 Feb 2019 14:31:19 +0000
Received: from hostingweb31-40.netsons.net ([89.40.174.40])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCbj-0006Xo-Mp
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lucaceresoli.net; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FFBmXTFfBaLH3E7i5uEuHI1tsd9hSjt1JGYFR5EmZAQ=; b=FNbZIcyeIW/IpXcw57jEEOvIQR
 jqtVa/s3cL/Fw5zTtq5IEDT3STamGaJrm5VmnJ14e9rWQV2vClwUsRLPmei9S5yam02FEw5NTW6Xq
 FS2+9D+9N/hG0pMyPd+L481GZMUGzX8o8Q8Y/iBcLoJHDoC6V4vyJSOn8DlBPHSCzY8M=;
Received: from [109.168.11.45] (port=32896 helo=[192.168.101.224])
 by hostingweb31.netsons.net with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <luca@lucaceresoli.net>)
 id 1gtCbg-000mJq-3j; Mon, 11 Feb 2019 15:30:48 +0100
Subject: Re: [PATCH v3 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem
To: Vishal Sagar <vsagar@xilinx.com>, Vishal Sagar <vishal.sagar@xilinx.com>, 
 Hyun Kwon <hyunk@xilinx.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Michal Simek <michals@xilinx.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
 "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dinesh Kumar <dineshk@xilinx.com>, Sandip Kothari <sandipk@xilinx.com>
References: <1549025766-135037-1-git-send-email-vishal.sagar@xilinx.com>
 <1549025766-135037-3-git-send-email-vishal.sagar@xilinx.com>
 <3923069f-7c69-c601-0ded-f7629696ef9b@lucaceresoli.net>
 <CY4PR02MB2709000898D5E290B5EE99F4A7640@CY4PR02MB2709.namprd02.prod.outlook.com>
From: Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <7fc3bd7b-4537-3df5-12ee-55ebec17a8bd@lucaceresoli.net>
Date: Mon, 11 Feb 2019 15:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB2709000898D5E290B5EE99F4A7640@CY4PR02MB2709.namprd02.prod.outlook.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id:
 luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_063052_043516_E5E4A405 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
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

Hi,

thanks for the quick reply.

On 11/02/19 13:43, Vishal Sagar wrote:
>>> +static int xcsi2rxss_start_stream(struct xcsi2rxss_state *state)
>>> +{
>>> +     struct xcsi2rxss_core *core = &state->core;
>>> +     int ret = 0;
>>> +
>>> +     xcsi2rxss_enable(core);
>>> +
>>> +     ret = xcsi2rxss_reset(core);
>>> +     if (ret < 0) {
>>> +             state->streaming = false;
>>> +             return ret;
>>> +     }
>>> +
>>> +     xcsi2rxss_intr_enable(core);
>>> +     state->streaming = true;
>>
>> Shouldn't you propagate s_stream to the upstream subdev here calling
>> v4l2_subdev_call(..., ..., s_stream, 1)?
>>
> 
> This is done by the xvip_pipeline_start_stop() in xilinx-dma.c for Xilinx Video pipeline.

Indeed it does, however other CSI2 RX drivers do propagate s_stream in
their own s_stream. Not strictly related to this driver, but what's the
logic for having these two different behaviors?

Also xvip_pipeline_start_stop() only follows the graph through
entity->pads[0], so it looks like it cannot handle entities with
multiple sink pads. How would it be able to handle e.g. the AXI4-Stream
Switch [0], which has 2+ sink pads?

[0]
https://www.xilinx.com/support/documentation/ip_documentation/axis_infrastructure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf
(page 16).

-- 
Luca

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
