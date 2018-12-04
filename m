Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874EA2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+x5RGTY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l16MTh2G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LW93wGyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874EA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ibBToLckbKoQryHoHWUt8TzsrUZUXNKracsFMWTW2XQ=; b=f+x5RGTYVAHN1Vngc81QCdOvd
	qLABEtle1W3r+UK6A/g3aim3FdMZ75tehu50uFLo6oRxAwgJYiIyc+h/85R1x3YqwZZFOuWvMVrcq
	5XALSZvHtNNjNcECEXYhPvGHwKcr7aI5uYkuqMfMQ0HN56Neb709pt6GsfvtZXl2Vwdz6KXbWbV28
	K7fC4wgL9kThXaVjxG+0wG9OoMZ11lTufBV+u1aXBhYeg0KV4LGhHwbxg9xl3SRhPc7kpnPd8L3hD
	hNidOn1KKaHkPZOY/fauqPsynVaM9QNzADo9LR+Ve5Qi4fTFz4uZhYAFd3D+eQo7pv817FY8LQEZ3
	dUqnMVp6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEOl-0000p6-TL; Tue, 04 Dec 2018 17:22:15 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEOh-0000dD-Oi
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:22:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 41D93606FA; Tue,  4 Dec 2018 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543944121;
 bh=F1rjfDIpFEDPCNGorV8dbhHAgWZi/5bKnC5uY4p6xCE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=l16MTh2GEF/4NxFrFn9pvi0VCkMNjVXykicb0AdGr6MkMSxXqZEo1oj9JjygRM10S
 17isvQz8CWL2c/dLDVCElp2geuk2l3Qy0i3Ulj/eKZ5xyYa6bYsywaXOuXHfEyTIc6
 0FaalZ5Qcm1DHs/Eoh5n1HG9kWaqi0tN2wu3iPV4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D9787602F4;
 Tue,  4 Dec 2018 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543944120;
 bh=F1rjfDIpFEDPCNGorV8dbhHAgWZi/5bKnC5uY4p6xCE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LW93wGyiCD2BzRxETWyK6QVIMO57IhdX32zzXi6cXzHgmP3Q7NkHjjgbb5iBjB3kx
 XNGA5o/wlnKMkBf90/VLHTlxrknMCslGmKZ0MHXDcwAhuSrM061OgzkSjUkoDDNPpc
 eJnWx2AFYOMrpgcpvDf+KjIHa/tbGXnF5cx+CflE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9787602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross <andy.gross@linaro.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
Date: Tue, 4 Dec 2018 10:21:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092211_893685_FABF8EC1 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/2018 10:11 AM, Marc Gonzalez wrote:
> On 04/12/2018 18:05, Jeffrey Hugo wrote:
> 
>> mount -t debugfs none /sys/kernel/debug
> 
> Doh!
> 
> # cat /sys/kernel/debug/clk/clk_summary
>                                   enable  prepare  protect                                duty
>     clock                          count    count    count        rate   accuracy phase  cycle
> ---------------------------------------------------------------------------------------------
>   gcc_usb_phy_cfg_ahb2phy_clk          0        0        0           0          0     0  50000
>   gcc_usb3_phy_pipe_clk                0        0        0           0          0     0  50000
>   gcc_usb30_sleep_clk                  0        0        0           0          0     0  50000
>   gcc_ufs_unipro_core_clk              0        0        0           0          0     0  50000

Yeah, this clock has no parent, and is one of the ones that is a delta 
from the downsteam per your logs.

>   gcc_ufs_tx_symbol_0_clk              0        0        0           0          0     0  50000
>   gcc_ufs_rx_symbol_1_clk              0        0        0           0          0     0  50000
>   gcc_ufs_rx_symbol_0_clk              0        0        0           0          0     0  50000
>   gcc_ufs_phy_aux_clk                  0        0        0           0          0     0  50000
>   gcc_ufs_ice_core_clk                 0        0        0           0          0     0  50000
>   gcc_ufs_ahb_clk                      0        0        0           0          0     0  50000
>   gcc_tsif_inactivity_timers_clk       0        0        0           0          0     0  50000
>   gcc_tsif_ahb_clk                     0        0        0           0          0     0  50000
>   gcc_sdcc4_ahb_clk                    0        0        0           0          0     0  50000
>   gcc_sdcc2_ahb_clk                    0        0        0           0          0     0  50000
>   gcc_prng_ahb_clk                     0        0        0           0          0     0  50000
>   gcc_pdm_xo4_clk                      0        0        0           0          0     0  50000
>   gcc_pdm_ahb_clk                      0        0        0           0          0     0  50000
>   gcc_pcie_0_slv_axi_clk               0        0        0           0          0     0  50000
>   gcc_pcie_0_pipe_clk                  0        0        0           0          0     0  50000
>   gcc_pcie_0_mstr_axi_clk              0        0        0           0          0     0  50000
>   gcc_pcie_0_cfg_ahb_clk               0        0        0           0          0     0  50000
>   gcc_mss_at_clk                       0        0        0           0          0     0  50000
>   gcc_mmss_sys_noc_axi_clk             0        0        0           0          0     0  50000
>   gcc_mmss_qm_core_clk                 0        0        0           0          0     0  50000
>   gcc_mmss_qm_ahb_clk                  0        0        0           0          0     0  50000
>   gcc_mmss_noc_cfg_ahb_clk             0        0        0           0          0     0  50000
>   gcc_lpass_trig_clk                   0        0        0           0          0     0  50000
>   gcc_lpass_at_clk                     1        1        0           0          0     0  50000
>   gcc_hmss_trig_clk                    0        0        0           0          0     0  50000
>   gcc_hmss_dvm_bus_clk                 1        1        0           0          0     0  50000
>   gcc_hmss_at_clk                      0        0        0           0          0     0  50000
>   gcc_gpu_snoc_dvm_gfx_clk             0        0        0           0          0     0  50000
>   gcc_gpu_cfg_ahb_clk                  0        0        0           0          0     0  50000
>   gcc_gpu_bimc_gfx_src_clk             0        0        0           0          0     0  50000
>   gcc_gpu_bimc_gfx_clk                 0        0        0           0          0     0  50000
>   gcc_blsp2_sleep_clk                  0        0        0           0          0     0  50000
>   gcc_blsp2_ahb_clk                    3        3        0           0          0     0  50000
>   gcc_blsp1_sleep_clk                  0        0        0           0          0     0  50000
>   gcc_blsp1_ahb_clk                    0        0        0           0          0     0  50000
>   gcc_bimc_mss_q6_axi_clk              0        0        0           0          0     0  50000
>   gcc_bimc_hmss_axi_clk                0        0        0           0          0     0  50000
>   gcc_apss_qdss_tsctr_div8_clk         0        0        0           0          0     0  50000
>   gcc_apss_qdss_tsctr_div2_clk         0        0        0           0          0     0  50000
>   gcc_aggre1_noc_xo_clk                0        0        0           0          0     0  50000
>   sleep_clk                            0        0        0       32764          0     0  50000
>   xo                                   1        1        0    19200000          0     0  50000
>      gcc_rx1_usb2_clkref_clk           0        0        0    19200000          0     0  50000
>      gcc_pcie_clkref_clk               0        0        0    19200000          0     0  50000
>      gcc_ufs_clkref_clk                0        0        0    19200000          0     0  50000
>      gcc_hdmi_clkref_clk               0        0        0    19200000          0     0  50000
>      gcc_usb3_clkref_clk               0        0        0    19200000          0     0  50000
>      usb3_phy_aux_clk_src              0        0        0     1200000          0     0  50000
>         gcc_usb3_phy_aux_clk           0        0        0     1200000          0     0  50000
>      usb30_mock_utmi_clk_src           0        0        0    19200000          0     0  50000
>         gcc_usb30_mock_utmi_clk        0        0        0    19200000          0     0  50000
>      tsif_ref_clk_src                  0        0        0    19200000          0     0  50000
>         gcc_tsif_ref_clk               0        0        0    19200000          0     0  50000
>      sdcc4_apps_clk_src                0        0        0    19200000          0     0  50000
>         gcc_sdcc4_apps_clk             0        0        0    19200000          0     0  50000
>      sdcc2_apps_clk_src                0        0        0    19200000          0     0  50000
>         gcc_sdcc2_apps_clk             0        0        0    19200000          0     0  50000
>      pdm2_clk_src                      0        0        0    19200000          0     0  50000
>         gcc_pdm2_clk                   0        0        0    19200000          0     0  50000
>      pcie_aux_clk_src                  0        0        0    19200000          0     0  50000
>         gcc_pcie_0_aux_clk             0        0        0    19200000          0     0  50000
>         gcc_pcie_phy_aux_clk           0        0        0    19200000          0     0  50000
>      hmss_rbcpr_clk_src                0        0        0    19200000          0     0  50000
>         gcc_hmss_rbcpr_clk             0        0        0    19200000          0     0  50000
>      hmss_ahb_clk_src                  0        0        0    19200000          0     0  50000
>         gcc_hmss_ahb_clk               0        0        0    19200000          0     0  50000
>      gpll4                             0        0        0   384000000          0     0  50000
>         gpll4_out_test                 0        0        0   384000000          0     0  50000
>         gpll4_out_odd                  0        0        0   384000000          0     0  50000
>         gpll4_out_main                 0        0        0   384000000          0     0  50000
>         gpll4_out_even                 0        0        0   384000000          0     0  50000
>      gpll3                             0        0        0   921600000          0     0  50000
>         gpll3_out_test                 0        0        0   921600000          0     0  50000
>         gpll3_out_odd                  0        0        0   921600000          0     0  50000
>         gpll3_out_main                 0        0        0   921600000          0     0  50000
>         gpll3_out_even                 0        0        0   921600000          0     0  50000
>      gpll2                             0        0        0  1286400000          0     0  50000
>         gpll2_out_test                 0        0        0  1286400000          0     0  50000
>         gpll2_out_odd                  0        0        0  1286400000          0     0  50000
>         gpll2_out_main                 0        0        0  1286400000          0     0  50000
>         gpll2_out_even                 0        0        0  1286400000          0     0  50000
>      gpll1                             0        0        0  1056000000          0     0  50000
>         gpll1_out_test                 0        0        0  1056000000          0     0  50000
>         gpll1_out_odd                  0        0        0  1056000000          0     0  50000
>         gpll1_out_main                 0        0        0  1056000000          0     0  50000
>         gpll1_out_even                 0        0        0  1056000000          0     0  50000
>      gpll0                             0        0        0   595200000          0     0  50000
>         gpll0_out_test                 0        0        0   595200000          0     0  50000
>         gpll0_out_odd                  0        0        0   595200000          0     0  50000
>         gpll0_out_main                 0        0        0   595200000          0     0  50000
>            usb30_master_clk_src        0        0        0   119040000          0     0  50000
>               gcc_aggre1_usb3_axi_clk       0        0        0   119040000          0     0  50000
>               gcc_cfg_noc_usb3_axi_clk       0        0        0   119040000          0     0  50000
>               gcc_usb30_master_clk       0        0        0   119040000          0     0  50000
>            ufs_axi_clk_src             0        0        0   198400000          0     0  50000
>               gcc_aggre1_ufs_axi_clk       0        0        0   198400000          0     0  50000
>               gcc_ufs_axi_clk          0        0        0   198400000          0     0  50000
>         gpll0_out_even                 0        0        0   595200000          0     0  50000
>      gp3_clk_src                       0        0        0    19200000          0     0  50000
>         gcc_gp3_clk                    0        0        0    19200000          0     0  50000
>      gp2_clk_src                       0        0        0    19200000          0     0  50000
>         gcc_gp2_clk                    0        0        0    19200000          0     0  50000
>      gp1_clk_src                       0        0        0    19200000          0     0  50000
>         gcc_gp1_clk                    0        0        0    19200000          0     0  50000
>      blsp2_uart3_apps_clk_src          0        0        0    19200000          0     0  50000
>         gcc_blsp2_uart3_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_uart2_apps_clk_src          1        1        0     1843200          0     0  50000
>         gcc_blsp2_uart2_apps_clk       3        3        0     1843200          0     0  50000
>      blsp2_uart1_apps_clk_src          0        0        0    19200000          0     0  50000
>         gcc_blsp2_uart1_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup6_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup6_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup6_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup6_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup5_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup5_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup5_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup5_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup4_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup4_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup4_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup4_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup3_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup3_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup3_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup3_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup2_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup2_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup2_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup2_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup1_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup1_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp2_qup1_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp2_qup1_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_uart3_apps_clk_src          0        0        0    19200000          0     0  50000
>         gcc_blsp1_uart3_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_uart2_apps_clk_src          0        0        0    19200000          0     0  50000
>         gcc_blsp1_uart2_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_uart1_apps_clk_src          0        0        0    19200000          0     0  50000
>         gcc_blsp1_uart1_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup6_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup6_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup6_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup6_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup5_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup5_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup5_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup5_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup4_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup4_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup4_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup4_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup3_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup3_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup3_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup3_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup2_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup2_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup2_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup2_i2c_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup1_spi_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup1_spi_apps_clk       0        0        0    19200000          0     0  50000
>      blsp1_qup1_i2c_apps_clk_src       0        0        0    19200000          0     0  50000
>         gcc_blsp1_qup1_i2c_apps_clk       0        0        0    19200000          0     0  50000
>   ln_bb_a_clk1                         0        0        0           0          0     0  50000
>   ln_bb_clk1                           0        0        0           0          0     0  50000
> 
> 
> There is no clock summary in 4.4 to compare the downstream kernel?

Not that I've seen.  You can check each clock individually, but I 
realize that is tedious.


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
