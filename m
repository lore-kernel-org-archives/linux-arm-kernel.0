Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA7CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086D9222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aPfJh5ho";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IGu5/K7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086D9222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LW6m2r9z+XyqanX96xjaKtYIMQlUU2OQ4+FnZkDlRJg=; b=aPfJh5hoOu8WNO
	nAtGK/IanQfWmBT8WehVXNKMvKOet6URr0XcWmIMfk2Zv2oTD/Zn+PDQWJ+fPzIBjU3xakvI312Q0
	j28ZUXAI1u3zcas27TNiL2/6T6SNs6t5PBn021cGK/KjsINwYCn7ky4uKboPGhuKeDa+0OKXHgds2
	JbjSFBAx7GYaBf52a1VUdTvPQrw+4OqJMbwn7zV+5+kSsWDnmCVo+fY43RmhdC00W3A4Y7ZAsRVyO
	YbICDicgx2sQ2cIWHUt705r/2ookQJTm9/+MDBzxPdHbbzKUklsocJ796M8d6Ed+G0L02twG7GzUo
	UcWgH3nghlkH9bRUKoFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gumiD-0004kS-GB; Fri, 15 Feb 2019 23:16:05 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gumi6-0004iw-HR
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 23:16:02 +0000
Received: by mail-pf1-x441.google.com with SMTP id q17so5524020pfh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=a/xCWpPO4dz3VeuOc/NfK8EyXiCDOjR5lA+mhjZkfV4=;
 b=IGu5/K7tG7NeesRq1DAVK/bnQcwgiQBlaBY0fH3YdE+0oIUiza42BuiYbMqif4fnbI
 GSlCN+UjV1WUhA56a9u2AKY4IIRy+0A/EhVemyCijnOMSY6AV8C1Ou4PBRXMSUfEWJRK
 Tf2gZzKHrhHo1FdQrdpOXWglZxFM3530pfp+uyCFaKRLYwYod+3RNaGlafmJroJNvnH/
 DOpm9tkPCANp47Km3nZX0XRGdEpWVOo+4FH5s/lSqWI9IINnMn8dmExN+vjqyX+G3uWT
 r2mcp0I9WZpYncPS/SUc0ox6t+4rr395nHu2yKy48oU66p1JA9na+4Nrn1AHmcFzCXbZ
 YR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=a/xCWpPO4dz3VeuOc/NfK8EyXiCDOjR5lA+mhjZkfV4=;
 b=egnUUFeEBOjUgHE0gylzUz44IkThsV2kcw88khRtyE5YtKWWuOmp7K4PR92b6NIRj1
 xl3RX3xTMdLxqyQsY+d0OVuknIBhVDMBetThaEfGdIwJztuOAQ9TmoYkU/xc5mx0Lo2r
 WulzO9GCDOQGedIpOEYSymrtg/88GKppckKsZZEgjc2nh60/p9LxFrb4qdqgkj3t6A3D
 THUgoXMky5sCP8PCv79Gs6b9Lq4Si9/6EQm4+6RzMhoBfiBBwDOGIDcaZDL5BUUbQx7m
 NR5Amy3v9nTcGKDX2gD8l/Byi91LMmMtcvShlSRqtao+/RPNRlop1UAVUXHZTxENFd1E
 p2gw==
X-Gm-Message-State: AHQUAuaLyCVSyWFhCujrjRSVlhtZel7tqIMzbYyEPmogh7grj/HT0qYJ
 9l/l4PunnaUwHXVT5qPgLJULO+Tv4tw=
X-Google-Smtp-Source: AHgI3IZX1O7yQLtX4uzcrYuO7zkypczEXlHzmOIX5x/DBGa0Bkf1VA8/KOLURGHWNzGp83wlrlepRA==
X-Received: by 2002:a65:6210:: with SMTP id d16mr7507604pgv.34.1550272557734; 
 Fri, 15 Feb 2019 15:15:57 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:100f:5904:cb2b:8631])
 by smtp.googlemail.com with ESMTPSA id c4sm17086739pfm.151.2019.02.15.15.15.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 15:15:56 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: serial: meson_uart: Add support for kernel
 debugger
In-Reply-To: <86k1ibv74r.fsf@baylibre.com>
References: <86k1ibv74r.fsf@baylibre.com>
Date: Fri, 15 Feb 2019 15:15:56 -0800
Message-ID: <7htvh4iqxf.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_151600_108051_0B12E59A 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: Julien Masson <jmasson@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Julien Masson <jmasson@baylibre.com> writes:

> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Looks good, and very useful thanks!

I'm adding this to a testing branch which will get included into the
'integ' branch of my amlogic tree for some broader testing.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
