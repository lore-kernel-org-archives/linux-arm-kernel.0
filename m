Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:58:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EEA206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bJKXsP+3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaJr0Hfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EEA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QEQ6cGtvYKO5MotBCZiQo5Uj/RjtzxSy/Vr7YzJd3H4=; b=bJKXsP+3D6JeLO
	N4jejfehDUjw90n/XmOKxlkflTuMlwUHJ/JSMSgz4Zq+dvk+buqLiv5T/WwLvKuswjwQOq1YeOz2n
	uBNtWK0TSMMtAth87BkQPqaaAF5xOYGfMxA6knKSOdgnjLTnItF0qC28tGoxnQiqfD1wmzTcdA/0A
	hdVCp/TbscS2RcRuHCSwj1CAwIQv1c2oJGtAk8oG1EwZyNTi7xzAMx2LtWEKiTYzq3iqF7SA03MX9
	tjmHaB9V3nku2gN0UsF30AmUKihufBCiJMQoCf+3J5ug8LViIlmJ5L4EZFsfWclT0DQaS6gBHgBUu
	4FhGIcCDYwRSKeYxqOjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygzp-0007FO-TJ; Tue, 26 Feb 2019 17:58:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygzn-0007Em-As
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:58:24 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A38D62184D
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203901;
 bh=m6mHCPsQQZC8jTP1o4TOZRKOZ9xUmuI55O4V3gjdiiU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RaJr0HfjehRTPbm+n9i0SK7AxsVAaKSJA6yIsH6PJoYPmh7ildBPV7bLfi+F4OklT
 7Pdiles7+DiYl5sB0qSYwZOTjW2U6aY8RKvJ6H0coifNwxtQSzWVBlZmLnBh09ljWR
 LAAJWPDbDNmmOUxJXH8TANagrln6zPD6SCQLeu0Y=
Received: by mail-qt1-f170.google.com with SMTP id d2so15883856qti.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 09:58:21 -0800 (PST)
X-Gm-Message-State: AHQUAub5EUNfIGEShKsmjNHYpnfJhrzlWG7rPuqWRnyboHzx8wgbitA9
 KiFbGgi0wlWP4GmzN6CuMDxyltc6CZXb67v5tA==
X-Google-Smtp-Source: AHgI3IaIlxux6ndNLycxLYskECfc+KHXlgfc63Ia3E6tsy4xkUOwCE/jx8HpjJKNehCCHK6VNaJJjmS7HkPTnT8xgwg=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr18495684qtf.38.1551203900827; 
 Tue, 26 Feb 2019 09:58:20 -0800 (PST)
MIME-Version: 1.0
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
 <20190225165307.GA26260@bogus> <d2473029-76a7-de2c-8ff5-9d065577f0b1@st.com>
In-Reply-To: <d2473029-76a7-de2c-8ff5-9d065577f0b1@st.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Feb 2019 11:58:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLKcJiZCUp1FW4E7-5uC8v1Af0TZsiPympX9HsYE1N_dQ@mail.gmail.com>
Message-ID: <CAL_JsqLKcJiZCUp1FW4E7-5uC8v1Af0TZsiPympX9HsYE1N_dQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
To: Fabrice Gasnier <fabrice.gasnier@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095823_411105_56B43D5D 
X-CRM114-Status: GOOD (  21.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Lionel Debieve <lionel.debieve@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 3:14 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 2/25/19 5:53 PM, Rob Herring wrote:
> > On Wed, Jan 30, 2019 at 05:38:53PM +0100, Fabrice Gasnier wrote:
> >> Add documentation for STMicroelectronics STM32 Factory-programmed
> >> read only memory area.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >> new file mode 100644
> >> index 0000000..fbff52e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >> @@ -0,0 +1,31 @@
> >> +STMicroelectronics STM32 Factory-programmed data device tree bindings
> >> +
> >> +This represents STM32 Factory-programmed read only non-volatile area: locked
> >> +flash, OTP, read-only HW regs... This contains various information such as:
> >
> > Several distinct types here. Does s/w need to know the difference
> > rather than just one generic-ish compatible? Access size restrictions
> > maybe? Ability to unlock and program?
>
> Hi Rob,
>
> The reading part is represented here as "st,stm32-romem" compatible, to
> simply handle read only access. I agree this could be a generic-ish.
>
> BUT the specifics are regarding the ability to unlock/lock and program.
> Access size can vary from one part to another (e.g. on stm32f4,
> reference manual sates: OTP area is divided into 16 OTP data blocks of
> 32 bytes. on stm32f7, OTP area is divided into 16 OTP data blocks of 64
> bytes.)
>
> In STM32MP15, both the read & write access through the BSEC are
> specific, represented by dedicated compatible.
>
> Do you wish I update the compatible to something like:
> "st,stm32f4-otp"
> "st,stm32mp15-bsec"
> ?

Yes, I think given the above that makes sense. We can always map
specific bindings to generic drivers, but not the reverse.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
