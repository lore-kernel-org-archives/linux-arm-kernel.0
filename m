Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD9821848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n7/P1ZAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD9821848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.panasonic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	From:Subject:To:Message-ID:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mxypVkDdcXCNPZ2xl8e76D6DE1CEgpUt//o3OhrQCEA=; b=n7/P1ZAmKYw863
	KgbDgLPHBWbM1R2bOTPP1vUlZghraNAuIkYpevE86asY4Q8xRan5L6MW9QY3nDJKDjFuwlVR/GuQh
	Q8x5GYb7FZAYa2bMAcoBAy3yto4jdjGYpwTU8VQ/ZXHsyys/zvJU/p21GlE3JI7TVnSRA/FKa5Ml+
	vgvksUbEIgMFCGwzMt8NrFC7zLYHBmnosGNearXuOZPzvvJAXR1KnUOdchKICmXwQNPqiPpXGtnEv
	1zemBmKh+xqroElZzprGG7yp5/MS5KiqmwqZCm59HvACTgdxPfhHU6zAa091Dx5ue2vXfytjf2us0
	uWoXyjoVO+T26eKkC/tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gySPM-0004Wl-9d; Tue, 26 Feb 2019 02:23:48 +0000
Received: from smtp.mei.co.jp ([133.183.100.20])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gySPJ-0004WR-E9
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 02:23:46 +0000
Received: from mail-gw.jp.panasonic.com ([157.8.1.157])
 by smtp.mei.co.jp (8.14.4/8.14.4/lvzy11) with ESMTP id x1Q2Ngg6012062;
 Tue, 26 Feb 2019 11:23:42 +0900
Received: from epochmail.jp.panasonic.com ([157.8.1.130])
 by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili16) with ESMTP id x1Q2NgF09616;
 Tue, 26 Feb 2019 11:23:42 +0900
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/pml-send3) id
 x1Q2NgtP024561; Tue, 26 Feb 2019 11:23:42 +0900
Received: from jpa000secmn21.palet.jp.panasonic.com [10.74.216.56] 
 by JPA000SGWMN02.palet.jp.panasonic.com with ESMTP id MAA14059;
 Tue, 26 Feb 2019 11:23:42 +0900
Received: from localhost (10.74.216.183) by
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Tue, 26 Feb 2019 11:23:41 +0900
Date: Tue, 26 Feb 2019 11:23:41 +0900
Message-ID: <20190226.112341.1785686123600192105.okuno.kohji@jp.panasonic.com>
To: <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: imx6q: cpuidle: fix bug that CPU might not
 wake up at expected time
From: Kohji Okuno <okuno.kohji@jp.panasonic.com>
In-Reply-To: <20190226.111916.501059283228026708.okuno.kohji@jp.panasonic.com>
References: <20190226020623.18324-1-okuno.kohji@jp.panasonic.com>
 <CAOMZO5BzMuWa16d3NOtOFgdBNOCL3YGsYW2s0eGxbnnx8+wdJA@mail.gmail.com>
 <20190226.111916.501059283228026708.okuno.kohji@jp.panasonic.com>
Organization: Panasonic Corporation
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
MIME-Version: 1.0
X-Originating-IP: [10.74.216.183]
X-ClientProxiedBy: JPA000SECMN25.palet.jp.panasonic.com (10.74.216.62) To
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_182345_747072_B77A8397 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Cc: s.hauer@pengutronix.de, okuno.kohji@jp.panasonic.com, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Fabio,

Was your meaning as follows?

-       if (++num_idle_cpus == num_online_cpus()) {
+       if (++num_idle_cpus == num_online_cpus())
                imx6_set_lpm(WAIT_UNCLOCKED);
-       }

Best regards,
 Kohji Okuno

Kohji Okuno <okuno.kohji@jp.panasonic.com> wrote:
> Hi Fabio,
> 
> Than you for your comment.
> Just to be sure, let me check.
> 
> Should we change as follows?
> 
> -      if (++num_idle_cpus == num_online_cpus()) {
> +      num_idle_cpus++
> +      if (num_idle_cpus == num_online_cpus()) {
> 
> Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Kohji,
>> 
>> On Mon, Feb 25, 2019 at 11:08 PM Kohji Okuno
>> <okuno.kohji@jp.panasonic.com> wrote:
>> 
>>> +       if (++num_idle_cpus == num_online_cpus()) {
>>>                 imx6_set_lpm(WAIT_UNCLOCKED);
>> 
>> You should remove the braces for a single statement inside the if block.
>> 
>>> -               cpu_do_idle();
>>> -               imx6_set_lpm(WAIT_CLOCKED);
>>> -               spin_unlock(&master_lock);
>>> -               goto done;
>>>         }
>>> +       spin_unlock(&cpuidle_lock);
>>>
>>> -idle:
>>>         cpu_do_idle();
>>> -done:
>>> -       atomic_dec(&master);
>>> +
>>> +       spin_lock(&cpuidle_lock);
>>> +       if (num_idle_cpus-- == num_online_cpus()) {
>>> +               imx6_set_lpm(WAIT_CLOCKED);
>>> +       }
>> 
>> Same here.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
