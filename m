From: zlim@broadcom.com (Zi Shen Lim)
Date: Mon, 12 Jan 2015 18:15:00 -0800
Subject: [PATCH boot-wrapper-aarch64 0/4] psci cleanups + simple v0.2
 implementation
Message-ID: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

The first couple patches are cleanups.

The third patch switches to using v0.2 function ID values for the
existing cpu_{on,off} implementations. This intermediate step is
arguably unnecessary given the next patch...

The fourth patch provides a simple implementation of PSCI v0.2.
The deviations from spec (primarily cpu_suspend not supported)
is noted in code comment as well as in commit log.

Please consider merging.

Thanks,
z

Zi Shen Lim (4):
  psci: use MPIDR_INVALID instead of -1
  psci: remove sentinel from id_table
  psci: use PSCI v0.2 function IDs
  psci: implement PSCI v0.2

 Makefile.am |   4 +-
 psci.S      | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 143 insertions(+), 31 deletions(-)

-- 
2.1.0
