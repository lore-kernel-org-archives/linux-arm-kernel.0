Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F8C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA427218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tT737Sst";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I8XHN5yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA427218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2nOw8NeX86U73fCzYORAUu0VFOgY82qT5323UpRkuJk=; b=tT737SsttcKPeq
	jA+2j2v+0EF/vemikJro2rVjo+5d2AZ2LK3Z+7UiUKLqFovzANBAmKxc9J+j+OiFAR2wNGxt0Rfax
	fxWtvoho8UcVv90+UxB6ZZAz1CChhzeIG0kC6Y3+Wnxh1dOBORaMnszQ9Byy/eywBURoLnBLCX2Eh
	gsx5WNqhAhYFkd6L/B8UP/ZbIaVX690PiA9orm6nrC7V6nZdfJoHj9CexKOuzxwqGsNekpNcLqgGc
	g7L5Xo6D/jgtC0llx5CfO0mWzQejvyYo4cJcBRjN7e0fVcNTu59FC615VrD6Qa/tIQJq8FCIarLhh
	WEVTy/Ze0WFOD+l0rxSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz7H-0004U9-Pp; Fri, 25 Jan 2019 10:53:43 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz7E-0004TM-4w
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:53:41 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4aeab20000>; Fri, 25 Jan 2019 02:53:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 02:53:39 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 02:53:39 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 10:53:37 +0000
Subject: Re: [PATCH 2/7] soc/tegra: pmc: Add missing kerneldoc
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
 <20190125102255.6862-2-thierry.reding@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e6c3fbbb-123c-0797-d486-6f9962dea84a@nvidia.com>
Date: Fri, 25 Jan 2019 10:53:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125102255.6862-2-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548413619; bh=9lxRN5tljFfcnUuGqs+/AcFNUdisABtVSZPbh7Vms+I=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=I8XHN5yfmgmOfrnQXhr4/UWLkVggINjSwca+1DZjvfRYp7MRsjonuE9nqiMtzJf2K
 rnNxKrGf5GFPdkjOYALjU8+MtgqKbLbFt/24kLw1Fi8ZUF9TpM/Z+OyrE8rUEPdxeV
 jxzsZQya/avoeqp1YyaN7YkMmnGgLLjNNbkwNtT91PjKxdDVnZXSUNPg8B+3/AG7d7
 ThCDOBgfaA547v9S0WKmmkUOz0emZEWEH2WmiGBM6jsDfXfl9PYDmn/FH4cQ7a2iN/
 MkwwumI1ICaLT8e5rX9aS8n4QDcdavWmCy+YC7lLOHLeqDpJ7ODnbM6Loekb0EiNHF
 cO8CZeDkR70Yw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_025340_206817_8B3D5D69 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 25/01/2019 10:22, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Some of the fields in struct tegra_pmc had not been documented when they
> were added. Add the missing kerneldoc.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index cd865be3b195..550653302ff2 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -273,6 +273,9 @@ static const char * const tegra30_reset_sources[] = {
>   * struct tegra_pmc - NVIDIA Tegra PMC
>   * @dev: pointer to PMC device structure
>   * @base: pointer to I/O remapped register region
> + * @wake: pointer to I/O remapped region for WAKE registers
> + * @aotag: pointer to I/O remapped region for AOTAG registers
> + * @scratch: pointer to I/O remapped region for scratch registers
>   * @clk: pointer to pclk clock
>   * @soc: pointer to SoC data structure
>   * @debugfs: pointer to debugfs entry
> @@ -291,6 +294,9 @@ static const char * const tegra30_reset_sources[] = {
>   * @lp0_vec_size: size of the LP0 warm boot code
>   * @powergates_available: Bitmap of available power gates
>   * @powergates_lock: mutex for power gate register access
> + * @pctl_dev: pin controller exposed by the PMC
> + * @domain: IRQ domain provided by the PMC
> + * @irq: chip implementation for the IRQ domain
>   */
>  struct tegra_pmc {
>  	struct device *dev;
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
