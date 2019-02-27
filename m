Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2945218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WfQYCwFk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jhcloos.com header.i=@jhcloos.com header.b="NxH20gdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2945218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=jhcloos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kKDb5MI0RrOZtcdcGiVGP7T3G+9/9etDbLi8xSRBF0M=; b=WfQYCwFkSdTUsR
	5yR6kT+Uok0N31J6JnSI6LCFa7e5BFLUSR2iwkJQSwX+upC2RduwlA0s+H+0955QCf2Z9lKz9fZ4F
	cRyu9v/0ovz+g7BYVcnNNtFqJYW7x2zEsLIonQUK5Spy/B5miIiT0GFpIMROGnZh2U7Q8Nj+8/EwE
	G+/MmExdKxpLhD5s/+Q9QtWlwP91nwpBoXqzjk8WIQMVSshvQElLtu8gZjGHQyNq5DXLuWWs7Ilrx
	01K4utOwzMypSl8OQ6PRQT+bB7arkf3KK/e0p+J12+54Ji7Bc90Ju9QpQRuMiGXkIymmPv4luHWlh
	X1jg4Z7+d8FwKEbs4JSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynyz-00069r-KG; Wed, 27 Feb 2019 01:26:01 +0000
Received: from ore.jhcloos.com ([2604:2880::b24d:a297])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynyw-00069a-Fd
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:25:59 +0000
Received: by ore.jhcloos.com (Postfix, from userid 10)
 id DABB61E19D; Wed, 27 Feb 2019 01:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
 s=ore17; t=1551230749;
 bh=6FSM9OTLrSu4i3vy6WTjc+Pez3UapqXNeV0PUu1eYcw=;
 h=From:To:Subject:Date:From;
 b=NxH20gdEL/oWye7UZQ7EzqUR+7BY/lKHSXtUvub78ej+l3+0PBRbkJjRn/9FWK2em
 mJ8O5UpgfQaKfRyuPJ+aFJbLIc0f5NEe6JRd4dPX+Nlc77pf0ZkRNZq+3c463RQvOo
 5Xv3Pu5WEWLdPx9aAWfxO6uVBGR/bra0cUu/1SV/z9cqCn2FmHuyGHcIYgMznDIuie
 +iqI6WhvF11LAfd8dZ5Ep/Q4lxASDEZqJLw+mQLDKZT6Ten6/xikzG0lCt1X9rqnN2
 2n6J9RP9cojJJDlBJ7ESo4UNsbobbkA7JoNMXTZHFy+eYGBbFaPuiNbthpKK7HJBSq
 4xuxLZA2HvfkA==
Received: by carbon.jhcloos.org (Postfix, from userid 500)
 id 6BB1A24F74; Wed, 27 Feb 2019 01:25:43 +0000 (UTC)
From: James Cloos <cloos@jhcloos.com>
To: linux-arm-kernel@lists.infradead.org
Subject: db820c wifi
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEX///8ZGXBQKKnCrDQ3
 AAAAJElEQVQImWNgQAAXzwQg4SKASgAlXIEEiwsSIYBEcLaAtMEAADJnB+kKcKioAAAAAElFTkSu
 QmCC
Copyright: Copyright 2019 James Cloos
OpenPGP: 0x997A9F17ED7DAEA6;
 url=https://jhcloos.com/public_key/0x997A9F17ED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Date: Tue, 26 Feb 2019 20:25:43 -0500
Message-ID: <m3wolmdnu0.fsf@carbon.jhcloos.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_172558_546307_8BEA27D4 
X-CRM114-Status: UNSURE (   5.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Is the driver for the db820c's wireless interface upstream?

I see there was a recent patchset for its audio and video hw.

Is anything else missing from 5.0?

I recently found my db820 and was able to update its userland (I run
gentoo on it), but it still has its original kernel, which I'd like
to update.

Incidently, although I've been compiled x86(-64)? kernels for more that
a quarter centurly now, I've not done any arm(64)? kernels.

Is there anything significantly different to watch out for?

Thanks.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
