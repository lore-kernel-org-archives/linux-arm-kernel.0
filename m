From: fkan@apm.com (Feng Kan)
Date: Wed, 23 Sep 2015 11:55:37 -0700
Subject: [PATCH V5 0/2] copy to/in/from user optimization
Message-ID: <1443034539-1848-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This coverts all copy in/from/to user file to use the copy template file.
The copy template file is based on the memcpy.S. The first patch converts
the memcpy to use the copy template as well. Overnight trinity test and
10G iperf was used to test correctness and performance. Noticeable
iperf improvement (~30%) on the receive side.

V5 Changes:
   1. Switch patch ordering.
   2. Simplify assembly code and use fixed large tags in marco
   3. Fixed indentation issue.

Feng Kan (2):
  arm64: Change memcpy in kernel to use the copy template file
  arm64: copy_to-from-in_user optimization using copy template

 arch/arm64/lib/copy_from_user.S |  78 +++++++++-------
 arch/arm64/lib/copy_in_user.S   |  67 ++++++++------
 arch/arm64/lib/copy_template.S  | 195 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/lib/copy_to_user.S   |  67 ++++++++------
 arch/arm64/lib/memcpy.S         | 179 ++++++------------------------------
 5 files changed, 341 insertions(+), 245 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template.S

-- 
1.9.1
