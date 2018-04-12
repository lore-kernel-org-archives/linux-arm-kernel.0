From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 12 Apr 2018 09:50:26 -0700
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180412131404.GE16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
Message-ID: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does this attached patch perhaps fix the ARM case?

It just uses FPE_FLTUNK as the default si_code for SIGFPE, which seems
sane enough. And then gets rid of FPE_FIXME, which should resolve the
nasty case.

Hmm? Entirely untested, and I didn't really look at the test-case in
question since I can't really run it anyway.

Well, I could run it all on x86-64, but it doesn't have that FPE_FIXME
case at all.

                 Linus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch.diff
Type: text/x-patch
Size: 1163 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/e30ddd2a/attachment.bin>
