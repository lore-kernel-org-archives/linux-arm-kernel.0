From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Oct 2015 17:20:48 +0000
Subject: [PATCH 0/2] kvmtool: allow CFLAGS and LDFLAGS override
Message-ID: <1446225650-19710-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the past there have been some complaints from cross-compilation
users about missing libraries and include files. Fixing those issues
by pointing make to the proper directories via CFLAGS and LDFLAGS
proved to be complicated.
This series fixes this, so custom CFLAGS and LDFLAGS can be given on
the make command line and those will not overwrite kvmtool's vital
internal assignments.

Cheers,
Andre.

Andre Przywara (2):
  Makefile: allow overriding CFLAGS on the command line
  Makefile: consider LDFLAGS on feature tests and when linking executables

 Makefile | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

-- 
2.5.1
