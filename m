From: fkan@apm.com (Feng Kan)
Date: Fri, 21 Aug 2015 15:00:58 -0700
Subject: [PATCH V4 0/2] arm64: copy to/in/from user optimization
Message-ID: <1440194458-4837-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This coverts all copy in/from/to user file to use the copy template file.
The copy template file is based on the memcpy.S. The second patch converts
the memcpy to use the copy template as well. Overnight trinity test and
10G iperf was used to test correctness and performance. Noticeable
iperf improvement (~30%) on the receive side.

V4 Change:
	- base the copy template file on the existing memcpy.S
	- convert copy*.s to user copy template
	- conver the memcpy to use the copy template.

Feng Kan (2):
  arm64: copy_to-from-in_user optimization using copy template
  arm64: Change memcpy in kernel to use the copy template file

 arch/arm64/lib/copy_from_user.S |  78 +++++++++-------
 arch/arm64/lib/copy_in_user.S   |  66 ++++++++------
 arch/arm64/lib/copy_template.S  | 196 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/lib/copy_to_user.S   |  66 ++++++++------
 arch/arm64/lib/memcpy.S         | 179 ++++++------------------------------
 5 files changed, 340 insertions(+), 245 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template.S

-- 
1.9.1
