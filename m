From: kamensky@cisco.com (Victor Kamensky)
Date: Mon,  3 Apr 2017 22:51:00 -0700
Subject: [PATCH v2] fix armv8 kernel generation of SIGSEGV upon unaligned
 access
Message-ID: <1491285061-15718-1-git-send-email-kamensky@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: reimplemented fix according to suggestion from Will [3]. Now signal number
and code are extracted from fault_info table by do_bad_area function based on
esr value.

v1: problem report and small test case are in [1], first version of fix proposed
by [2].

[1] http://archive.armlinux.org.uk/lurker/message/20170403.054513.61199c78.en.html

[2] http://archive.armlinux.org.uk/lurker/message/20170403.054514.27358df9.en.html

[3] http://archive.armlinux.org.uk/lurker/message/20170403.092431.38d44b37.en.html

Thanks,
Victor

Victor Kamensky (1):
  arm64: mm: unaligned access by user-land should be received as SIGBUS

 arch/arm64/mm/fault.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

-- 
1.9.3
