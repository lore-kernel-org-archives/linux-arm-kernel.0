Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B52C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:18:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5390420659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fG2q0ja+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5390420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lz5Ujl77gmuV5pdWgibtGUJ4BZPR10f4KgkXqj0pfh4=; b=fG2q0ja+pvCSYC
	+O2/OE1OJ/bHOSQKXwpAfbMggif9KqL0Kp0HCNnx9CwqywnSTSf+SThgeA6rGIlCIHkgbOkQQGYbi
	ja7Za95KqlRjUvHQYuN3tOvlWuuxnsp763/ctIKuv3IcTmR1RM0ErRKKTdXXW9EhbCdfkTp5HAfGW
	YIQADsy7S/t67jhIL9uB/5OYuLcy7BjWebOeXhYr3hwEMyKeeirBRP5SobPsLc7Zwt6sD07hJVKpC
	HuFdjy5FKK6WIJkNfMKN+Nys0QWdwBSRk2Gvz6beGraO76/sxHfndrMNxgBXv/6v0B36kuIMGMPIW
	HrvMXAyk0yu+k/EQij4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDOa-0002SE-Fp; Tue, 04 Dec 2018 16:18:00 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDOV-0002QN-8X
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:17:58 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id D7B5C13F8E7;
 Tue,  4 Dec 2018 17:17:27 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Jeffrey Hugo <jhugo@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
Message-ID: <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
Date: Tue, 4 Dec 2018 17:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_081755_606075_52201E87 
X-CRM114-Status: UNSURE (   8.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/12/2018 16:23, Marc Gonzalez wrote:

> [    2.046246] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
> [    2.046675] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk, rate: 198400000
> [    2.056101] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: bus_aggr_clk, rate: 198400000
> [    2.064333] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: iface_clk, rate: 0
> [    2.072820] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 0
> [    2.080304] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
> [    2.088547] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 0
> [    2.096269] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: tx_lane0_sync_clk, rate: 0
> [    2.103743] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane0_sync_clk, rate: 0
> [    2.111812] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane1_sync_clk, rate: 0
> [    2.120178] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk enabled
> [    2.128292] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk enabled
> [    2.135848] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk enabled
> [    2.143833] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro enabled
> [    2.151831] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice enabled
> [    2.160312] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk enabled
> [    2.167789] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
> [    2.175444] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
> [    2.184043] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
> [    2.201054] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
> [    2.204116] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
> [    2.210800] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5
> [    2.255243] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
> [    2.256240] ufshcd_wait_for_dev_cmd: time_left=8
> [    2.266734] ufshcd_wait_for_dev_cmd = 0
> [    3.780315] ufshcd_wait_for_dev_cmd: time_left=0
> [    3.780484] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    3.784258] ufshcd_wait_for_dev_cmd = -11
> [    3.792949] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    3.796936] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 0
> [    3.872239] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
> [    3.935871] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
> [    4.006340] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000001
> [    5.316263] ufshcd_wait_for_dev_cmd: time_left=0
> [    5.316406] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    5.320177] ufshcd_wait_for_dev_cmd = -11
> [    5.328838] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    5.332872] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 1
> [    6.852272] ufshcd_wait_for_dev_cmd: time_left=0
> [    6.852415] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    6.856185] ufshcd_wait_for_dev_cmd = -11
> [    6.864846] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    6.868872] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 2
> [    6.878415] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
> [    6.887258] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11
> [    6.900929] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk disabled
> [    6.909171] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk disabled
> [    6.917054] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk disabled
> [    6.925112] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro disabled
> [    6.932849] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice disabled
> [    6.941305] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk disabled
> [    6.949346] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
> [    6.956721] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
> [    6.965405] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled

I booted a downstream kernel with UFS debug enabled (log provided below)

The one difference that jumps out at me is:

DOWNSTREAM
[   10.902119] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 150000000
[   10.902161] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 300000000
[   10.902198] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 1000

UPSTREAM
[    2.072820] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 0
[    2.080304] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
[    2.088547] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 0


Jeffrey, I will check the regulators per your suggestion.
I'm all ears if you have suggestions for the clocks as well.

Regards.


[   10.902030] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk, rate: 200000000
[   10.902057] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: bus_aggr_clk, rate: 200000000
[   10.902081] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: iface_clk, rate: 0
[   10.902119] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 150000000
[   10.902161] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 300000000
[   10.902198] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 1000
[   10.902237] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: tx_lane0_sync_clk, rate: 0
[   10.902276] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane0_sync_clk, rate: 0
[   10.902317] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane1_sync_clk, rate: 0
[   10.902346] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   10.902353] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   10.902359] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   10.902367] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   10.902376] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   10.902382] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   10.902386] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   10.902391] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   10.902395] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   10.905993] ufshcd-qcom 1da4000.ufshc: ufs_qcom_update_sec_cfg: failed, ret -22 scm_ret 0
[   10.906001] ufshcd-qcom 1da4000.ufshc: ufs_qcom_update_sec_cfg: ip: restore_sec_cfg 1, op: restore_sec_cfg 0, ret -22 scm_ret 0
[   10.907535] ufshcd-qcom 1da4000.ufshc: ufs_qcom_parse_reg_info: Unable to find qcom,vddp-ref-clk-supply regulator, assuming enabled
[   10.911697] scsi host0: ufshcd
[   10.918627] qcom_ice 1db0000.ufsice: QC ICE 3.0.65 device found @0xffffff800cde0000
[   10.949115] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
[   10.949860] ufshcd_wait_for_dev_cmd: time_left=3
[   10.949870] ufshcd_wait_for_dev_cmd = 0
[   11.127287] ufshcd_wait_for_dev_cmd: time_left=132
[   11.127304] ufshcd_wait_for_dev_cmd = 0
[   11.127988] ufshcd_wait_for_dev_cmd: time_left=150
[   11.128000] ufshcd_wait_for_dev_cmd = 0
[   11.128937] ufshcd_wait_for_dev_cmd: time_left=150
[   11.128954] ufshcd_wait_for_dev_cmd = 0
[   11.130130] ufshcd_wait_for_dev_cmd: time_left=149
[   11.130145] ufshcd_wait_for_dev_cmd = 0
[   11.131850] ufshcd_wait_for_dev_cmd: time_left=150
[   11.131863] ufshcd_wait_for_dev_cmd = 0
[   11.132574] ufshcd_wait_for_dev_cmd: time_left=150
[   11.132586] ufshcd_wait_for_dev_cmd = 0
[   11.139512] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
[   11.139611] ufshcd_wait_for_dev_cmd: time_left=150
[   11.139615] ufshcd_wait_for_dev_cmd = 0
[   11.139663] ufshcd_wait_for_dev_cmd: time_left=150
[   11.139670] ufshcd_wait_for_dev_cmd = 0
[   11.139680] ufshcd-qcom 1da4000.ufshc: ufshcd_init_icc_levels: setting icc_level 0xf
[   11.139721] ufshcd_wait_for_dev_cmd: time_left=150
[   11.139726] ufshcd_wait_for_dev_cmd = 0
[   11.140594] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 1
[   11.145001] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 1
[   11.149027] ufshcd_wait_for_dev_cmd: time_left=150
[   11.149032] ufshcd_wait_for_dev_cmd = 0
[   11.149044] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.154304] ufshcd_wait_for_dev_cmd: time_left=150
[   11.154310] ufshcd_wait_for_dev_cmd = 0
[   11.154324] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.157775] ufshcd_wait_for_dev_cmd: time_left=150
[   11.157780] ufshcd_wait_for_dev_cmd = 0
[   11.157793] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.161038] ufshcd_wait_for_dev_cmd: time_left=150
[   11.161044] ufshcd_wait_for_dev_cmd = 0
[   11.161058] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.164347] ufshcd_wait_for_dev_cmd: time_left=150
[   11.164353] ufshcd_wait_for_dev_cmd = 0
[   11.164367] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.167598] ufshcd_wait_for_dev_cmd: time_left=150
[   11.167604] ufshcd_wait_for_dev_cmd = 0
[   11.167618] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.170837] ufshcd_wait_for_dev_cmd: time_left=150
[   11.170842] ufshcd_wait_for_dev_cmd = 0
[   11.170855] ufshcd-qcom 1da4000.ufshc: ufshcd_set_queue_depth: activate tcq with queue depth 32
[   11.198008] ufshcd-qcom 1da4000.ufshc: __ufshcd_uic_hibern8_enter: Hibern8 Enter at 11197983 us
[   11.198098] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk, rate: 50000000
[   11.198105] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: bus_aggr_clk, rate: 50000000
[   11.198111] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: iface_clk, rate: 0
[   11.198150] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_unipro, rate: 37500000
[   11.198184] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_ice, rate: 75000000
[   11.198193] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: ref_clk, rate: 1000
[   11.198199] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: tx_lane0_sync_clk, rate: 0
[   11.198205] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane0_sync_clk, rate: 0
[   11.198210] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane1_sync_clk, rate: 0
[   11.198879] ufshcd-qcom 1da4000.ufshc: ufshcd_uic_hibern8_exit: Hibern8 Exit at 11198863 us
[   11.227539] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   11.227546] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   11.227554] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   11.227563] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   11.227569] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   11.227575] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   11.227578] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   11.227582] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   11.227586] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   11.242041] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   11.242053] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   11.242065] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   11.242087] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   11.242109] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   11.242122] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   11.242132] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   11.242143] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   11.242155] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   11.256394] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   11.256402] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   11.256408] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   11.256420] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   11.256432] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   11.256438] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   11.256447] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   11.256452] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   11.256459] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   14.194451] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   14.194489] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   14.200933] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   14.208734] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   14.216210] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   14.224450] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   14.232171] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   14.239633] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   14.247713] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   14.269093] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   14.271502] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   14.287195] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   14.291435] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   14.298666] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   14.307033] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   14.314820] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   14.322484] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   14.330536] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   14.725012] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   14.725066] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   14.731732] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   14.739323] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   14.747247] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   14.755486] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   14.770343] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   14.793188] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   14.801080] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   14.815579] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.815644] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.816320] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.816419] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.816466] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.816596] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.840620] ufshcd-qcom 1da4000.ufshc: __ufshcd_uic_hibern8_enter: Hibern8 Enter at 14840602 us
[   14.840834] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk, rate: 200000000
[   14.840837] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: bus_aggr_clk, rate: 200000000
[   14.840840] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: iface_clk, rate: 0
[   14.840851] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_unipro, rate: 150000000
[   14.840861] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_ice, rate: 300000000
[   14.840864] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: ref_clk, rate: 1000
[   14.840866] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: tx_lane0_sync_clk, rate: 0
[   14.840868] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane0_sync_clk, rate: 0
[   14.840870] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane1_sync_clk, rate: 0
[   14.841385] ufshcd-qcom 1da4000.ufshc: ufshcd_uic_hibern8_exit: Hibern8 Exit at 14841370 us
[   14.867089] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.867950] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.869532] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.869857] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.875615] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.880551] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.890984] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.892353] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.894644] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.894988] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.895910] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.911272] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.919013] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   14.970413] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   14.970426] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   14.970434] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   14.970446] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   14.970610] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   14.970615] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   14.970622] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   14.970628] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   14.970635] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   15.108525] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   15.109274] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   15.116973] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   15.125152] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   15.132215] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   15.140499] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   15.148158] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   15.155642] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   15.163708] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   15.215754] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.220335] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.220910] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.233205] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.241491] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.263730] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.277648] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.291173] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.292187] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.297278] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.297737] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.300772] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.303989] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.309161] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.320267] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.324303] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.324971] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.334552] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.345729] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.355783] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.364341] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.370772] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.387535] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.394784] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.395099] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.395367] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.412905] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.414516] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.416494] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.422052] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.425196] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.434301] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.434421] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.442507] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.446766] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.450458] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.455773] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.468107] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.471003] ufshcd-qcom 1da4000.ufshc: ufshcd_ioctl: User buffer is NULL!
[   15.519085] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   15.519131] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   15.525798] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   15.533741] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   15.541088] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   15.557222] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   15.563667] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   15.571143] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   15.579338] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   17.939055] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   17.939105] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   17.946146] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   17.953435] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   17.960861] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   17.969103] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   17.976821] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   17.984314] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   17.992406] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   18.075579] ufshcd-qcom 1da4000.ufshc: __ufshcd_uic_hibern8_enter: Hibern8 Enter at 18075560 us
[   18.075637] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk, rate: 50000000
[   18.083140] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: bus_aggr_clk, rate: 50000000
[   18.091486] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: iface_clk, rate: 0
[   18.099936] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_unipro, rate: 37500000
[   18.107463] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: core_clk_ice, rate: 75000000
[   18.116439] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: ref_clk, rate: 1000
[   18.124859] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: tx_lane0_sync_clk, rate: 0
[   18.132665] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane0_sync_clk, rate: 0
[   18.140928] ufshcd-qcom 1da4000.ufshc: ufshcd_set_clk_freq: clk: rx_lane1_sync_clk, rate: 0
[   18.152292] ufshcd-qcom 1da4000.ufshc: ufshcd_uic_hibern8_exit: Hibern8 Exit at 18152274 us
[   18.168689] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   18.168743] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   18.175526] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   18.184057] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   18.190639] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   18.198949] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   18.206797] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   18.214324] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   18.222492] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[   18.868493] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk enabled
[   18.868543] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[   18.875510] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk enabled
[   18.883318] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro enabled
[   18.890270] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice enabled
[   18.898541] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk enabled
[   18.906244] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[   18.913690] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[   18.921923] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[   18.931224] ufshcd_wait_for_dev_cmd: time_left=150
[   18.938236] ufshcd_wait_for_dev_cmd = 0
[   18.945163] ufshcd-qcom 1da4000.ufshc: __ufshcd_uic_hibern8_enter: Hibern8 Enter at 18945144 us
[   18.949218] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk disabled
[   18.955483] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[   18.963097] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: iface_clk disabled
[   18.970992] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_unipro disabled
[   18.978531] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: core_clk_ice disabled
[   18.986876] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: ref_clk disabled
[   18.995192] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[   19.002740] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[   19.010895] ufshcd-qcom 1da4000.ufshc: ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
