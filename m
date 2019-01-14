Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343612086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DqYl9cyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343612086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E3dc9xxsR3BO1cq+OTOKme9an83uF4puZTwVRm6fPkc=; b=DqYl9cyZu+/qwGuUzMn4GEXeO
	XtZ8tpE0B1S+3dl9eklEkfxsv4htkjcJtq/l/7nN2Iia1nYaLCdQo8rXWBLz07vCHAMORNHv/tuVT
	jQxHn1086AVNpRY4kjNxtDfvc/ffgt1kSENkADvgloTH2INhTou3zRKwZK6doR45hyvPqiYn78HTk
	n8yM1C7Is/fUV96NWF33OSkqx6H3RLkCdLZybcIFoA4jVxr7cIr20UQRRcLmdt1ujp1l027NCxn88
	PcPrvLjfOBmq7da8OkWwRmKXyIyYsXcaXEDR8BHfjFn6iIAB1lkU9GbWT3/ZSb/dMmmJSE9O8YjHt
	zmQjhy4SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz57-0007uW-MG; Mon, 14 Jan 2019 10:02:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz4e-0007YQ-N9
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:02:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64C6CA78;
 Mon, 14 Jan 2019 02:02:26 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EACA23F5AF;
 Mon, 14 Jan 2019 02:02:22 -0800 (PST)
Subject: Re: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to
 select vulnerabilities
To: jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-2-jeremy.linton@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
Date: Mon, 14 Jan 2019 10:02:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109235544.2992426-2-jeremy.linton@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_020229_265205_32FA2D3B 
X-CRM114-Status: GOOD (  24.91  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, jkosina@suse.cz,
 ak@linux.intel.com, jpoimboe@redhat.com, julien.thierry@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, Steven.Price@arm.com,
 konrad.wilk@oracle.com, mingo@kernel.org, gregkh@linuxfoundation.org,
 ykaukab@suse.de, longman@redhat.com, tglx@linutronix.de, dave.martin@arm.com,
 shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 09/01/2019 23:55, Jeremy Linton wrote:
> As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
> a number of cases where its useful for a system to avoid exporting a
> sysfs entry for a given vulnerability. This set adds an architecture
> specific callback which returns the bitmap of vulnerabilities the
> architecture would like to advertise.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
>   drivers/base/cpu.c  | 19 +++++++++++++++++++
>   include/linux/cpu.h |  7 +++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..35f6dfb24cd6 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
>   	NULL
>   };
>   
> +uint __weak arch_supported_vuln_attr_fields(void)
> +{
> +	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
> +}
> +
>   static const struct attribute_group cpu_root_vulnerabilities_group = {
>   	.name  = "vulnerabilities",
>   	.attrs = cpu_root_vulnerabilities_attrs,
> @@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
>   
>   static void __init cpu_register_vulnerabilities(void)
>   {
> +	int fld;
> +	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
> +	struct attribute **hd = cpu_root_vulnerabilities_attrs;
> +	uint enabled_fields = arch_supported_vuln_attr_fields();
> +
> +	/* only enable entries requested by the arch code */
> +	for (fld = 0; fld < max_fields; fld++) {
> +		if (enabled_fields & 1 << fld) {
> +			*hd = cpu_root_vulnerabilities_attrs[fld];
> +			hd++;
> +		}
> +	}
> +	*hd = NULL;
> +

nit: Could we use "is_visible" callback in the attribute group to check this
dynamically ?

>   	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
>   			       &cpu_root_vulnerabilities_group))
>   		pr_err("Unable to register CPU vulnerabilities\n");
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 218df7f4d3e1..5e45814bcc24 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -189,4 +189,11 @@ static inline void cpu_smt_check_topology_early(void) { }
>   static inline void cpu_smt_check_topology(void) { }
>   #endif
>   
> +/* generic cpu vulnerability attributes */
> +#define VULN_MELTDOWN  0x01
> +#define VULN_SPECTREV1 0x02
> +#define VULN_SPECTREV2 0x04
> +#define VULN_SSB       0x08
> +#define VULN_L1TF      0x10

nit: May use BIT() ?

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
