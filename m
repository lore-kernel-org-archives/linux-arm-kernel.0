From: labbott@redhat.com (Laura Abbott)
Date: Tue,  3 Jan 2017 12:56:48 -0800
Subject: [PATCH 0/2] Memblock cleanup plus memory removal fix
Message-ID: <1483477010-18986-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

During the course of https://marc.info/?l=linux-arm-kernel&m=148145259511248,
Grygorii Strashko reminded me of another issue where I proposed a patch but
never followed up on it. The patch in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296978.html
did some cleanup and renaming of sanity_check_meminfo. I think this makes the
code more readable so I'd like to resurect it and rebase my fix
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474060.html
on top of it.

Thanks,
Laura

Laura Abbott (2):
  arm: Cleanup sanity_check_meminfo
  arm: Adjust memory boundaries after reservations

 arch/arm/kernel/setup.c | 12 ++++++++--
 arch/arm/mm/mmu.c       | 62 +++++++++++++++++--------------------------------
 arch/arm/mm/nommu.c     |  8 +++----
 3 files changed, 35 insertions(+), 47 deletions(-)

-- 
2.7.4
