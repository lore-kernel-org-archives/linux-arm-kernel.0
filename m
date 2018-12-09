Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:41:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1B220865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gh6JlF9y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr5msybb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1B220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PX4ApnuWLGy9NbKDSZ18SziTTzyvUjEFaVphGnJmVS4=; b=gh6JlF9y/C3Uaw
	o+jO+mOcfv2ITW0pqXEXZvdRsdmhnbe8yGoiW+mUKMLoMc5sL3Q2FkVKQHH176phe9IfEp/iMLxw8
	8jcZof/o0SKIDZ7NQIZrUBGCw+vj2JHJmJ7IxpUOOoUMaZ3dxw/wGjgNc9iNWTIikYn9CD/PPXXjq
	WO93+V62LkpT3G3nbpf2GNiogzRJn9SKz8pEOEBOqtvubz1ij4DJWPX0dbfI+eNPedvcQf5bR38nG
	ff9scyAuhFnGTAzLqx3YBYUfmEoLES46WRjTLZG9inq9RzKr0OA08avl3HfsAuDx3FmpX/+17Ydtw
	Cm9D6DpXcDTdslu10y1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW1DK-0006Th-VZ; Sun, 09 Dec 2018 15:41:50 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW1DH-0006Se-C2
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 15:41:48 +0000
Received: by mail-ot1-x341.google.com with SMTP id s5so8142559oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KDIGYHKNMtE3j4moEPlaO/mHBiOVfDpfNQGNkGsMr6c=;
 b=jr5msybbQPH8aGCVuHeZCYGs098eCgi6wlCl4iFdq4H+rmDoNZxeZsahBvwCDYYS2l
 06sJaI+HaiBy6deSj8XPr2g/po7r95kx711acIUqPANomGQzTo3W454SfEGZwpE2Alem
 zcU3rbzpUb3M1LLi/pwx16wm2W38QhQmVwXwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KDIGYHKNMtE3j4moEPlaO/mHBiOVfDpfNQGNkGsMr6c=;
 b=j5LrC/tzAxc61TnjdsUjFYIXs4KAKnDHR90xo2GPYtTMWC7e4DP7RoxNiYaDoNEDQS
 QPLOyeNA7hwt/OKGquKMlM4BkTOOFHZobCPdl8l8a2OX6w2175IkVRWIgTxiB4uxfbGR
 Z2zxKMXFBpyqN+WZEpV8RIaDhlOx0G2dqW6fs69Fz2NzaGrsEiH/2f4d0SL87paeJRWh
 LSudhOYpZM6siOuSnNfzSsBDt/NJ2W8Gu4Hkw4zoKqyq/ftOse2APHk35dsKrEp8M2Sv
 9GgBpOYjs+R0404WW10Kf5LUhljUQR0S5XlYLNPcaUV+AYIF5yag9QMremnMyfcwYc6J
 d7tQ==
X-Gm-Message-State: AA+aEWZAFcj1iOnUrz5oKvmE+537ipMSilcrM90Fs0YzXumTQ/wDWgN9
 2No9Xdrr3oVsv3Dnvl9ff+auUsucenE3DA==
X-Google-Smtp-Source: AFSGD/UD01cJ69ofg0Ch+KWA6qiHRtyKnjJbZXQgPaDGWS2ig8jK3KgE+jo71jhev7PErbqn7RnVZA==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr6696735otg.139.1544370095951; 
 Sun, 09 Dec 2018 07:41:35 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id b18sm4353201oii.51.2018.12.09.07.41.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 07:41:34 -0800 (PST)
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
Date: Sun, 9 Dec 2018 09:41:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-9-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_074147_426671_A6405D33 
X-CRM114-Status: GOOD (  18.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> When pointer authentication is in use, data/instruction pointers have a
> number of PAC bits inserted into them. The number and position of these
> bits depends on the configured TCR_ELx.TxSZ and whether tagging is
> enabled. ARMv8.3 allows tagging to differ for instruction and data
> pointers.

At this point I think it's worth starting a discussion about pointer tagging,
and how we can make it controllable and not mandatory.

With this patch set, we are enabling 7 authentication bits: [54:48].

However, it won't be too long before someone implements support for
ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
will only have 3 authentication bits: [54:52].  This seems useless and easily
brute-force-able.

I assume that pointer tagging is primarily used by Android, since I'm not aware
of anything else that uses it at all.

Unfortunately, there is no obvious path to making this optional that does not
break compatibility with Documentation/arm64/tagged-pointers.txt.

I've been thinking that there ought to be some sort of global setting, akin to
/proc/sys/kernel/randomize_va_space, as well as a prctl which an application
could use to selectively enable TBI/TBID for an application that actually uses
tagging.

The global /proc setting allows the default to remain 1, which would let any
application using tagging to continue working.  If there are none, the sysadmin
can set the default to 0.  Going forward, applications could be updated to use
the prctl, allowing more systems to set the default to 0.

FWIW, pointer authentication continues to work when enabling TBI, but not the
other way around.  Thus the prctl could be used to enable TBI at any point, but
if libc is built with PAuth, there's no way to turn it back off again.



r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
