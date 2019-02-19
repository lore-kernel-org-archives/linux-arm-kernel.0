Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E866C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:12:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E59420838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KOzd2Vli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E59420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=km452WKk6PHx1fbK8MIi0W02BjB2tLG/Ktt4ALqzdtw=; b=KOzd2VliP275lGtffi0IjKRHQ
	IMMCUuF8w1RnTCENRwZscOtpjflu+CMowT3jwdEDuBL7iTvibinP3WFBnRG/Q6Mfxb9i7DbXEPND1
	SbIbxERz84Xl5glxuCy3h9BYahs45qVYaCsyks2F6GzJ9M8K5Pq4G3MEIUaFWeQDoXFLGA5IxjBCX
	1Hjotk2FCCAmyjRh1dhrbiMmqkVfrrTI41edtqZ83UXcF7MxP1ypDRKUHJ1HL2V1Y1Uc23qpxq0zt
	QnqZgmVgW81mOq+JrcxS93KETs4u/YGmFYyMvwo//6w38ie0fMHKV3+L78frAs7G2lmplEOdrAOFd
	Mg288qUzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzZi-00072F-Gi; Tue, 19 Feb 2019 07:12:18 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzZe-00071p-JU
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:12:16 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 19 Feb 2019 16:12:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 54F256117D;
 Tue, 19 Feb 2019 16:12:13 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Tue, 19 Feb 2019 16:12:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id D3E8A4039E;
 Tue, 19 Feb 2019 16:12:12 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id C169C121B6C;
 Tue, 19 Feb 2019 16:12:12 +0900 (JST)
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To: Arnd Bergmann <arnd@arndb.de>
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
Date: Tue, 19 Feb 2019 16:12:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_231214_752749_B16CD566 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2019/02/18 21:15, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> +static int m10v_pm_enter(suspend_state_t state)
>> +{
>> +       switch (state) {
>> +       case PM_SUSPEND_STANDBY:
>> +               pr_err("STANDBY\n");
>> +               asm("wfi");
>> +               break;
>> +       case PM_SUSPEND_MEM:
>> +               pr_err("SUSPEND\n");
>> +               cpu_pm_enter();
>> +               cpu_suspend(0, m10v_die);
>> +               cpu_pm_exit();
>> +               break;
>> +       }
>> +       return 0;
>> +}
> 
> It looks like you left the pr_err() messages from bringup, they should probably
> be removed now.
> 

OK. remove the pr_err()s.


>> +static int __init m10v_pm_init(void)
>> +{
>> +       suspend_set_ops(&m10v_pm_ops);
>> +
>> +       return 0;
>> +}
>> +late_initcall(m10v_pm_init);
> 
> This requires a check to ensure you are actually on the right platform,
> otherwise you break suspend/resume in a multiplatform kernel running
> on anything other than milbeaut.
>

OK.
I think the solution is adding a "if statement with mlbeaut compatible" 
above suspend_set_ops(&m10v_pm_ops).

Thanks,
Sugaya Taichi


>         Arnd
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
