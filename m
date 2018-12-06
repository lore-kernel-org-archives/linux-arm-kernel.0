Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA96C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:53:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF012081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4NROPk5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bZYu7Kcl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qk6N1dXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF012081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L5fCR+eQNLcFqut8fKVHuqe/BK8fHjs8DRsQD02mAwc=; b=K4NROPk5JSJwBnZ1tst/0SpyM
	nzBdAtiw0rukPIZ9OUXUpCuA0NxSOSWCSMW/dpKsGIs4/NG8ZHiEHkrD8YxkDyQU5X2RWk7xQs1ja
	2V47734dGwEMbPIirRuaiMgP1OVPx2frygYTubK8BGt47o9le1qxUNfvvXdskI54+xv+OyGKrT07S
	powJspnZ5gpkLhTy/UgvonrdfFFJMWHE97AlhoER1RLITt/cKQeUUVK+V/0/4rM5a9O2btxuAkONG
	AH1Y0tsWc1Lc6/lxh8qAGeV3iq6iEuTV0P4Skeyli30ToePAyN5Q7bjvN18lzD1ZDDAf3Md5y+fAc
	6U1NH/WeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1aV-0005OR-B2; Thu, 06 Dec 2018 21:53:39 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1aR-0005NS-LW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:53:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id BBA0460AD8; Thu,  6 Dec 2018 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544133204;
 bh=Q8BIfm9Udyijxho8wELnzvz/rcNmTRyjFuV2hlA5Ty0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bZYu7Kcl5wyA9z/Bkqd1Z32pXP+7hbO8//ZFhOyQx89VtpCRyrMywjOB7Yf4JOVG8
 eRzHXfsEgb7fQPxTvzw5EjVxMqQ2Dyg2jkvx4O/eDoZ7KnIqDMejKBv0wE2f8xWcFv
 S+XgQCNBVhXb0agfXI8AM30fh3s2cNHgxgiwJMdc=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: daidavid1@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5942F6019F;
 Thu,  6 Dec 2018 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544133203;
 bh=Q8BIfm9Udyijxho8wELnzvz/rcNmTRyjFuV2hlA5Ty0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Qk6N1dXhax+JGynONfXAz1NccXegykdM6lPQtGMxnMem+QL/Ka+tA4s1wVhevQmWH
 TrBmhQlI25qYnFlxPJAdW+89VjuK1DXH3K/peAwIvCA5zhCesjS8Br6ExYEuux8Xsj
 n+WHWTWLieJXJ3Mvs/Iwt25g3lm7XW8GZisS5f0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5942F6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v10 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To: Georgi Djakov <georgi.djakov@linaro.org>, Evan Green <evgreen@chromium.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-6-georgi.djakov@linaro.org>
 <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
 <cfcb39ba-860c-5a3f-911f-ab52b5250390@linaro.org>
From: David Dai <daidavid1@codeaurora.org>
Message-ID: <266c7bf9-18c1-8255-eca2-814aab3850c6@codeaurora.org>
Date: Thu, 6 Dec 2018 13:53:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cfcb39ba-860c-5a3f-911f-ab52b5250390@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135335_741572_D8C48F36 
X-CRM114-Status: GOOD (  21.59  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 thierry.reding@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/5/2018 8:00 AM, Georgi Djakov wrote:
> Hi Evan,
>
> On 12/1/18 02:39, Evan Green wrote:
>> On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>> From: David Dai <daidavid1@codeaurora.org>
>>>
>>> Introduce Qualcomm SDM845 specific provider driver using the
>>> interconnect framework.
>>>
>>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>> ---
>>>   .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>>>   drivers/interconnect/Kconfig                  |   5 +
>>>   drivers/interconnect/Makefile                 |   1 +
>>>   drivers/interconnect/qcom/Kconfig             |  13 +
>>>   drivers/interconnect/qcom/Makefile            |   5 +
>>>   drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>>>   .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>>>   7 files changed, 1027 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>>   create mode 100644 drivers/interconnect/qcom/Kconfig
>>>   create mode 100644 drivers/interconnect/qcom/Makefile
>>>   create mode 100644 drivers/interconnect/qcom/sdm845.c
>>>   create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>> new file mode 100644
>>> index 000000000000..d45150e99665
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>> @@ -0,0 +1,24 @@
>>> +Qualcomm SDM845 Network-On-Chip interconnect driver binding
>>> +-----------------------------------------------------------
>>> +
>>> +SDM845 interconnect providers support system bandwidth requirements through
>>> +RPMh hardware accelerators known as Bus Clock Manager(BCM). The provider is able
>>> +to communicate with the BCM through the Resource State Coordinator(RSC)
>>> +associated with each execution environment. Provider nodes must reside within
>>> +an RPMh device node pertaining to their RSC and each provider maps to
>>> +a single RPMh resource.
>>> +
>>> +Required properties :
>>> +- compatible : shall contain only one of the following:
>>> +                       "qcom,sdm845-rsc-hlos"
>> I wonder if maybe hlos isn't necessary. Unless you somehow imagine
>> secure mode would have a device tree entry in here as well? Probably
>> not.
> Ok, will remove it. David, please chime in if you have any concerns with
> this.

No strong preferences in terms of naming, but need to make the 
distinction between this and potential other rsc types if we're to add 
additional provider drivers.

>>> +- #interconnect-cells : should contain 1
>>> +
>>> +Examples:
>>> +
>>> +apps_rsc: rsc {
>>> +               qnoc: qnoc-rsc-hlos {
>>> +                       compatible = "qcom,sdm845-rsc-hlos";
>>> +                       #interconnect-cells = <1>;
>>> +               };
>>> +};
>>> +
>> ...
>>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>>> new file mode 100644
>>> index 000000000000..1678de91ca52
>>> --- /dev/null
>>> +++ b/drivers/interconnect/qcom/sdm845.c
>>> @@ -0,0 +1,836 @@
>> ...
>>> +
>>> +static void tcs_list_gen(struct list_head *bcm_list,
>>> +                        struct tcs_cmd *tcs_list, int *n)
>> We could make the prototype of this function be:
>>
>> static void tcs_list_gen(struct list_head *bcm_list,
>>          struct tcs_cmd tcs_list[SDM845_MAX_VCD], int n[SDM845_MAX_VCD])
>>
>> which would catch errors if somebody later passed in an array that
>> wasn't the right size, since we blindly memset below.
> Yes, sounds good. I will try to optimize it.
>
> Thanks,
> Georgi
>
>>> +{
>>> +       struct qcom_icc_bcm *bcm;
>>> +       bool commit;
>>> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
>>> +
>>> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
>>> +
>>> +       list_for_each_entry(bcm, bcm_list, list) {
>>> +               commit = false;
>>> +               cur_vcd_size++;
>>> +               if ((list_is_last(&bcm->list, bcm_list)) ||
>>> +                   bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
>>> +                       commit = true;
>>> +                       cur_vcd_size = 0;
>>> +               }
>>> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
>>> +                           bcm->addr, commit);
>>> +               idx++;
>>> +               n[batch]++;
>>> +               /*
>>> +                * Batch the BCMs in such a way that we do not split them in
>>> +                * multiple payloads when they are under the same VCD. This is
>>> +                * to ensure that every BCM is committed since we only set the
>>> +                * commit bit on the last BCM request of every VCD.
>>> +                */
>>> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
>>> +                       if (!commit) {
>>> +                               n[batch] -= cur_vcd_size;
>>> +                               n[batch + 1] = cur_vcd_size;
>>> +                       }
>>> +                       batch++;
>>> +               }
>>> +       }
>>> +}
>>> +

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
