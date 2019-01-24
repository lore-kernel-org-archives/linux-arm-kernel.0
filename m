Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52592C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:34:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EBD2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="REVOohD2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJFCP28L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EBD2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mnl0jUPw9Prq5ClSC1QlRTjC3QPqyVjfEm8zUf15/Dg=; b=REVOohD2LD5Vhk
	3MgLsM5j1dQCY6qoKz0kVmVDw9MRxzR/vrlhf/6OpNo61PLJtfmO/zB6Mlqx/mmC4HUpnCMsJSgHr
	ETbsX+jC8HgwiIL9vOjsYbOsHpeuIO4xoWCp+XJQgJigK0kffixRWxQfz4yQxK0i0EYuUxI6HHVWb
	YQ/KbwgOZQ4wyA/E2MI4DPEsRKpCzn5pMRWpub/wheO5bvB84sAaGorI5NHBPB1G1M2ih1j4tRM0b
	0kDNroELnVYTrMbel6sLRWBmEqABrHFDCT3fMfXrqLbDD106mcz5UgpHHl6A76O1Yfhb+reSZ5Y9i
	9CiLQkfeRYk8Up8wnYNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXeN-0007iu-V0; Thu, 24 Jan 2019 05:34:03 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXeL-0007iS-0R
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:34:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so1673447wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 21:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jKVCod9gp3ntegj5kYXtLFx52Wy2A6WVJuIBMAyjPpo=;
 b=dJFCP28L0VEVQEsVFPiP+5bhzspoc/0i1KLRDwNwT26kEMojbPvAv5Vitlp+h6261J
 2AZ5O2N4tZhsFmKTlRztwYwpMw+F2Nscem40rSig056eg4/nD5T+xF1hEVSQeetayLVD
 tNSybmLd8B0Q+KDV0PyREyqbVv5Ri0iwjm0n9lWqBrduaNgohgpLXvDZ8Sg7VK5p2dTx
 hXRA6s6afQL9L+hCzajXuNO2nnIbWSxbRHpBXQSyZWpyOawuyYJX3WEgjEidrv/GkjKE
 l0lhxRQ+rPjci36Yui0zfW++iOML2aeSLAiEmhUgh57OH/f7PTyQTd0ZHU9k8rgrBzFC
 ZZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jKVCod9gp3ntegj5kYXtLFx52Wy2A6WVJuIBMAyjPpo=;
 b=Vd+tGyXkqEPd7je7+VHfIPqzgQjMt6ya8qgGwGHFXJfXi5Hz9xzp0Yvn+RtzeMeY4u
 tkUU5HGprdSIe4w9UYgqZMklCrgcUDOBcAA8r++CClHkZPU6vaHWoCaLx23Z0juNnwC1
 Q82GTmWGFuhGljvVo9x+j+9unK3OR9dgReDlh/jl6+npy6aO6KPNqzIL9EixvHfhzede
 oFekXbZXlfyFE5eEQ2GgS3HThgAk+G2oGkOvNyIqmX3An5d/qAUX32Vf3qgi+sHGwxCR
 n+yW8mlu9evuZuHZCrYeTQaWyWi5kJz8Vo58KL2Nl0TD3aSfLOtxcQ5GJWs5uNL4ThDN
 UyDg==
X-Gm-Message-State: AJcUukcPHj7//H/dulJu1vjKR+ziPodZolTp9NHih9jvAMzqJfkGxX+n
 joW6zQyZChUZ8FjJAKstYMuyOEs/69KH9NZEpuo=
X-Google-Smtp-Source: ALg8bN5WzpsjDgSTjWVSpV78P1xz/XBp05HP6j3km6RuIsleuhcea/1TmsYv1rv1j/VO464uGALI1xPUM41UtwTunqw=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr983150wmi.144.1548308038881; 
 Wed, 23 Jan 2019 21:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com>
 <1547743553.4009.16.camel@pengutronix.de>
 <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
 <1548240735.3904.8.camel@pengutronix.de>
In-Reply-To: <1548240735.3904.8.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 23 Jan 2019 21:33:47 -0800
Message-ID: <CAHQ1cqH1F2ivi57SuAdhzm-iCV=YsNKf-E+_GfxxjabFVDt0qQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_213401_069487_9FECF4B0 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 2:52 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Thu, 2019-01-17 at 14:38 -0800, Andrey Smirnov wrote:
> [...]
> > > To be honest, I don't like these two, I'm not convinced anymore that
> > > they actually qualify as reset signals. To me it looks like this is
> > > something that the PCIe glue code should handle via syscon like i.MX6.
> > > Leonard, Lucas, what do you think?
> >
> > OK, one thing to keep in mind about this is that those bits are
> > already exposed for i.MX7D and I think (correct me if I am wrong)
> > there's no going back there.
>
> That's not a reason to repeat the same mistake for i.MX8QM, but at the
> moment I'm still trying to figure out if it actually was a mistake.
>

It absolutely is. Removing those resets will not meaningfully simplify
maintenance burden for this driver (a one line change), but it will
cause additional code churn on PCI side of things. You may not agree
with me that it is a _good_ reason to not to remove those resets, but
it is a reason nonetheless.

> > PCIe driver already has the code to use
> > those on i.MX7D and, due to high degree of similarity, i.MX8MQ
> > actually re-uses the same codepath (at least for
> > IMX8MQ_RESET_PCIE_CTRL_APPS_EN).
>
> We can always switch to i.MX6-like direct syscon/GPR manipulation and
> just drop the resets from DT.
> Since if this is done, it should be done for i.MX7 as well, I see no
> reason for this issue to hold up your i.MX8M changes.
>

Cool, thanks!

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
