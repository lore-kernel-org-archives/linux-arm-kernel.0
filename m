Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9990C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:58:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926C82082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0JeCTRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926C82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5HJEoFT2eQFKq+grsqjlLYl/P4ePmxeOL3TLiy+3Obs=; b=i0JeCTRIUbu4a3
	LPcA/b/s+kWe5kXYh/Y+xe8fxUjEqBBf4mufvQeBbgeGjhZvgeV1UWzDYfGZFTZ7L4hBLDT+5GjSw
	P0lYADJKIf19ZIfd56W0n4r8S8E9O0rP2/2J0jE3aqibSZv7yEJaO2WgIPGs3DBtcZfz8NVmMMBJJ
	mooGepIEOuYtvNRyIE+H1GzWJMFSBOBoqcI9dlgdqyQmASrHTM8b5n+C/bdvqRXV+sKsRiJSFxKpA
	mDCh4XODJmun2OINNUMQEo16V4DYJ39K20ga+Nx19jXgUkvJ81mGIQeiQLfcOFsoeO9aEqxYOG1JJ
	lTgIQmloKm3wOGn21zGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUC97-0006Bo-Uy; Tue, 04 Dec 2018 14:57:57 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUC94-0006Ae-4X
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:57:55 +0000
Received: by mail-vs1-f68.google.com with SMTP id b74so9941784vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AIcr61O0Nb6BVaATDrV4fKb6Paoy35Rp4VMoCXfkEFQ=;
 b=I+ks6ygMYNcWUsKd8xMGve6C/mPGoHYqIsGKO4W+/K1Z9T1eEySzmfnfgz5CqRCBkM
 s8QmGuP7b/xCbeQA71zVNIcLxRatPEaU101KPLkzIvPlkbNl4/UPhab9cwaJt6GXKh9a
 ZsG/+kpQcR1u+S9Y6JnoRAldM3iFIgl1HtXHrt9C0YurbwjJNk3Jza+7HCKCx4UeeXW3
 EJZ1FX4neKby8DwlrLHcJIDZe9ooecDuTAfU/CbGiOgQk/7asZpOwRQga7SnnIl8LE9W
 WiHjAc7FcT2kbHl2FMKc3aqYtR3y9RfEppedog36lqiYrjD1Fo8hulsOhJNHqfal3Xmh
 UFBQ==
X-Gm-Message-State: AA+aEWb7hJQwPJ17KGPtkyfx23yWUUe9sZ6qlYPXqKc3/lZIv+NAuddh
 iYhdHgeCNvF6xZ5DTyD9UAcM2hA1MwiOHXYxph0=
X-Google-Smtp-Source: AFSGD/WOv2tdd5tGICH0vrauIUxfXhNRXEiPJ/feJt/qFI5J0CV2mHMh4MIoyBMKmDQwp3vVwzNp3v4HPU6unQOFZNQ=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9062834vsp.166.1543935462650;
 Tue, 04 Dec 2018 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
In-Reply-To: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Dec 2018 15:57:31 +0100
Message-ID: <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_065754_172059_AB306B64 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 darknighte@darknighte.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm@kernel.org,
 Frank Rowand <frowand.list@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> >  2 files changed, 218 insertions(+), 151 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
>
> Hi Rob,
>
> what is this based on? I get a conflict when applying the .txt change
> and if I knew the base for this patch it would be rather easy to work
> out what has changed.
>
> Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

Probably even s/shmobile.yaml/renesas.yaml/, while at it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
