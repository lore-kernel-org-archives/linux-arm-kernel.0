Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE6C204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FicPAqk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE6C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nVAgDbIsDzJNONm0BhtH3L4DWUljRRqbJkfe/GdYzXc=; b=FicPAqk120MVRI
	h/hh5VaQkXPT+4XFqlKPN0xFYndiB24ITzbK3RWAPDg1iai/K7XQ7ujBghfGmiuIsQPoqlsSlyDIi
	DH+sKzVpAXuxq4TWbYF92qcem7pKnCiHCLZBhcveQuiNSzAM7UjkMEM0ooixYNss5O7qDevr5HxFD
	YDb+SW+ItUzrWD2yLlPlWJJRq/eJBa3yhT/H4YpirLjkxXrUmlAZ0I7uD6Lm8iwoDMElELxEePAaM
	G5CpQc35epbvgamxam3j3f/o9nm3TS7OlrRhdcFx870dcoE1+2Q+RvNj6OXiMJarxvn+sYB2Nm9bw
	BIve066jHOzTiZvQxSTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxzMK-0000Fh-FM; Sun, 24 Feb 2019 19:22:44 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxzMC-0000Ec-2O; Sun, 24 Feb 2019 19:22:38 +0000
Received: from oxbaltgw01.schlund.de ([172.19.246.7]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MY6TD-1gWfQP1W05-00YT5V; Sun, 24 Feb 2019 20:22:28 +0100
Date: Sun, 24 Feb 2019 20:22:27 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: kernel@martin.sperl.org
Message-ID: <1294540802.93488.1551036147867@email.ionos.de>
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Subject: Re: [PATCH 0/9] spi: bcm2835aux: bug fixes and improvements
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:S/dn+sIMfPDX0yj9+FXPLg5bVFMorgg/+XeJRf3O8p1LZex1ixj
 PBXLa3cskujH1Zk3lgSIE+JCSGHbbWE30323hVfkUmKgpekkpTXcAw7dEubN7oCXMqED0HW
 bcQ3o0BDiz2sJfZJnNxA3tVaBsnmuVXfL+6WTSB6jQTNwRXFGb8f35pxYmTsr6j2VKpmZAC
 1D4sgEi5VACZ1jKI91owg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNcSVHP4TBk=:RDsKrVoIiw4EwYd0oOvZx8
 7ON4saRCgIRIZAbMaH/0heIexlqYu3+gN0zTi2Lic3YJHza5ZFOmE1sD0l21c6Wv2aBQ6ffYU
 uWk8eX8QFoF685L4Zlvi28MuDGC2HyE9mS6nPOvB9j34ce6gWDGOCkXz2bEL6jaotbYjwWC5M
 OGjkRbjQlYw0Pa67S3IfexMEposwvTs7Wn2N1q8V121jhWH8gTviX4QdO7aqronwXDDI2PyFo
 yTFWy9P3i9LL7hGxksTblzR/1II/iDru1OyEIQAS1n7hkxAfqaBAk5mE5IRCjBRjXwZQyX+l6
 8qJYr9wlgJpuoyHcP+dF9MNiB4mi2j+3B7zDjtm2xo123zEnUTgE3OjfxXUCtZE7v4MmImtkb
 I6idq/05rGZlK+XiJnl1gs0fQFOawHHssrsvwxDathuFTdXc0iwJMOkKIZWSNgSXiodHRJaQn
 IJGP+lFEQZMi9o8t5Pk0XxrOvsx6JvNhaYkNkGQJ6ADftO6CkdkmX2YyxO/gsK5u7kvPXQ+8n
 UqsJ9Uk5q9OkGcIsPz4+crP/rUg15bbw2lpZnStnAyYTJr+l3r+ke7Jv+MaO1/IFL7Y822Z9B
 TF72OTlE5b2H96EMeltkh/2vIr9pzjCKQWcE/L2NQv1FWe2tpUeQnS3+Ld34ahFWlpPxa/ttn
 ib6LJNxkB5xtsQFjsmFmz0kJ8/zXry/Sy6CAFxJJ99r4ItVwTPQ+8svHkpc0DiWNyDr56m/3u
 HZfa2Se5r8Ob3pYD9sgSSH2C8r2L3HtMrvItPkesAaQdA/0c/sdidTFmlxo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_112236_412755_0CE3EBC6 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

> kernel@martin.sperl.org hat am 24. Februar 2019 um 13:54 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Set of patches improving the spi-bcm2835aux driver and fixing
> a data read corruption bug.
> 
> The main motivation is a rare data corruption fix that is mostly
> observed in polling mode first reported by Hubert Denkmair.
> 
> So this patchset first implements a means to control the parameters
> of when polling mode is used via module parameters and exports
> the corresponding statistics.
> 
> As stated in original patch the driver does not support native CS.
> But when cs-gpios is not configured in the dt (so a buggy dt) it is
> still working with a lot of limitations, but the driver does not report
> this fact.
> 
> So this patchset adds reporting and allows for a single native CS
> (with limited functionality) to continue working with a buggy DT.
> One question here remains: do we need to legacy support DTs
> that are not following specs in the first place?
> 
> Then there is the real fix for the data-corruption which is split
> into 3 parts: some code cleanup with code reuse, removing "dangerous"
> fifo read (possibly introducing fifo data corruption) and safe fifo read
> 
> Finally we remove some dead code.
> 
> Martin Sperl (9):
>   spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
>   spi: bcm2835aux: warn in dmesg that native cs is not really supported
>   spi: bcm2835aux: setup gpio-cs to output and correct level during
>     setup
>   spi: bcm2835aux: add driver specific stats to debugfs
>   spi: bcm2835aux: make the polling duration limits configurable
>   spi: bcm2835aux: unifying code between polling and interrupt driven
>     code
>   spi: bcm2835aux: remove dangerous uncontrolled read of fifo
>   spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
>   spi: bcm2835aux: remove dead code
> 

i consider patch 7 and 8 as possible stable candidates. How about rearranging this series that these patches comes first and could be backported?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
