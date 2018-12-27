Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84596C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:57:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D21214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SrDvOAD6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hc6SMTqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D21214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=weYCTe+BQu0UHnurw5LTaWFYcpEqq1DNmXBIU3+zbAw=; b=SrDvOAD6NhRIcq
	pT01WpcxiDpfCBaCSjDAwJazLnWn2XCHSbo1yZ6V98fLm0wFHKFLbCuxpPaeqHuMKqZdp4T0KXvOE
	tVkb5hY9XyN6yGchFLTwpjc3KaDHyvN1atcbzKPDCxYmYXHTNhaFVEEH3HJnOZk0vVi6MsxTr4JbC
	p/kGEACjqVOplLW+xvs9NxmCE7W2bllD57QtMzp37WwNvdUnTIVPp7jUXb7HGmWL/Cn0OMRgzwGys
	m71ROEyp03VEP9H7r7d42NA6qobkIAz1MT/Np+/aZddPbNbPKfnpr1/r86uWXEn1LOgnleRqJPpJZ
	d8QO5fEwvkU3pr30VJcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdeC-0004gh-ON; Thu, 27 Dec 2018 21:56:56 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcde6-0004fF-RX; Thu, 27 Dec 2018 21:56:53 +0000
Received: by mail-ot1-x344.google.com with SMTP id i20so17345056otl.0;
 Thu, 27 Dec 2018 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qpvNNDNFbl2XbhdSLEQ4I8hppK6pfisIA9kuAu0WWwU=;
 b=hc6SMTqW8avzQ7rmPZQdiGq7T0o5dRNfIz+a/uG4biAb2WML9ZWIruyB9goiv15u8q
 3BQhnP8Hvts53wqfGupIuPPuzxsBQAXllRYp4zlQxxkGLd3ztouHSNA4qkYZwu5P3l23
 C+Xmk2ufdPGsh0oy4wFv+H1HnOPxQIkSneY9NW8x57i9NAjIBl9gJ8KuOU2EIKGqVqWo
 qN+a1WxyCqQ5ANlfdo9ynbm/O22mL28XIO3/UO/RdlTA4OGMeL2ca3bTsi00g6xY23n+
 X1kWiAQv0GtKKzgsHvz+gCbjCWWAi0zcc8VuVwIKY5JNQk4Bo5icXfXbKUlBTPmaxITe
 +6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpvNNDNFbl2XbhdSLEQ4I8hppK6pfisIA9kuAu0WWwU=;
 b=syJWVNuO9Emr5I01lySyZw8KYRiVjPyktsu3wxnRHlw/edkdkiw2pLGJreD70dswW9
 oPQJrbhAG8Tai/TdMGr95qlWalqcRi6vPWf4+VVYpiVEC3d+CKxJg0xyN49xiVs8ygae
 f6VicKTtL5ptALq/TXFkMz1Ad9dRIH8s282R/NC4Y4Q6+4tHaDIr8wGHmqPrjd9h0d96
 fUztkdBJrjWIYYNul2eETYja5SuRvoGPrH/58iR9rqdpzppNfqZgy/RJqtchDEu4rt67
 t1+YYF+bqTAaeb8mpexiNsAV007DicOoLm1imu3luR3WkParkI1dNDpdBssJpVuLSRgb
 gfzQ==
X-Gm-Message-State: AJcUukdvXkz6xxeBUaJH6DqsOpF/7iX7ZmBpHzdr8R8h78SRzc0vGrw7
 SgLrxEBGgz9ZujFU8A8iQIwYRCaQHfnDE+svPR8=
X-Google-Smtp-Source: ALg8bN4JIlq1HeVMU+lVRPIXqHKVDV+Dv+k1Q24nGnE9gM6S4jB8m07E2kNz5c71dIobNSQqIrpuDcnUflGeon0qzzk=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr17710714otj.148.1545947799737; 
 Thu, 27 Dec 2018 13:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
 <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
In-Reply-To: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 27 Dec 2018 22:56:29 +0100
Message-ID: <CAFBinCBh8hy8xmtz6j5mKPKwy3yW5bxTQG8TEFDNN-ocHfqTEw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To: ben.dooks@codethink.co.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_135650_951564_5B508164 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ben,

On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ben,
>
> On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > [resurrected Ben's patches after 2 years]
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >
> > > Just checking if the change of author is deliberate?
> > > not sure how to do >1 author on patches like this.
> > I changed the author on purpose after seeing how much I changed
> > (compared to your v4). this is also why I added you to the CC list
> > however, I left in your copyright (just like you kept Carlo's
> > copyright note) and MODULE_AUTHOR
> please let me know:
> 1. whether you want to be the author of the patch or if you're fine
> with my name in there
> 2. if you are fine with both of us being listed as Signed-off-by or if
> you want me to switch to Co-authored-by
> 3. about any other concerns you have
>
> I would like to update this patch next weekend so it can be reviewed
> (and merged once all is fine) for v4.22
I've been busy last weekend so I didn't manage to update this series
please let me know how you want me to proceed with this


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
