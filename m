Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:32:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A9920665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7/MeLNt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o1OD97SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A9920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nCXjVVVzuB67tCh05MGt5j1nvMMiPSS2Fs/AJJiQT04=; b=G7/MeLNtly3KRH
	K1U3tGcTnRERpwhw/7/ZeAtQiesSAZF3O2QumO77uDmndJNdGqqP7ZB9x1IGMkW91CNmAfen2VCKh
	wrK47AYop52NGWs0X1OnAMpZJd/6NiuMCf4No1GjIP+B+a6mdSn2ZK9KgnbxFclc0QFM4ow0Vf5o3
	uXoRovVxOITbCLdBjzVH+d/HCz6+J8YhRqSlNWPJ3ThDLuLnNh97sGM2XtkzwfFESpS35wKrFCI7T
	kdiPpqu8W8wfTZfIHG/7mQGmt2wJOfWnY0L1raKcM5J/1LLA0u4ok/v1Ck2R7ETIpn98vhyDZ4ypx
	d8qtmWdvr0DyK1l16AGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzv0-0003rV-Am; Tue, 08 Jan 2019 22:32:18 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzuv-0003qc-O4; Tue, 08 Jan 2019 22:32:15 +0000
Received: by mail-oi1-x242.google.com with SMTP id y23so4731024oia.4;
 Tue, 08 Jan 2019 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lpHcHYZVECHCMmgw7nxoZ78ODtJVdZHm4b8ucqmAwqY=;
 b=o1OD97SNchjEbwtPnTjPqEExOAVcXNCt+9nOpxW4qGpqoUy1IXSLNxxSZVFwDggi2X
 q2EJuAComCIGsfyJjNg9CpOiq+WjJ9mni8ixKcXvlRy/3Ae5GoAL2iDFQujRtq70VXBC
 fxjO4fRzFgChyLZPzAoUMV3GUYj1hCpufJrl5kftoT+mmN6Iw9jmM3rjJf5/cL+X2JUh
 Xvlu8hPbWHDqDMqmjXVEnDscZ7Iw+yZwaWl3IkjvWt9TjKNPtvhq0GP9TYoNTgObkFDB
 qa1OzIoX5vMf/OMJtElRZ6nr2n3CEKBb7/yINqOlCN6MqbbePjNrjPZi0uRpdqXhfA96
 SQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lpHcHYZVECHCMmgw7nxoZ78ODtJVdZHm4b8ucqmAwqY=;
 b=M0GsoCdsU8EBobrKARKej9C1uLf5RWWbE9mUOQkTZpmY6a/INUNcZTkpE2TMa+Ajv4
 KoUmrGmY2h62VGra8lipqXVD18n9KuGCBNdfN8ozYrHb6KC1B+H2/JELrgU8hBRH7w8H
 mAolimSV8ar3HCUgAS3Whm1JNPFiJdIP0lA64hMS6ZHJsMW4lsc2m0PAGGekE/a5E6hA
 whNSwcvcy2GzuFiJ++DhaMsL6iZ7aSZmfE8vMuGCMEKlQKXAOCOu7nIBOLLWlRX8glZ0
 Hs5vXnqbWsVmJktc9UI0nYDwcYXOn8SHVZLccbJrkHIsjn2Gt6FotZIcSro3OLd4GSDF
 uXIA==
X-Gm-Message-State: AJcUukeiZl7kmlb4KoRnobpm4WalwBlfDLbPl+fNU04PLSYj8ALTvOaw
 l5eBAT+ALHsRSMn5Ji2kFKexym9IOyRgD2g9Y9A=
X-Google-Smtp-Source: ALg8bN6XcT9aBLpGKi4TTTSkwxCKME33vxjabBAkizY2aoCZ9u+Lqin81biIk1snuoGgcvDoi7IZw49UYClpSmIbmMk=
X-Received: by 2002:aca:3586:: with SMTP id c128mr2432085oia.47.1546986732568; 
 Tue, 08 Jan 2019 14:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
 <CAFBinCCbPbSQZeF1mzfBfLt+cJ0P=ajHznZM2prn600NO7G3sA@mail.gmail.com>
In-Reply-To: <CAFBinCCbPbSQZeF1mzfBfLt+cJ0P=ajHznZM2prn600NO7G3sA@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 8 Jan 2019 23:32:01 +0100
Message-ID: <CAFBinCB393w2cBacB6c_79Xt22suWWfx5omEKmzBJx02vb3fKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_143213_809904_BC3EBC47 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Sat, Dec 22, 2018 at 5:57 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Kevin,
>
> On Wed, Dec 19, 2018 at 1:26 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Add the G12a (S905X2) based X96 Max board[1].
> >
> > There is no branding for the manufacturer anywhere on the product, so it
> > took some digging to find the manufacturer.  But since there's nothing
> > about the maker on the product I've left it out of the DT name because
> > 1) nobody will no that name and 2) keeps the DT filename shorter.
> based on the cnx-soft article and my own board I would add the
> following section:
> -----
> There are three variants of this device:
I had a chat with Chris Moore (who replied on the dt-bindings patch).

> - 2GB LPDDR4, 16GB flash, 2.4G WiFi, 100M Ethernet
> - 4GB LPDDR4, 32GB flash, dual band AC WiFi, Bluetooth 4.x, Gigabit Ethernet
I have the 4GB LPDDR4, 32G flash variant which uses:
RAM: SpecTek LPDDR4 (chip markings: PS082-062 BT / on the side it says R5JH)
eMMC: Micron (chip markings: 8FAI8 SJJML / on the side it says JXML ->
this might be "MTFC32GAKAECN-AIT")
WiFi: Ampak AP6356S

> - 4GB LPDDR4, 64GB flash, dual band  AC WiFi, Bluetooth 4.x, Gigabit Ethernet
Chris has the 4GB LPDDR4, 64GB flash variant.
RAM: same as on mine
eMMC: Samsung KLMCG4JENB-B041
WiFi: same as on mine


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
