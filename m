Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD45CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCCA208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JXkYbXY6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCnwZFSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCCA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yd7KH6Twq2KMsyBgV2h7dbFRNCHobFI2FzJWrqotOic=; b=JXkYbXY6dI6p9Darx1jWnnfV1
	yLtRwxHNoYMcCPyz8xQ/GSjL9OcPwEVI4iALjR84Lqtjx0DcdW+dgQ1TkuXHjt/TKglYGRyM13ClY
	FLFjBj55/olfcwtvozlZnp+RMzagoSwdkj4dt296jvH+Ks7YLnkrTgWjHMF3+Vygr/fCVYlmSv8Bl
	tPQR2GgnISGty7Ha7kXLuoDx7+1nv72pxTj2MuqB94AShOty3zKXymrop4UGUa7jiqUhiPKEf1rAP
	LpBczL5iozw9gzw2VYugqqIxwJr0r1ey5wP+6oqIoRJfNsQo0CoAC5leCZwGFxOX8v7/Wm0me0aAP
	JnlUS2tsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFE7-0002Uu-Ie; Fri, 07 Dec 2018 12:27:27 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFE4-0002UI-6a
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:27:26 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so3583666wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 04:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fa7ZUaeNisB6MwzfrlCnNE/INyEusiuXNzIhSKPzn/U=;
 b=vCnwZFSllKnIZfEyGG8RpqLKKpETyvbE5nwWtNcyS70b7sXGAWuY40+jh9WbLjlppf
 SjyhvGf7QUi2+g5vPFN9swCHpnSpYKlb22g72rkF3rVC/q77rwQBUDBCD1GpH7Gf/Xfq
 m/66nQKtASVxsaO0n9Wl8sZpZpNSOxU6Z1C0mN80UfJE02HCgeWldrOEj83sjmisaG/4
 OukBioA7nxU68WFmd4IkWkntkR1Le92acd08B2qzmonW1s3tz8VKhPqF4QafGXXE/bGU
 UcZdTscDNzzFyMTt3sSBW+VOZmb+Vq/AUkyrumBKUUfwYYIPAlHnHIFQCuoDknKtb1hn
 xSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fa7ZUaeNisB6MwzfrlCnNE/INyEusiuXNzIhSKPzn/U=;
 b=YbHESpeo8SRVci8keccHhXU2SQ9rZSiC619Ak/bgMxtDZjXyKbjU24nPPme27377cE
 Q3WrD9/Vh/qHS+pweEkMfRn0uWdGqbxj3UCqWDhB7dSzSa8DGEI26l5OUUqZHLFNEzFc
 OPKH7yaWOcPGV6inefDGuvLt9reqxfS6gWAoId3EeNKIf7MjBU4pQVqEFDxAhaWP8J/Q
 xCz/X28pc1ShqVWIjxdeHaU8bEt0JDvKUsKIBIuf1FXeG8pDx7yKxaSVV1n52Z0likl/
 dynMBcedjUkpHoaGb8sjG4w/S9eiRERlTpbPFNO+00rji1eRFn+jC/9/PCWzmUaQxlce
 UcJQ==
X-Gm-Message-State: AA+aEWZDA+7TTNYk20o30CW+MD+2V3vYUhM0PaWiLQu68Ff4D827msri
 OSbwJw4uNx26XcPqKstQ5KSvC8ad
X-Google-Smtp-Source: AFSGD/WfsrMI/6wlplfnyOGpqeMpXomm6KQvdBQNtLYOEabsWsTH5qtiaPNz/Qh+kj6GoHjDqkqxZw==
X-Received: by 2002:adf:9323:: with SMTP id 32mr1597994wro.213.1544185630250; 
 Fri, 07 Dec 2018 04:27:10 -0800 (PST)
Received: from ?IPv6:2a00:23c4:1c29:2800:6205:b922:c1e4:51a8?
 ([2a00:23c4:1c29:2800:6205:b922:c1e4:51a8])
 by smtp.googlemail.com with ESMTPSA id r69sm6509282wmd.4.2018.12.07.04.27.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 04:27:09 -0800 (PST)
Subject: Re: [PATCH] media: cedrus: don't initialize pointers with zero
To: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <dd25052db89ccf292f2a5e45b7e94e8e6d000c40.1544180158.git.mchehab+samsung@kernel.org>
 <ff5fe553-fee4-bc5c-d1e9-9dc4cc1319ba@xs4all.nl>
 <20181207093106.4f112d0b@coco.lan>
 <4a2f5566-c021-ed9c-a9f0-03d6bcd894d0@xs4all.nl>
From: Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <948a841b-efde-b43c-9532-abf72c7a6a97@gmail.com>
Date: Fri, 7 Dec 2018 12:27:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <4a2f5566-c021-ed9c-a9f0-03d6bcd894d0@xs4all.nl>
Content-Language: en-US-large
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_042724_244936_DF3E9FA1 
X-CRM114-Status: GOOD (  26.76  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07/12/2018 11:37, Hans Verkuil wrote:
> On 12/07/2018 12:31 PM, Mauro Carvalho Chehab wrote:
>> Em Fri, 7 Dec 2018 12:14:50 +0100
>> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
>>
>>> On 12/07/2018 11:56 AM, Mauro Carvalho Chehab wrote:
>>>> A common mistake is to assume that initializing a var with:
>>>> 	struct foo f = { 0 };
>>>>
>>>> Would initialize a zeroed struct. Actually, what this does is
>>>> to initialize the first element of the struct to zero.
>>>>
>>>> According to C99 Standard 6.7.8.21:
>>>>
>>>>      "If there are fewer initializers in a brace-enclosed
>>>>       list than there are elements or members of an aggregate,
>>>>       or fewer characters in a string literal used to initialize
>>>>       an array of known size than there are elements in the array,
>>>>       the remainder of the aggregate shall be initialized implicitly
>>>>       the same as objects that have static storage duration."
>>>>
>>>> So, in practice, it could zero the entire struct, but, if the
>>>> first element is not an integer, it will produce warnings:
>>>>
>>>> 	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
>>>> 	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer
>>>>
>>>> A proper way to initialize it with gcc is to use:
>>>>
>>>> 	struct foo f = { };
>>>>
>>>> But that seems to be a gcc extension. So, I decided to check upstream
>>>
>>> No, this is not a gcc extension. It's part of the latest C standard.
>>
>> Sure? Where the C standard spec states that? I've been seeking for
>> such info for a while, as '= {}' is also my personal preference.
> 
> I believe it was added in C11, but I've loaned the book that stated
> that to someone else, so I can't check.

Sadly I don't see mention of empty initializer lists in section 6.7.9 of
ISO/IEC 9899:2011, though I've only got a draft version.

I had a play with Compiler Explorer[1] and it seems like clang is OK
with the {} form though just out of interest msvc isn't. I didn't try
exploring other command line options.

[1] https://gcc.godbolt.org/z/XIDC7W

Regards,
Ian
> 
> In any case, it's used everywhere:
> 
> git grep '= *{ *}' drivers/
> 
> So it is really pointless to *not* use it.
> 
> Regards,
> 
> 	Hans
> 
>> I tried to build the Kernel with clang, just to be sure that this
>> won't cause issues with the clang support, but, unfortunately, the
>> clang compiler (not even the upstream version) is able to build
>> the upstream Kernel yet, as it lacks asm-goto support (there is an
>> OOT patch for llvm solving it - but it sounds too much effort for
>> my time to have to build llvm from their sources just for a simple
>> check like this).
>>
>>> It's used all over in the kernel, so please use {} instead of { NULL }.
>>>
>>> Personally I think {} is a fantastic invention and I wish C++ had it as
>>> well.
>>
>> Fully agreed on that.
>>
>>>
>>> Regards,
>>>
>>> 	Hans
>>>
>>>> what's the most commonly pattern. The gcc pattern has about 2000 entries:
>>>>
>>>> 	$ git grep -E "=\s*\{\s*\}"|wc -l
>>>> 	1951
>>>>
>>>> The standard-C compliant pattern has about 2500 entries:
>>>>
>>>> 	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
>>>> 	137
>>>> 	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
>>>> 	2323
>>>>
>>>> So, let's initialize those structs with:
>>>> 	 = { NULL }
>>>>
>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>>> ---
>>>>   drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
>>>>   drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
>>>> index b538eb0321d8..44c45c687503 100644
>>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
>>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
>>>> @@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
>>>>   	memset(ctx->ctrls, 0, ctrl_size);
>>>>   
>>>>   	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
>>>> -		struct v4l2_ctrl_config cfg = { 0 };
>>>> +		struct v4l2_ctrl_config cfg = { NULL };
>>>>   
>>>>   		cfg.elem_size = cedrus_controls[i].elem_size;
>>>>   		cfg.id = cedrus_controls[i].id;
>>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>>> index e40180a33951..4099a42dba2d 100644
>>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>>> @@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
>>>>   {
>>>>   	struct cedrus_ctx *ctx = priv;
>>>>   	struct cedrus_dev *dev = ctx->dev;
>>>> -	struct cedrus_run run = { 0 };
>>>> +	struct cedrus_run run = { NULL };
>>>>   	struct media_request *src_req;
>>>>   	unsigned long flags;
>>>>   
>>>>    
>>>
>>
>>
>>
>> Thanks,
>> Mauro
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
