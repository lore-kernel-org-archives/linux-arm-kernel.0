Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4878C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:45:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AF62082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhbOsyco";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OD9Dp5M8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OD9Dp5M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AF62082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+FZHQTUXssLTRa6XJ7WWutVMv301be9MOhsi2OOIQMQ=; b=nhbOsycoPC9v2ixigKOjU83K0
	28EPh3/qtd3/ULeh1wPBNJrF6lKgF36348AIhC7JzTr1OZU/4mZDJwGAtRrF6OQlo4MlrWg4iv27S
	UHr0gDiqlQ/CS0FZ3/JFEEn/0MYWG1N3GjpoSZxEFZVPMqsRIq3+kQjLSfYPZC6wkkBcIgcy57zBc
	gp9CUqrrbHFS6zwDup3+s+o49iopRNoI5LrC8EhBJm9+S1JzdbM9rUKtC2yvu5qN9EgiKXeNakYhI
	3c40gIZU+hL8QDbfbGWdCvJq/X1ret0XlP4pOdggEypSB+IcbxCCrQ1YdsS496SSzOdZzW1vQOET/
	/Pp+TvsZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCtE-0003ZY-UZ; Tue, 04 Dec 2018 15:45:36 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCtB-0003Oq-LF
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:45:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id BCE276019F; Tue,  4 Dec 2018 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543938322;
 bh=cPYoTrT5bCTsccD6/ihNsQl8B8WlcAcIFJtmBQtK5Ao=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OD9Dp5M8PH2ljLhGS+LB3pgaIPQarV7J56I9/dbhNVDJo3dtg0mnhmagxbWiUB2ca
 VKLo026EEpeD+bHuR+LWHOsXGjLGtSH+KzYb36VbNg9cHd8fu7ONkOBE1nde+7RarZ
 KFroWg+q8B0tJl6biwYknbkwB1aHrx0WOrUcZTV8=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 660FC60224;
 Tue,  4 Dec 2018 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543938322;
 bh=cPYoTrT5bCTsccD6/ihNsQl8B8WlcAcIFJtmBQtK5Ao=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OD9Dp5M8PH2ljLhGS+LB3pgaIPQarV7J56I9/dbhNVDJo3dtg0mnhmagxbWiUB2ca
 VKLo026EEpeD+bHuR+LWHOsXGjLGtSH+KzYb36VbNg9cHd8fu7ONkOBE1nde+7RarZ
 KFroWg+q8B0tJl6biwYknbkwB1aHrx0WOrUcZTV8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 660FC60224
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <41d6e9c3-97d5-5fe8-8e5d-b61e92a6ddfb@codeaurora.org>
Date: Tue, 4 Dec 2018 08:45:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_074533_737602_CBDA7BBE 
X-CRM114-Status: GOOD (  17.84  )
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

On 12/4/2018 8:23 AM, Marc Gonzalez wrote:
> On 03/12/2018 17:53, Marc Gonzalez wrote:
> 
>> [    0.970565] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
>> [    0.970676] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
>> [    0.971349] qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy
>> [    2.293324] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
>> [    2.355902] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
>> [    2.359197] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
>> [    2.365857] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5
>> [    2.400665] scsi host0: ufshcd
>> [    2.435181] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
>> [    3.968211] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
>> [    5.472133] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
>> [    6.976114] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
>> [    6.976387] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
>> [    6.984999] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11
> 
> The PHY and MAC init *seem* successful, but obviously something goes wrong,
> since the query times out after 1500 ms, waiting for the completion in
> ufshcd_wait_for_dev_cmd()
> 
> #define QUERY_REQ_TIMEOUT 1500 /* 1.5 seconds */
> 
> err is set to -ETIMEDOUT (i.e. -110) then the command is cleared for an
> ulterior retry, and err is set to -EAGAIN (i.e. -11)
> 
> The question is: why does the command time out?
> 
> Enabling DEBUG...
> 
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
> 
> The zero clock rates look suspicious, don't they?
> 
> [    2.255243] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
> [    2.256240] ufshcd_wait_for_dev_cmd: time_left=8
> [    2.266734] ufshcd_wait_for_dev_cmd = 0
> 
> This command succeeds.
> 
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
> 
> It's strange that one command succeeds, and the 3 next fail...
> Maybe they don't speak to the same HW block...

Throwing something at a wall and seeing if it sticks....

The downstream MTP dtsi has -

&ufsphy1 {
         vdda-phy-supply = <&pm8998_l1>;
         vdda-pll-supply = <&pm8998_l2>;
         vddp-ref-clk-supply = <&pm8998_l26>;
         vdda-phy-max-microamp = <51400>;
         vdda-pll-max-microamp = <14600>;
         vddp-ref-clk-max-microamp = <100>;
         vddp-ref-clk-always-on;
         status = "ok";
};

&ufs1 {
         vdd-hba-supply = <&gdsc_ufs>;
         vdd-hba-fixed-regulator;
         vcc-supply = <&pm8998_l20>;
         vccq-supply = <&pm8998_l26>;
         vccq2-supply = <&pm8998_s4>;
         vcc-max-microamp = <750000>;
         vccq-max-microamp = <560000>;
         vccq2-max-microamp = <750000>;
         status = "ok";
};


The *-max-microamp fields are basically load values that the downstream 
driver sets on the regulators to ensure they are in a performance mode 
before the driver attempts normal operation.

On the corresponding regulators in the mtp dtsi, you might try adding
regulator-allow-set-load;
regulator-system-load = <X>;

It might be that the regulators act as pull ups on some of the 
signal/data lines, and by default they are not being driven hard enough 
to do that job properly, resulting in the timeouts you see.

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
