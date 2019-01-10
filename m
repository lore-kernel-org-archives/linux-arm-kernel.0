Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5041C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:28:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46D321783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HmXDtqiu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzDFKhlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46D321783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:References:To:From:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CcjLTp2R9pWDb9J8QIgkhFjf8fiDtDa7zcwKbFz7QL0=; b=HmXDtqiuDmbFfY
	nLuBB9IZMrSx7QBxvx5Ff0OBTdFCksh5sM4s+QTq2ICR0mpQ20CekIcSBQXW1sfG8PNM5/DQa/H5E
	Ak3u7YUXI2ZNQt/U87oAxRNIjwAYCd/we/oqWIebdixELIUKd6qJgL7BI7GJvnPp1CsYzkcQ547+D
	vqNsBsuqCVe8z5hDZFu582U1t63xl1zgdEA66KVZlmy16rdJp0OvG8T0PJLfbguKYMvePTTV29O41
	uK+Cay2Z3oovxGYchTRQfO6UXhZyV6/5ng8sfXhAGJF0NDqGeQ75xhjDsNPEsxsRqpXVE6GOd/pUG
	9qUhP5Tx7Ghq4wA3QwsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhru-00080m-8j; Thu, 10 Jan 2019 21:28:02 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhrq-00080L-VE
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:28:00 +0000
Received: by mail-pg1-x541.google.com with SMTP id z11so5372420pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:message-id:from
 :to:references:subject:cc:user-agent:date;
 bh=5Ca+giYTOowQwvE/IYNggDIbq1m8J3g7CFwxZA8Q0ag=;
 b=CzDFKhlk2/vTBwaFRoaf9vrKU+hbJyXFgKAoBWIZej2feOIXGQ11uVjRJdWMVAQMDz
 kxCu5CkKZjIgZNP5eqwHhvFsMxIOZEABqK5IMfQCt4tIDlaOlg3z9b82JWSSJ3959ZkZ
 iZkIaNwu+FfVTRBct7RB2ub9GwDmap6wwF2nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:message-id:from:to:references:subject:cc:user-agent
 :date;
 bh=5Ca+giYTOowQwvE/IYNggDIbq1m8J3g7CFwxZA8Q0ag=;
 b=GXiqtAwHM1aIv7BiUnN9iEKCTAGXaQMNrZlQZMUpPto9tp8k3JUJwvWgMIle/F011y
 ka2vf2T/GS/Yul9/GdXoBYKlAKSd2ws3iql+DQuGhrO8XTE8q414IZR2auCSunI0fGqe
 V8cP/2KuLP5ePl78KcsyaWhQsEAWdYTYK2IHKbD8FtEtc3Tva4hlfSPmcKRe+8AzSWnS
 TyRRKK2fceXdeYcT0AYoFowUJt2UiJQrqbSCou+MztegHqaeWHDxEvFcv7kQidqmCvWx
 QHi1KEhVcKutDe0eucS/obvtfgHKkt3dbeJm6c+xK55OUCy/hy6+E5wa80ToPOp///Ah
 9PWg==
X-Gm-Message-State: AJcUukemBykwH9kEmdAmLMk6eoPUSx7hEaMhLhqDHn279xLIGoFFFQum
 QP8I/9D+xXbnui+AEDDKVe3/NQ==
X-Google-Smtp-Source: ALg8bN72S+kydfm7mb89O2iixkm5DCUaNIdOab/W2XNkH7SgO09QtN3dLSWyYIDWyUWO78i72p+wfw==
X-Received: by 2002:a65:534b:: with SMTP id w11mr798087pgr.125.1547155678286; 
 Thu, 10 Jan 2019 13:27:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id w136sm111267669pfd.169.2019.01.10.13.27.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 13:27:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Message-ID: <154715567680.19284.12367636883540337540@swboyd.mtv.corp.google.com>
From: Stephen Boyd <swboyd@chromium.org>
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
 <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
 <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
 <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
 <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
 <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
User-Agent: alot/0.8
Date: Thu, 10 Jan 2019 13:27:56 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_132759_029493_97E4EB63 
X-CRM114-Status: GOOD (  22.71  )
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
Cc: devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org,
 dianders@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org,
 mka@chromium.org, ilina@codeaurora.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Raju P L S S S N (2019-01-10 08:58:41)
> 
> 
> On 1/9/2019 11:16 PM, Stephen Boyd wrote:
> > That could be done by making a PDC clockevent that has some DT binding
> > of a property pointing to an MMIO timer frame and then reimplementing
> > the MMIO timer code in the PDC driver on top of the frame/register
> > region it pulls out of there. Or it could be written in reverse by
> > having the generic MMIO timer driver point to the PDC somehow and
> > implement some platform specific API to pass that information to the
> > real wakeup programming part in PDC.
> > 
> > I'm leaning toward the first approach where PDC is the clockevent and
> > that uses the MMIO timer on the backend to do what it needs to program a
> > wakeup. That way you can mandate the usage of the physical timer and
> > keep this quirk away from the ARM timer driver. It also makes the idea
> > of a qcom,pdc-timer-mode sort of useless because the PDC will have a
> > property that points to the timer frame and that will mean "use this for
> > broadcast wakeup". I'm not sure how the ARM folks feel about this
> > though. It would probably require some sort of ARM timer API that lets
> > us program the MMIO timer frame from the PDC driver. So exporting
> > arch_timer_reg_write() and making that always inlined to optimize hot
> > paths would be required.
> > 
> 
> Regarding the first approach -
> If PDC clk_evt_dev is created and registered to broadcast framework, it 
> means it will replace MMIO timer event device in broadcast framework (as 
> only one broadcast event timer can exist). So in registration phase, the 
> tick broadcast framework would configure broadcat event handler for 
> PDC(clk_evt_dev).

Yes all the MMIO timer frames would need to be marked as "disabled" I
suppose, or somehow we would need to tell the MMIO timer driver to not
register the MMIO timer frame from there because it's used by the PDC
now. Maybe that would require changing the MMIO timer's compatible
string to be something different.

> 
> Even if we have some way of exporting arch_timer_reg_write() to program 
> the wakeup for MMIO timer, the irq handler for MMIO timer is responsible 
> to invoke event_handler. However, since MMIO timer is replaced by PDC 
> timer event device, event handler will not be able to inform broadcast 
> framework. What can be done about this?
> 

It sounds like you imagine that the MMIO timer frame will still be
active and in use by the ARM architected timer driver? I wasn't thinking
that would be the case. I was thinking that the PDC code would basically
reimplement all of the ARM timer code again by calling some shared timer
code so that we avoid code duplication. Including the irq handler that
would be registered for by the PDC driver and flow from that piece of
code instead of the ARM timer code.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
