Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6514C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:47:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976BF207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mCOwRZvX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/o4V6dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976BF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=A/GTUL6SKXJqzx8XK5XWni7NPYUGvk7mFPGfYjVfPY8=; b=mCO
	wRZvXWJAEfOhUfT4bTo2rV5zf5nyY9E1jkTLAprX5+gY9YpfGPLtia0wXYHdNQ8J8ve5v0XvIWQaN
	jsUjcIEIpihn2LOcf5tupI0+3uJPF/jCoIzbdvWiK9tcFSGN7WKxbwIM4o9xmR1JT9H90kpYar6Lk
	d1rQVzwNZ94wo3LJIvQcXtoI01QwXSLmLeH2K55TVCgyrYUsNzWiJYl+NqVpSwwoCvLGVrLQxD18B
	2yX1XNtkXiBt1O39zVOPixMcwQfjscNFbJ1XLo14EgjYCORNkvCCcXCGMIjsBuvWgwdV2PB5hnztO
	VkS7CvJo5rrbMNJtY/xmjmqrlsN9axA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBAb-0004EN-GQ; Fri, 22 Feb 2019 13:47:17 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBAX-0004A4-UD; Fri, 22 Feb 2019 13:47:15 +0000
Received: by mail-ua1-x943.google.com with SMTP id z24so1951833ual.8;
 Fri, 22 Feb 2019 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=aPDUL23UbS//3iJMmULFAIatEpA4+JfxwfASuQY5x2M=;
 b=R/o4V6dOWF7U9/SRWhJCfyUMQD5INNHT07TY/7jtJNMUJp7Yamg4QT+zsuNPiw+wRf
 icVyH1l18lum87NFuWR+NTwHmQWvLHrjW/oI8K7lKlbBJ0OaFZIBqrOrbd/Depq6LFJm
 bi0RgJyRL3ZlbiDGu3ZPmvxUvozZWyJD4g84AMWOQGaV1MwGuPEcqSiBVPmX/z/IK+/v
 s9SRjCI/7CQaP6m2mINzLN1cCj0qI8NVBFuS7J1/1C1URUqCMKVZdythMzCYZ1+oM3GD
 VybPLISdL02v2/r5tGo2fKYF2gP7jtzFvoMLKAanrruVFdUTUJEmyVUSG3jdGpRqV1ZU
 57vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=aPDUL23UbS//3iJMmULFAIatEpA4+JfxwfASuQY5x2M=;
 b=YGW5eFz6Bw2czHyLxNBQUrMCGZ08VV7S6D/hg8HrWduDOZN9ra3l8Z/nrllwu6M7fE
 SuX0wtHErD16rcPLJMZgXHAp5nVytnNZNagTKsnvLpiWthjG5CWg9CECQSjFQyyaAXD6
 lacpLWws5poPepqZl9AScOIHwbf7cBuQn2AFb0YcGEH5xYZ1gNOjBajDflqY3PmuPX39
 dYaxLDaKg4BWOooGveggkYjubt1UJyc0qJCnkHEZM2epiqTWtoy8g0nHN8gvSZj8eHyI
 vwkcOP69X/rhF83btSw/GgtkKojzZbRI77BMPs+Gm6POodmCTnZvMuBJhx/2H8vrVMeV
 S+Fw==
X-Gm-Message-State: AHQUAuY1ix10I8dgoiZOipLjwiZPxC+2Y4BigHRpTtK634Ipfqb72LVe
 NC6DVlmuwa4DuQWP/e+OYq6whyh30tsiEOuT+hU=
X-Google-Smtp-Source: AHgI3IaClSMENoIJy7f7CljnlX/Pq5hck0APCEuxnytYmqKU2FrD/O7lBl+jSgx68wZNZiVCVY2mq4mcM0oxvKbbBC4=
X-Received: by 2002:a67:6887:: with SMTP id d129mr2231318vsc.144.1550843232002; 
 Fri, 22 Feb 2019 05:47:12 -0800 (PST)
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 22 Feb 2019 19:17:00 +0530
Message-ID: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
Subject: arm64 Kernel build for qemu-system-aarch64 ?
To: open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, kernelnewbies@kernelnewbies.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_054714_019567_09157195 
X-CRM114-Status: UNSURE (   7.21  )
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

Hi All,

I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
I see that there is a defconfig available in arch/arm64/configs/defconfig
But I am not sure whether it will work for qemu-arm64, and by default
which machine type is supported.

I already have working setup for qemu-arm for both versatile and
vexpress machine. There is already a defconfig available for these
under arch/arm.
So I can build the kernel for it.

But, whether these defconfig are supported for arm64 ?
If anybody have setup for qemu-arm64 kernel, please share the steps.
About rootfs, I am planning to use the arm32 version of busybox itself.


Thanks,
Pintu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
