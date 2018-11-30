Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866672081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aTH8uKSx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZxBpHm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866672081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4UiAW010IkSJwGH0xUq9iYF54aJil8LQX6Wyfmlz0o=; b=aTH8uKSxAdA7x8
	NQ5iQpD0TofbU01CskHclnSsmHQuEkj9IFjoWH8m1yE1h84Cv//KXHviGidVwjTO8Kk4snngT6ISt
	wIxhvQCJI/pg/MXOA8UfulmMsFZpXDFWAnL/jpiUuMLF12DGgdSFj+n2gnck11zzgyHOOx/LPk816
	KLmh4e708ns+naO6HOwRlpXqSmePzPnmylSAIfU6aSNJA/PjDJuJCJKiHFsrLeAY9GbOE2E1a7huX
	tIgAAlke0NGPLg6vCTmH7RKeNGeqm0dS83AEBUTTRONyPBByuNF361MMipB7cGQE7kaizSZIE4v4U
	u8XmHgoE3t+LKzuBVkIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeik-0003eb-Dy; Fri, 30 Nov 2018 09:04:22 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeif-0003dM-0V; Fri, 30 Nov 2018 09:04:19 +0000
Received: by mail-ed1-x543.google.com with SMTP id d3so4208648edx.7;
 Fri, 30 Nov 2018 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h+aWVCNdWj/H17F0ev+T0UfuTD9cV1MJBzhPRUmBiIA=;
 b=cZxBpHm4/3UnE7VEKez4Io1T1qrCidOy6DwhI1yyFgsob91THRLCx1m5OK4cR+ggyG
 BsSrFB0TA3U5FwbY2OO6HWqxQarVfaxkiu06Zj2bS3BNPnyBQxuKv8lxkLq6ukZ8i981
 ZZn5X2mHEwzW/DXmqm51vEhfuR+NO0PqgtrjgE43/tGRQGvkXNYNnVT7qSZioI3aE58+
 fqVLvYHJ0V+hFF5B6zTwvrGQSc8ZjhGn4VY8So6VxFz2/8oGRaoe3CbSL1BrLt6dG7Wv
 S+EeCyHAVQnGRAQsdvZrgq5ceysi0mBSsrGZtWgiL852TipgGe1iBXGxYfT1gbpuxcp1
 e7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h+aWVCNdWj/H17F0ev+T0UfuTD9cV1MJBzhPRUmBiIA=;
 b=mJODO1C2gYlA0F/EQ4CduLytg1WwD8QggYKsPoGEnuBgZ+Nm3PsIigKuWDptstlNm7
 K9S9j0qgUzqPurqvOjLpODLQJDFK9yd8i0hAW6f1JddBT/4lje+NuZbEws8vXUzurhgJ
 WT7R+73WPmZDPkm2c3k32YqHWhRpWixgbQS5FZ/poWYtlfKsQF2KM9+Mk24H1VpsA/2o
 EXpQho148hlIF4aAYDw4eoeFPD9CxA2YRP7vvHAz4Tb3L2uzbIrlvbCtEB7KK25Qc7w5
 cpzTgDwQvJPsdJCB4hfLDXiCsWF3+HaT3e95fHHhyilVMOlT6mWZggisp7J+1KER7U6m
 /Ufg==
X-Gm-Message-State: AA+aEWZLjR9X9Rt2WioCfpqEIamyGqLwRdG9eBt2CE92P4wHXn+BXKsU
 SuZkfOtRujL8KXo9f78eqpM=
X-Google-Smtp-Source: AFSGD/U7PrIOWwV1caPhtyeU9USmLMFDaG9GBcRQHs7IOr9T5XOC3zNKZMm61TbKroSg+eX9dHgvJQ==
X-Received: by 2002:a17:906:7087:: with SMTP id
 b7-v6mr4004150ejk.194.1543568644968; 
 Fri, 30 Nov 2018 01:04:04 -0800 (PST)
Received: from ziggy.stardust ([37.223.145.41])
 by smtp.gmail.com with ESMTPSA id d15-v6sm705424ejc.31.2018.11.30.01.04.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 01:04:04 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
To: Stephen Boyd <sboyd@kernel.org>, matthias.bgg@kernel.org,
 mturquette@baylibre.com, Kevin-CW Chen <kevin-cw.chen@mediatek.com>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
Date: Fri, 30 Nov 2018 10:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_010417_073147_D2F7AF48 
X-CRM114-Status: GOOD (  15.36  )
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
Cc: Matthias Brugger <mbrugger@suse.com>, sean.wang@kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 jasu@njomotys.info, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 30/11/2018 07:47, Stephen Boyd wrote:
> Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Jasper send this series some month ago. As there was no reaction from
>> his side, I'll do a friendly take-over.
>> I tested the patches on my Helios X20 boards and they fix the issue.
>> I didn't add a Tested-by tag as I added my Signed-off-by.
>>
>> Changes since v1:
>> - add a fixes tag.
>>
>> ---
>>
>> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
>> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
>> system is booted without clk_ignore_unused.
>>
>> This patchset
>>
>> 1. Makes it possible to mark outputs of MUXes as critical by introducing
>>    a new macro, MUX_FLAGS,
>> 2. Makes it possible to mark gates as critical by adding flags to
>>    mtk_gate, and
>> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
>>    as critical.
>>
>> The addition of flags to mtk_gate also exists in the patch series "Add
>> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
>> flags is unsigned int in that series, but the real type is unsigned
>> long, so my patch differs from that patch.
> 
> Will anyone from Mediatek review this? Why aren't the people who signed
> off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
> They no longer work there?
> 

My fault, I'll resend 3/3 with the comments you made. Added Kevin-CW now...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
