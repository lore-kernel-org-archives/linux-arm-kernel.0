Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70717C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6A72087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MqMmntHH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kpw2ZIFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6A72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WodLARRkYM4Y//M9XlXszNR8QiSqpy2r2qb7kIyFlUc=; b=MqMmntHHBF0bjS
	mn7LaLGze5EqxJ0Hmdgum4sTXDCieIpzas1/vANMzPhU5bbOzX37N1UVmyaT5GhqkSou7+fg8nL+c
	mthZr7lCiGzVPc1mYcSUDU6dcIhJXAZ7QoZG6M82tZ2IWywO5+wCDPZfhFQWPeVW8O1punPFLIbyi
	6pW6q5xRim0D7EvHIqVYf3KE7enOP0WOrpoGflFXYYLtdT+iL/4fJcNY/yV71T2JkbOHoWPXK18Pr
	G150i6/EXhjGE0JcyhIjr2uE1hbO+/v1VRctiffsnLsLhFZw6BH/vIglJI6G4/hyRcQd/L6kIQSUW
	XjzXwo2WSqy4b93fzxug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosmw-0001XB-A8; Wed, 30 Jan 2019 16:32:34 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosms-0001Wa-Vl
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:32:32 +0000
Received: by mail-ot1-x343.google.com with SMTP id s5so116298oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=P3LJhH6cgW4upA2EWRXXc/wXQNtn/k7S03s//A6su1g=;
 b=kpw2ZIFeUCBxsDcxNjhh3Hy585LqG168l0ocOK2C3yTm+7PjfjeB2Q9f8RSc2L3iLV
 6I+wP22GZsEtZQ7fFBgZfot3EC5ReLs8CDvET93xlb5LMd2dc+pa5PJVr0XcnEzpYvjB
 DBsWam1wJ5r0GHiXNttNVDJaablE5HVhUuXKQn0zso8RoQtQyqhXRSobk6gkoytWgRT2
 SeUEnTahHzJjfyV3t+Mqp8DRTIFJXt8ViDm1+g/7fkTgvxK7TFeXNHgWiMXv0YDhBChC
 sqx2pq0xKl4GMeJWMiRtAw+jwf/snlqQnOlrP3wVCq4bdTSeX+dfwUNrht7x2xAyPa1q
 Og8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=P3LJhH6cgW4upA2EWRXXc/wXQNtn/k7S03s//A6su1g=;
 b=AMnYMQmTQ2bNuMKNSGtMusKrMv66p8OzntSTnV3tSyTdYhUE/NOF+pE7XsYR8b5rXn
 N5RSi9OuofAN2YX/EpIwSOQnMdgDQlVlhOQowg1dS9gmNX4NrMSaJRm17tPnnzCUzBAQ
 aqDYQaod5P6cRptcoRw3Y1vsqziLLe5U4nUbJF9fOO637QYAwdy67rqzIEAwzA3S0sps
 NfcZvfjfJfgBwJJX9dYbJTh/sJoHTeKR8qxM79Wf+scpBO0U5k2mMyPigPcwmGK+fP99
 +hAF5J49DQJC8x8CGzob9fFhOxsr+aS/qUUdbg8IYa8bvEI8NsQuE2pF3qDE6iwPUdvm
 GqfQ==
X-Gm-Message-State: AJcUukdhKrS1i+sYMke8lQ0hpppPsY7TiR9ddvSoNatvEbvCVzFl3N/Y
 PcYzhRWtVRU7ICOsSjQCYxb1lV+3bLh2SUq4C9qwv5ZaQDzLnQ==
X-Google-Smtp-Source: ALg8bN45MHCQnyC0t7Ivu27C/GsFmiyhloUnQg4Wml8VU64GpqLrhQuMqastC/b7fXBQGxkJXTqTmdlwEcVj9i9lhCs=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr23359047otf.242.1548865946597; 
 Wed, 30 Jan 2019 08:32:26 -0800 (PST)
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Jan 2019 17:32:00 +0100
Message-ID: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
Subject: ARM64 suggestion: reduce the compat address limit (currently
 0x100000000)?
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083231_039094_EB35636C 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

At the moment, compat tasks running on ARM64 can allocate memory up to
0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
admittedly somewhat old kernel):

===========
$ cat mmap_filler.c
#include <sys/mman.h>
#include <unistd.h>
#include <err.h>
#include <stdlib.h>
#include <fcntl.h>
int main(void) {
  unsigned long size = 1UL<<31;
  while (size >= 0x1000UL) {
    void *res = mmap(NULL, size, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0);
    if (res == MAP_FAILED) size >>= 1;
  }
  int fd = open("/proc/self/maps", O_RDONLY);
  if (fd == -1) err(1, "open");
  while (1) {
    char buf[0x1000];
    ssize_t res = read(fd, buf, sizeof(buf));
    if (res == -1) err(1, "read");
    if (res == 0) _exit(0);
    ssize_t wres = write(1, buf, res);
    if (wres != res) errx(1, "write failed");
  }
}
$ arm-linux-gnueabi-gcc -static -o mmap_filler mmap_filler.c && adb
push mmap_filler /data/local/tmp/ && adb shell
/data/local/tmp/mmap_filler
mmap_filler: 1 file pushed. 16.3 MB/s (587008 bytes in 0.034s)
00008000-00010000 rw-p 00000000 00:00 0
00010000-00089000 r-xp 00000000 103:1d 2080772
  /data/local/tmp/mmap_filler
00089000-00098000 rw-p 00000000 00:00 0
00098000-0009a000 rw-p 00078000 103:1d 2080772
  /data/local/tmp/mmap_filler
0009a000-0009b000 rw-p 00000000 00:00 0
0009b000-00752000 rw-p 00000000 00:00 0                                  [heap]
00752000-00774000 rw-p 00000000 00:00 0                                  [heap]
00774000-f081b000 rw-p 00000000 00:00 0                                  [heap]
f081b000-f081c000 r--p 00000000 00:00 0                                  [vvar]
f081c000-f081e000 r-xp 00000000 00:00 0                                  [vdso]
f081e000-ff710000 rw-p 00000000 00:00 0
ff810000-ff831000 rw-p 00000000 00:00 0                                  [stack]
ff831000-ffff0000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0
  [kuserhelpers]
ffff1000-100000000 rw-p 00000000 00:00 0
===========

This means that mmap() allocations do not adhere to section 6.5.8 of
C99 ("If the
expression P points to an element of an array object and the
expression Q points to the
last element of the same array object, the pointer expression Q+1
compares greater than
P.") if you treat mmap() allocations as returning an array.

In practice, I've also seen code that does things like computing a
pointer that is out of bounds by a few bytes and then comparing it
against the end of the array; while this is UB according to C99, it
probably makes sense to try to avoid breaking such code.

X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
which I think makes more sense. Would it make sense to do something
like the following (untested)?

==============
diff --git a/arch/arm64/include/asm/processor.h
b/arch/arm64/include/asm/processor.h
index f1a7ab18faf3..a0c7eb1358dd 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -57,7 +57,7 @@
 #define TASK_SIZE_64           (UL(1) << vabits_user)

 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32           UL(0x100000000)
+#define TASK_SIZE_32           UL(0xFFFFe000)
 #define TASK_SIZE              (test_thread_flag(TIF_32BIT) ? \
                                TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)      (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
==============

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
