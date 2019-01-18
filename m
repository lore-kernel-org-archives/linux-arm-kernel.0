Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53884C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221C820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sj9vc1Iv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akjH+2eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221C820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vK6cgyMeQjETn4qZHTV+6jy1HT9D7p3UhFS6XE+MMrE=; b=sj9vc1IvpnkuZ9bqyIwdAd5+V
	ADqtygWTfc43iIPqtt66jS0McZ2KQJdlXH9E+1v8r6QItI2ZbXFMEhNJzevqMMKxemRwVVc84+Yju
	R8MXlfzb5bledlYWrwUvuSEKwsCEOL7lB3Oc4THRAMsBfOAXF7HRMn/GZnj5INyDkIPma7Do17I6F
	RWtVasnrZ39h+Ej23wXPBrswBglfA6jBHaS69jjzpyBaT1HumoLln0iB4rtI63nK0/aB46Unb7oiP
	zVlRMtJUtwKsx9MRsd3V8O/+ccWR74j44pZc1AAjEtV7yyNv8lM8rXGdv7Ez/TnFT6qHw+t+c6TRg
	MxXaMQvlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkLEA-00042v-4Q; Fri, 18 Jan 2019 03:53:54 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkLE6-00042Z-Ni
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 03:53:52 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so5399731pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7yhRch6FR1X0atml6/N3oFIVRlkdBvqnao2ux+lG9kY=;
 b=akjH+2eWJp+159BLzoIqxs6OSGZ/iV3uC0DA6rs3FLF1pYSm5f2IqhlR4FxvhewwTp
 jiwSjqQYO3kt2LuqAVk/NuFSx0L5m57F3VjXP9EbJ5S7Xf96H9dNXIkuSEYqKCwsx+bw
 wpSkfUAMWq65uzPu9yDvS3I+9xD47IpG+kpLt+Q1wYJHjWReONj+UUF1Oe3KK09Q5SMH
 KdTXmRVyljMPbbxOYiGWaB7aNHQf28ut12Iyj9gvzFjcOMSchFb1tqtLD+hS+PyeX38d
 VKQQPVVCXtLtpOsASePsV9qGOcNpFa1u3Maw+2ovbtNR+vIsq7Spo30VCwOmwH3lARwL
 zYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7yhRch6FR1X0atml6/N3oFIVRlkdBvqnao2ux+lG9kY=;
 b=IdEN3lorKC7A7nfhhIxboLu8pXHHkJEaz7rxAhxr/BgFGrvlBp6VK3hpNgtW/fZzSL
 dWFcgPBwlNAmgR3Ug9QNLXJoyerd2ykTkkstZBKhP6nZgcFtNpZ1B/snzk0D3u85zKru
 yuOD3Qvn9Maz+WaymzShpLAKWYRe4mHaxU0s6syr5wbAJ5oTwqTjKUgx66abJT8d76+y
 TsrrqQgn3O4F91B+sIJThI5lppa+M6ngC6OTZ8VvJ0arypQqQEDkM7XvcdGML5acpRKc
 LgDqA0QSaXnYGo8vDDglIpqMZLZKTfWObxaGV7JchbYp8bbsBSsPhQh3nPZ0ehn6w/uB
 FC6Q==
X-Gm-Message-State: AJcUukcJxAx7F44y1K+Ju8OU+4M7F0pzDsP876aeFx4pMHShax8VSJfj
 M09mqUhjPhArnUPJoJ/KnU6b7p5Q
X-Google-Smtp-Source: ALg8bN6kpFtPikooXqnq3ypqTXw2kfkZv2UM/0Kf9AJL3fT3PGNuNVJBeWV4Q72EJKj16gYP44ZIJg==
X-Received: by 2002:a62:68c5:: with SMTP id
 d188mr18217276pfc.194.1547783629598; 
 Thu, 17 Jan 2019 19:53:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 p7sm4954066pfa.22.2019.01.17.19.53.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 19:53:48 -0800 (PST)
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <20190117181603.GA14800@roeck-us.net>
 <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a10264b5-74a2-2d80-a523-2ab1f4ca02b9@roeck-us.net>
Date: Thu, 17 Jan 2019 19:53:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_195350_800888_CE747B53 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Guenter Roeck <groeck@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/19 6:58 PM, Sai Prakash Ranjan wrote:
> On 1/17/2019 11:46 PM, Guenter Roeck wrote:
>> On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
>>> This adds the support for qcom watchdog suspend and resume
>>> when entering and exiting deep sleep states. Otherwise
>>> having watchdog active after suspend would result in unwanted
>>> crashes/resets if resume happens after a long time.
>>>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
> 
> Thanks Guenter. Should I send a v3 with your reviewed-by?
> 

I add it to my watchdog-next branch and Wim will pick it up from there.
No need to resend.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
