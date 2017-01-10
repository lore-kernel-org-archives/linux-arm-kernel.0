From: labbott@redhat.com (Laura Abbott)
Date: Mon,  9 Jan 2017 17:18:31 -0800
Subject: [PATCHv3 0/2] Memblock cleanup plus memory removal fix
Message-ID: <1484011113-8223-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of the series ot make sanity_check_meminfo (renamed in this series)
more readable and less error prone and fix an existing bug. This is just typo
and style fixes from v2.

Russell, if I don't hear any objections in a few days I am going to put this in
the patch tracker.

As a reminder, of the motivation fot this series, during the course of
https://marc.info/?l=linux-arm-kernel&m=148145259511248, Grygorii Strashko
reminded me of another issue where I proposed a patch but never followed up on
it. The patch in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296978.html
did some cleanup and renaming of sanity_check_meminfo. I think this makes the
code more readable so I'd like to resurect it and rebase my fix
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474060.html
on top of it.


Laura Abbott (2):
  arm: Cleanup sanity_check_meminfo
  arm: Adjust memory boundaries after reservations

 arch/arm/kernel/setup.c | 10 +++++--
 arch/arm/mm/mmu.c       | 69 +++++++++++++++++++------------------------------
 arch/arm/mm/nommu.c     |  8 +++---
 3 files changed, 39 insertions(+), 48 deletions(-)

-- 
2.7.4
