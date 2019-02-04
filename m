Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62312C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:10:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4792081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fIq/XmWn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATBHK+hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4792081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fzNhuDXCjqWGwcOetQkAUlBr8aalD9pLNDBzAKWLEQI=; b=fIq/XmWnNeildj
	oQVQrfMRMxqMmfTrQRvxPKc2JNUtb8/FUbFmmGE8nO+yLM5dE4sK0TTqNLB8xp2WpzvtXCFKLfg55
	3aQc+IY1rUrGQ5Val2aWuXtec4Mh8LVrswe7VH55lbxXmrnT+XrkHpIWhLu/RNXpEZpIiNdM/j7D/
	WZlfhs+ETCJUgslhU3HoDt9JBXSwLE6yTJsuaMRHjiL3dKvaq7wnu/QS2l7FOfIHJ04dxK1wtYSdp
	cQ13cXJE8HFxjG4XyrfztTuNaVL/Sroli6cx2QW+Ix7drl2QzSTws1K/8/9nb3OFnOtoQ/wlLkDUa
	6Jii/etrTsNlmZXtoYTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnNI-0003Ps-Oc; Mon, 04 Feb 2019 23:10:00 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnND-0003M4-K1
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:09:58 +0000
Received: by mail-pl1-x641.google.com with SMTP id p4so626820plq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y2om6UT/l9LBxzHzTDDkIIcT7sSkp/nQCgPs5IVDnHw=;
 b=ATBHK+hW5j9xEY1CB64aXDioHleepLiYMqSqSCmmLglCK1CDrpsqZ0Rl5mCQftNSU6
 KGhkOU+wfUzyj+Vu62o92+lqyquoMEzaNiJsE+3dmV3XEFNor1iHt+iunWqQ8jE4xWGS
 NFUCYsziIGjJinvh3eC0fTSxSfHSJlO6G7JMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y2om6UT/l9LBxzHzTDDkIIcT7sSkp/nQCgPs5IVDnHw=;
 b=CzTFYo3pTxSPQOvajgcvO0PfkAOWfxCK5jzuonyUBdFezLTREX0bRHbh+t/aArEkZM
 SgMRF9NtCqdPL1MwnBEhLU8KojcrZNGP7QpyBPJCbb8zJLiHCLboUxVJsAFns+cm5aD+
 Q44kJ7EO6z+lORdzahvmDY3NpIjwlxnv9anN0Fr7i0+VxksET/YFOc8bx8udR5kHZvpw
 stQYteNRrjQG1hd5uUT9qEn8utWsYmQ8e6m0FvbrH09juBFJvdfNDM1tRLH71KBgtnuD
 B6SvPtrkNtlX94Sk2uEGovK76/KVHEb0ZGs5WkgKbSeZreH5qk5Mcn7TZIGslM9fvr41
 3G6g==
X-Gm-Message-State: AHQUAuage/HmxxMb/PkHuQwu3+bP0NGJTfZLAWzsQDg0fOuLFqEWPoSv
 eB9iph8EMTZ+y64S2KQbn36CBw==
X-Google-Smtp-Source: AHgI3IaQNOT/SNT606HAwVugKeo4ZqvDQboF13nwdkFCEkbCkT4uw28sOoM/PcDfVDcTLAmGzZBpnA==
X-Received: by 2002:a17:902:e307:: with SMTP id
 cg7mr1880274plb.255.1549321793964; 
 Mon, 04 Feb 2019 15:09:53 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id l85sm1794783pfg.161.2019.02.04.15.09.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:09:52 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
To: Wolfram Sang <wsa@the-dreams.de>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
 <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
 <20190204111205.GA2068@kunai>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <f00f179b-9824-2211-1456-57fb53ec482f@broadcom.com>
Date: Mon, 4 Feb 2019 15:09:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204111205.GA2068@kunai>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_150955_764495_DE507B6B 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: mark.rutland@arm.com, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
 ajayg@nvidia.com, rayagonoda.kokatanur@braodcom.com, aaron.wu@analog.com,
 pierre-yves.mordret@st.com, kramasub@codeaurora.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, jdelvare@suse.de, f.fainelli@gmail.com,
 eajames@linux.vnet.ibm.com, shreesha.rajashekar@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org,
 devicetree@vger.kernel.org, arnd@arndb.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com,
 robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 jarkko.nikula@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On 2/4/2019 3:12 AM, Wolfram Sang wrote:
> Hi,
> 
>> Just want to check if you had a chance to review the following patch series?
> 
> I am sorry, but for some reason they are not listed in my patchwork
> instance, so they fell through the cracks :( Can you please resend them?
> 
> I will double check they show up in patchwork then.

Thanks. I think the issue might have something to do with Rayagonda's
email client configuration. I will be helping to send out v4 of the
patch series.

Regards,

Ray

> 
> Thanks,
> 
>    Wolfram
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
