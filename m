From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 30 Mar 2010 23:02:16 +0400
Subject: [PATCH v3 0/3] Support for Cavium Networks CNS3xxx machines
Message-ID: <20100330190216.GA7611@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

v3 is on the way...

Changes since v2:

- We noticed that timer2 (which was used as a clock source) causes
  nanosleep system call to misbehave. Until debugged, the timer2
  support is removed.

  It's fine since timer1 is still used as a clockevent, and provides
  all needed timekeeping functionality. With these patches we want
  a minimal (but rock solid) CNS3xxx support, all non-essential
  features can wait.

  I.e. support for the second timer can be added as a separate
  patch.

- Updated some PCIe register definitions to make PCIe integration
  more smooth.

- Updated defconfig.

Changes since v1:

- Addressed Russell's comments;
- CNS3420VB board support split into its own patch per Sergei's
  comment;
- This series no longer include AHCI and SDHCI patches. Because of
  dependencies on other trees they aren't yet suitable for inclusion,
  so no need to repost them again.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
