Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE95620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fb/l8SIB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kUxFhSXE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="byUw6VHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE95620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4hUuDq7031hulnqXplT3p4lj7/RVbj+Lg81+jeWs16E=; b=fb/l8SIBQzQVLFgrFyOLTuxJz
	WUiIFULSnru37peG4TCbgPROpIjczEgQ5+cJZxkzfhHL19YJOiDu1cWVBIycBBMowqeVSkoo5edWz
	hP1I4jHytpHWbsAmiB9C6d55z2Jug+moKnC7F5qtzXvezFTuo1nvNC8QfMmmSSodTzhmxfrl9CSyo
	mvBMnI7Fc5hO5ZaeGNuZFRhiSGzVK33L40wr6UKzPNwEKV4+7RO/8vIFZdTjVSL8FVo9X1D6RVIWV
	2p+vD0mFS6LN37O1BUDBZtpZ6UlKAlP5Mg8tHgc+KwBS8rfpj019FgT3zheYMFSj59B7P8qDVO1xR
	XnNlPNeZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9bL-00028l-Lg; Thu, 17 Jan 2019 15:29:03 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9bH-00028J-2o
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:29:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 890596053B; Thu, 17 Jan 2019 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547738938;
 bh=X0Bs3pUe4+evpE7MdCKhnWyxlZN3PSJfCdvI9jWXUQQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kUxFhSXE00jjlpi+MGLxetr3G5IhNbm/35kIvh2IDiPT6au37o+j3qxqJ+VbKbzV2
 hNNroE26+IJYYt63QMGCOy5tEasvEa5mXq9tCC4SJWDQy1gFdgv/pYTgh38v0m9XI7
 aUYo6lKjmQbIhV3gFbdHSeQrBIeNUMWfE7OjPSkg=
Received: from [192.168.1.100] (unknown [157.45.228.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F444601D2;
 Thu, 17 Jan 2019 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547738937;
 bh=X0Bs3pUe4+evpE7MdCKhnWyxlZN3PSJfCdvI9jWXUQQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=byUw6VHBF/99Jq86aac5PiNOz1l9wPIiuxijrPfcM/NtPQD15sA9bZLnmetCROypJ
 mhlyn29lbTiB0IV0LCPpAuCcQ4dg0f3k8CdYPNtbV6scLQqUtbHOzqVXWsrTdiVYoP
 nvC3aVkXZvgsLzE7VMzNR305X0N96XIUdCynZGao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F444601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous boot
 logs
To: Joel Fernandes <joel@joelfernandes.org>
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
 <20190117151833.GA51139@google.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <79870bf9-e40c-2249-0859-b2404af296c1@codeaurora.org>
Date: Thu, 17 Jan 2019 20:58:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117151833.GA51139@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_072859_157663_C1AB9B08 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Tony Luck <tony.luck@intel.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
 Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Colin Cross <ccross@android.com>, Guenter Roeck <groeck@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/2019 8:48 PM, Joel Fernandes wrote:
> On Thu, Jan 17, 2019 at 11:56:20AM +0530, Sai Prakash Ranjan wrote:
>> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
>> arguments") changed update assignment in getting next persistent
>> ram zone by adding a check for record type. But the check always
>> returns true since the record type is assigned 0. And this breaks
>> console ramoops by showing current console log instead of previous
>> log on warm reset and hard reset (actually hard reset should not
>> be showing any logs).
>>
>> Fix this by having persistent ram zone type check instead of record
>> type check. Tested this on SDM845 MTP and dragonboard 410c.
>>
>> Reproducing this issue is simple as below:
>>
>> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>>     record in the mounted location which is the current log.
>>
>> 2. Trigger warm reset and mount pstore. Will see the current
>>     console-ramoops record instead of previous record.
>>
>> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 

Thanks Joel.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
