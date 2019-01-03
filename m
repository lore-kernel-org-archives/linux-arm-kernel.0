Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7540217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8FwoPye";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OywNSw1k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcKWQg92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7540217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YqV+E3FvlUrXvrXIgLwHNi8vfB+Bz/RD2Gdy5tsjqd4=; b=O8FwoPyeLoQArV
	mUyw/AAoF3LXr5XoVtyqhalpTI0f4Wc4JiFU3NvofBajJ75qv0m/GMou8XPHIUDKbmyjJA50L9cAA
	zWmw4CzjPmqY0VBDT7lJA0EKXtwoJtaHQ5ez1ixg4LJMjyBPu6hdXV3QAtTmY845fW43ueAyiUYMO
	5mXqmrvTZoa3bYUeCUpW84Z684pp8JQji3OjRNMQIYVXpBfpmEmss6hwKU7FKZVIV2FCgKkuJDTlX
	kdfBxOfB2C1ZV37s4WfXziprJPaUanA937myeucYx7uTaDO13Cc7n1VGA9gZkx0H2jOA+kcS2RaBS
	ZKSek1Jrd+ZNoDHCPWow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf80n-0008G7-Ir; Thu, 03 Jan 2019 18:46:33 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf80V-0007sx-3r; Thu, 03 Jan 2019 18:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpLaT31lx0Chd9R3UN2zzE7rCUt3h5YDJRDI4MSKi90=; b=OywNSw1knzaJkcqMEZnPT3Lys
 sKWoSEKIo8s+jyvB3XCrUCAvUIIzfDJX4lak8SF3e2SdRewbyP+76e648XIhmTQPC83y3GluNVzyb
 KRs4e2X9TBrnLEqTmD50BnuYL9jLU/Z8Gp51+0zrsi3M3YOPt/GHK40eNdZEfPUCLc0SM7Gn7/q/F
 RgTtWCLrYBE69iWkLV50E0qyARGKr38qsKwaiyOzpZsgXiYTU9e1UN4syKLATK/+dKNTLwTpPD5+g
 BjflEqxg9KRugBRCDBNqoaTDIcAKjXZ3VpMctCe7pghe4ku4eA7xldZckrkgUe/cYQZFZjmQ0IFEO
 iIajgJO1A==;
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf80Q-00019b-CS; Thu, 03 Jan 2019 18:46:12 +0000
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 744FC21871;
 Thu,  3 Jan 2019 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546541167;
 bh=feEzb5DmN/tcbVN7HizVbAa2zKmf011KYyDHrWocAPY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DcKWQg92TvgrrnqKTYo9AlDequCxuKMlLuLItgL7ixQ/FLd62HxyfdTVOnW13nQwZ
 dgyL8VI0WdZSFLQcKoU8guNMxWaTzbavFI/RCTMbaI9WeQIJ7U4z5Y+nTDrQ4yyZXE
 5aQwtdpBdvAEqqOVRTtvrUPD2u2NFrMleyFbYcKs=
Received: by mail-qk1-f170.google.com with SMTP id a1so20220097qkc.5;
 Thu, 03 Jan 2019 10:46:07 -0800 (PST)
X-Gm-Message-State: AJcUukc34i5WpgbSbkDdmWGvo7oEHHp9g3VzmP+rPduOWb9a3KF03OG7
 Z5gzU5Jvdd9bN8Rk7lxdzQ1KZ9BThIYBYKpdqQ==
X-Google-Smtp-Source: ALg8bN55c9+ff84kzOyNUJ4aDSEn/x7T5GqMB7sVKtPRLc//csJ/sfkg77+ctfOHiIjv0vOjYNUIy5dwIWvxbvA4uvA=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr45626127qkg.147.1546541166685; 
 Thu, 03 Jan 2019 10:46:06 -0800 (PST)
MIME-Version: 1.0
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
In-Reply-To: <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 3 Jan 2019 12:45:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
Message-ID: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on scpsys
 bindings
To: Henry Chen <henryc.chen@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_134610_537369_3159ADE6 
X-CRM114-Status: GOOD (  19.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 8:10 AM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Add opp table on scpsys dt-bindings for Mediatek SoC.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
>
> diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> new file mode 100644
> index 0000000..036be1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> @@ -0,0 +1,24 @@
> +Mediatek OPP bindings to descibe OPP nodes with level values
> +
> +OPP tables for devices on Mediatek platforms require an additional
> +platform specific level value to be specified.
> +This value is passed on to the mediatek Power Management Unit by the
> +CPU, which then takes the necessary actions to set a voltage rail
> +to an appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-mtk-level"
> +
> +* OPP Node
> +
> +Required properties:
> +- mtk,level: On Mediatek platforms an OPP node can describe a positive value
> +representing a level that's communicated with a our power management hardware
> +which then translates it into a certain voltage on a voltage rail.

Work with the Qcom folks and create a common level property.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
