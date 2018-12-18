Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:25:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC57121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MjeGPufM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC57121871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=csUiHXfC5Aak/sDBcFMZrcx++k4FwzqXZLtCkXhsVLA=; b=MjeGPufMCmRoF7
	sSogJNnPQsqSMZbP5xVjMjvlf/zWE5R7VOjaN2CdXBGm4jFipRxTs2CHD4JXRRuJ5Jg1I0UAjyrWo
	3l5gpAM94hiaYyPl7Y1vLRp2oAojkycoywrqJqcmRJGLItyj40daWb27o6RWuJ/jLxJ6lQ9mFw29L
	C46NcSHsa6iMAzSibKr5j1teXLuC9RpYW3omIiT0xYeSwt2zztFE91CDscJ200eUaWl1fuU9fGI31
	//kz1xwnqGbQ5gkttIlKOosH4YQP8WvJZytVUosNJbwPMZJkXuvhb6Vye9bat88KvxafxzodMXpjn
	8qIOQ6UTJokUhxlQNbQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHFE-0006HR-Id; Tue, 18 Dec 2018 15:25:16 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHFB-000553-9D
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:25:14 +0000
Received: by mail-qk1-f194.google.com with SMTP id q8so7484452qke.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TohuLPIf0o9dPse0NxnUD/wZGM8HyqMmatknUS6JBdo=;
 b=RY88PficZnnxsPqO2yamvUbAkeT9/mjaCnappYuBKr1EH+KtzeIogOwlZOLbakRtQq
 BgzhtEl7WWZK5VcaV09XvMrSE3exYG73ubEeGo6AU8m/c/o88W1C8ZVxbry9/81vW5lG
 s6BzoHHNUW+lH7W+GWiWHn3jRzCqFj+HvLboDLQr/V0rGebzFSPzITAxeHR4qQF8zeHz
 GKhNvhgPQcNEqHABBf+DXvC9sfWBezfHuDxhOIQZ22D7+omdakDZEMTcoienbUDJOyQ3
 w+u9Clc12mhi9MQyiPA351iO4ZS7mTBkuC7wrB+DQu5kaDhuF8tS6DCqDXhPujAMmsgA
 O9Fw==
X-Gm-Message-State: AA+aEWZ/6hAPcXa0Qm1uViMR07fwc0YDp3mEcm8OuHLOdL9fhreJNpaG
 7IIzej693ssnIcCb34+BHPzkMktKKNfPmL8CdRM=
X-Google-Smtp-Source: AFSGD/VTjn43qT8Lfr+9KkSs74tGoZD2Fxc+cAfG6p+N9hFFssdKam1XkMeIdbyGw4JzWDKSfoZUIXh/VTsoiFTezSs=
X-Received: by 2002:a37:324a:: with SMTP id y71mr16649536qky.291.1545146701922; 
 Tue, 18 Dec 2018 07:25:01 -0800 (PST)
MIME-Version: 1.0
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
 <1542125174-8204-2-git-send-email-thor.thayer@linux.intel.com>
 <CAK8P3a1+LKakyD_gJTiNqKwNuP2Ptr_Wj4zJXf=+SDHSJHbexA@mail.gmail.com>
 <183b18b9-55f4-55d0-b1f6-674a6df49d1b@linux.intel.com>
In-Reply-To: <183b18b9-55f4-55d0-b1f6-674a6df49d1b@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Dec 2018 16:24:44 +0100
Message-ID: <CAK8P3a2=v=Kn5ECTFT-HkqhdtEkgG5sJ=jGpEa-FVFzP5M3Sgw@mail.gmail.com>
Subject: Re: [RESEND 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager
 abstraction
To: thor.thayer@linux.intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072513_351648_59BBFC8D 
X-CRM114-Status: GOOD (  19.41  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>,
 Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Networking <netdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Lee Jones <lee.jones@linaro.org>,
 David Miller <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 12:21 AM Thor Thayer
<thor.thayer@linux.intel.com> wrote:
>
> Hi Arnd,
>
> On 12/14/18 6:36 AM, Arnd Bergmann wrote:
> > On Tue, Nov 13, 2018 at 5:03 PM <thor.thayer@linux.intel.com> wrote:
> >>
> >> From: Thor Thayer <thor.thayer@linux.intel.com>

> >> +static int socfpga_is_s10(void)
> >> +{
> >> +       return of_machine_is_compatible("altr,socfpga-stratix10");
> >> +}
> >
> > I don't really like the way you are checking for a specific here
> > here though, that is something that should only be done in
> > an absolute emergency when there is no way of fixing the
> > device tree files.
> >
> > Since this is a new driver for a device that is not used in
> > mainline kernels yet (AFAICT), let's fix the binding and add
> > a proper detection method here.
> >
> Thank you. I'm not completely clear on this. Are you saying this
> function should test for a new compatible that is assigned to Stratix10
> in the binding ("altr,sys-mgr-s10") instead of the machine name?

Yes, exactly.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
