Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E592C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D64B217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fk+rV/PS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f0j5qKOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9ys79P8QBvCBdTWc+KYbrezGvnglWhjMYpAfKNDQZQ=; b=fk+rV/PScSC8b7
	9ytY9COA/s/3xQgvPugf/lN0hKc8TImABlBf415lc4KtHUYJCPx4l8gTEio4YwnxQG+Wey6+BXlPc
	jGC/vU6guR1spGxqQgYb3M1vyMUmfnIi/AHmrG4Z09iKRDhZk1gEB8SKkswQv4G0gD8xKCQCWLXAH
	EQuiIfB+K8WlnlHouT+aPYTSxUq7t3jpiWtBqL4cCnat9yBJ5AGjdlC9bsp9PBLnAJa0BKFhzgDoh
	OJCoa3i6kXSe4f7jJBCTueDQ/w5WEqfWgHb1wIkE5nHLLGtwdEDEleNWDfg45poN/Db2I8rkOI/Mr
	HJfqofzaOd7oaR/6014w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvUSc-0001Qc-O8; Sun, 17 Feb 2019 21:58:54 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvUSZ-0001PA-4B; Sun, 17 Feb 2019 21:58:52 +0000
Received: by mail-ot1-x342.google.com with SMTP id g1so25122425otj.11;
 Sun, 17 Feb 2019 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+z25ustYKZCtg4I78gtFQsiSPOzxMV27bUHQ1lAMDcA=;
 b=f0j5qKOsTzQoDBFgbTlpC1DUQife0pLeaLElWfS/0XoK5OoHxe9a4bn/dU+ldWeffi
 zG0KpPeF1m2stiPEz63tbZoH4oU5jIOc293jIxfiDTgR0dZAEC1Li3EIj0RP+hwXEO3p
 q2ZZkpt55VxOISq4ywlgR0gOewA9EqE9Lfr2jLCyUENWdUe0H3IbrijE2GZAtc0da97o
 XOx8DaYxReeKpzvei3qhb6PZ0xApbQptZJcadWIgqTkkoYwzMCdr1sP92zURJmIBXGcY
 3MwRv1z14WmEiNJ+MUhdzzuewu1c8suuTzJumIbHN+0iN1XZys8slzndAm6tkiD89k8H
 DqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+z25ustYKZCtg4I78gtFQsiSPOzxMV27bUHQ1lAMDcA=;
 b=I/DtFDdvOF50NQoUGrOf0hOK+QQA18t92VE0mn70QwcOClLif09wVunE8yLpb8c8ub
 Z08VRS983T8GpuTemADFG/UcsUu256uBOzFepqsm8NzAQ8QNBtpDR4p4TtQkesCLQsTc
 4RJgIUGqap9D+TlBvYZVTLKH1fbBmgdoMK/vKcYKm1K4E8TmK0KJMKeM+qQJD1cUHb/D
 hhxRSOzC68VWtnh3jZeKwguFuu2xLR3SzgFEAglkEEPE28E3cqNsKlhzqaV30XDpkLeU
 f+4hT2/wq6qDvqmJskcjIQy9EoMVRxRNiuqiiWj1iuKpQqpxlLhupH9XQwDQAKyfJPxz
 IHFw==
X-Gm-Message-State: AHQUAuYbDRqXIW4m6CnFChUDGThDWFmtHau1DkN6En5kqz2XcYiM4QFQ
 FZ8OcBDK74ZdY3M1EjZdB1goE8CHIcHeQG/C8Vw=
X-Google-Smtp-Source: AHgI3IYsPb4qd04Jf23hSAfbOAJXcF+Rc500WLGUPXkcBqfrVi0dEhyAat/jWW/lvR07y2A7Kq/k948MD+n9k6wLjpo=
X-Received: by 2002:a05:6830:13cd:: with SMTP id
 e13mr5088250otq.342.1550440728865; 
 Sun, 17 Feb 2019 13:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-2-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-2-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 22:58:38 +0100
Message-ID: <CAFBinCD_n_T=Ho+yB74FW1JP8mCLj0KmHPeDFWne=yfmgd9rqg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_135851_481139_74CE6721 
X-CRM114-Status: UNSURE (   8.58  )
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
Cc: devicetree@vger.kernel.org, balbi@kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 hminas@synopsys.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family USB2 OTG PHY Bindings
nit-pick: if you want to keep "OTG" in there then please add a short
description how OTG works on this PHY.
I would describe this as: "Add the Amlogic G12A Family USB2 PHY
Bindings. The PHY works for host or peripheral modes. Configuration of
the mode is part of the USBCTRL registers which are outside of the PHY
registers."

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the patch description nit-pick addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
