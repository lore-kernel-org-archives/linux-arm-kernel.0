Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3626FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED102214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dtTfsn43";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="US3Y+l4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED102214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76WSX1nAWPv91E5G4AvseX3kIBvvRvyhXxCqgHFR4ZA=; b=dtTfsn43Gb+tXh
	Zn4N0iOF3hXoCgANAYPL3SU3sBofFBVnhAKWPnKGbvFJvccfKnQ5jafdtLLM0H1Jpf55v9C+xkFk/
	3+I9pE1IIrDMjBIBT1LbmYd3aLGVn4tMnJjoRcHVSRmg+95xowFL/lr8Pnd0rJ85M/xONJOGhKXFT
	4DUf+nir/jM1l5NXyR4lJcSn6oYAT6AlOhCKg2o3erLxXuaqy2ImHszGplAoMOE5W5gD/ubLr9uC5
	5fsk+RA5B+D1oaOaQKhJXAq9vws99CYhVi7sR/L1uEkvJHvL7GWBe5ABSTZBT7vk7KiX1eVx4r77T
	Nw2avL2hqUuDtctgurfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPkc-0001cX-B1; Tue, 29 Jan 2019 09:32:14 +0000
Received: from smtprelay.synopsys.com ([198.182.47.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPkT-0001bE-Pz
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:32:12 +0000
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id 4353624E1EDF;
 Tue, 29 Jan 2019 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1548754323; bh=T8xt9DV4Evb83hu3XlaYtwGmgqnA01LowFK5T6MxA+g=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=US3Y+l4tk65am5djE6ojNK9ky4inwssLNsuM4kRMyJnrJ3HsjawMmMEkGiBigTnRm
 g4Oy7OvHmatmVDOtqCJ6lvgOt5cNlOnSsMEnRi2/EuZx+GG2V90Bjp14gl8fd5voox
 wUhrmXZBN8ue7DV5f88DbjJYoktsWrj/lqwfz1y4blj+IHj9QbnxdKJOZZc3h7QIE8
 CTmsc5sM7gstam/Sp4vKadIOjSra+Y+vgmIQjg7Sw3jOMlzx9TUWuExq3q59ji6xDX
 G6cbJT6SKnnDtMuepC6Q8ijiE0xh3Pojvil9JGb6SvFpa96g+XS4ZmkuC17Q9lRHVE
 HeH9H5Ju4b+5Q==
Received: from us01wehtc1.internal.synopsys.com
 (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id E060EA00A7;
 Tue, 29 Jan 2019 09:32:00 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Jan 2019 01:30:03 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Jan 2019 10:30:02 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Jan 2019 10:30:02 +0100
Subject: Re: [PATCH 18/24] PCI: dwc: Fix dw_pcie_ep_find_capability to return
 correct capability offset
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Rob Herring <robh+dt@kernel.org>,
 "Lorenzo  Pieralisi" <lorenzo.pieralisi@arm.com>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-19-kishon@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <13501c15-8f3d-604b-c4fc-bde3fb208745@synopsys.com>
Date: Tue, 29 Jan 2019 09:25:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114132424.6445-19-kishon@ti.com>
Content-Language: en-US
X-Originating-IP: [10.107.25.131]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013205_950992_A9E8572D 
X-CRM114-Status: GOOD (  23.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kishon,

On 14/01/2019 13:24, Kishon Vijay Abraham I wrote:
> commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
> adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
> __dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.
> 
> However if MSI or MSIX capability is the last capability (i.e there are
> no additional items in the capabilities list and the Next Capability
> Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
> even though MSI or MSIX capability may be present. This is because of
> incorrect ordering of "next_cap_ptr" check. Fix it here.
> 
> Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index d5144781005b..cd51b008858c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>  	u8 cap_id, next_cap_ptr;
>  	u16 reg;
>  
> +	if (!cap_ptr)
> +		return 0;
> +

Supposedly this was already verified by the function that calls this one.

>  	reg = dw_pcie_readw_dbi(pci, cap_ptr);
> -	next_cap_ptr = (reg & 0xff00) >> 8;
>  	cap_id = (reg & 0x00ff);
>  
> -	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> +	if (cap_id > PCI_CAP_ID_MAX)
>  		return 0;
>  
>  	if (cap_id == cap)
>  		return cap_ptr;
>  
> +	next_cap_ptr = (reg & 0xff00) >> 8;

This fix seems to be a bit overdone, especially when you only need to swap the
if blocks order to achieve the desired goal.

>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> @@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>  	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>  	next_cap_ptr = (reg & 0x00ff);
>  
> -	if (!next_cap_ptr)
> -		return 0;
> -

Why remove it?
If pointer is null, why to jump to another function to check is the the same
pointer is null?

>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
