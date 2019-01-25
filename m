Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEBC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:43:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA948218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FL+aAjnU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgRjlywz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA948218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=BwTP3jR9RL7yVFzjnn714aqyhA5RMHfWYQo1c9c5+aQ=; b=FL+
	aAjnUqY3Lketh+M6AgkXykjtIDTislSaihrbyzV9+JyUyjhhARhzArHdJODwU+iCSXLYyx0o/aXrj
	X4/W2BZwn7SpKhMm2LNmcCMMy7bPmj/S7Nh+L9cB3DOTVELT0zzx3ww4sEw1P5tpvB8HMBBwwWqXH
	yEz1+j1Ysvri6hrtC3uC/7/1LlmvD3G98GSiOi4swaRE6o2zQFeZxw7Ilcu2i5z4AiuigdTs53TJu
	pY2hNek2o7RoJIbSKIAVBo/Lr41XMQ4lOJRAPAIS7mRDu8tlNX8jwh8UP55Cm5WDePGENp0NqKdLP
	3OkbFBymqpApQGGYP30BSU4RuJqw9sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsOU-0007dm-0M; Fri, 25 Jan 2019 03:43:02 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsOQ-0007dT-NB
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:43:00 +0000
Received: by mail-ot1-x342.google.com with SMTP id a11so7294044otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 19:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=cQyx796CdyPLd6Z1jNE1SN+nlBxAlpKV+6EGTwtvnz4=;
 b=LgRjlywzBbDfDKF0ksGkfhFKF4LpPkx06FWz70lU7T9x8FmVjsxIrUhXgS6bodQa75
 ON+TscUs8lPgCmXyc3Y8ChwGKkjfQQx8Iy770TyTthxbuVi5/SO4pV8i+3dgrw30ctX6
 wgGktrQ7PPmwhdfJHxuJUkztpoeUpGyd3B+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cQyx796CdyPLd6Z1jNE1SN+nlBxAlpKV+6EGTwtvnz4=;
 b=fdJ5JalGOdny6GxrbiuVr02F83aVxt29uUUyKbN3/ECjYnjibdTA3phQ0sbm1VBWDx
 woif/4kDl9pW2E3tm72N4RtASrwwioGqv3gLAPnenPOn6Q5joCVR366t0JZirbeQzHUL
 BEfDmRcubuLM7s0PBM6Fq25gja3YCWjf0TGHTLWCjz/YCKu6py0sRfBu+sLa3N0Tsxlj
 8aPlAy/Y9md/l19Pa/euOzGV3ko4F+nrh2wGpJE7iMOPY50Wp5Vlf4FgbBKpN2LRNyyE
 3NxX47WmoTroMIku0e3KhDuJOI8Lg12rRL00Rbz08W4xdS36I5+4jvYx9oPJ+Uir3tUn
 WjBQ==
X-Gm-Message-State: AJcUukf1UaKa8DN+LiQ+01euU2j3AqZPP+gReHDK8/bNR0AoY8op4Iq7
 baxq6EX/LAcaA6ADK/4GqApcog==
X-Google-Smtp-Source: ALg8bN76Wn8Vgabx37ADgUui3PsM0noe7hmywu9sTl0n62n1wnuuTHS+135o/LNMn4B6l/zUm4HFMg==
X-Received: by 2002:a9d:7685:: with SMTP id j5mr6501221otl.150.1548387776388; 
 Thu, 24 Jan 2019 19:42:56 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id m131sm878606oia.6.2019.01.24.19.42.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 19:42:55 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT Fixes for 5.0-rc3
Date: Thu, 24 Jan 2019 21:42:50 -0600
Message-Id: <1548387770-11404-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_194258_762524_44040D3F 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-5.0-rc3

for you to fetch changes up to 2a81efb0de0e33f2d2c83154af0bd3ce389b3269:

  arm64: dts: add msm8996 compatible to gicv3 (2019-01-24 21:16:16 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Fixes for 5.0-rc3

* Fix irq controller compatible for the MSM8996 platforms

----------------------------------------------------------------
Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
