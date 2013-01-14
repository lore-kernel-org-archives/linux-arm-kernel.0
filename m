From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 10:52:37 -0700
Subject: shmobile and struct sys_timer removal conflicts
Message-ID: <50F445E5.6010203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

I notice that the following shmobile-related commits in next-20130114
add new ARM machine descriptors, but set the .timer field rather than
the new .init_time field. I believe the code in these commits won't
build in linux-next or Linux 3.9 once it's released:

a625586 ARM: mach-shmobile: kzm9g: Reference DT implementation
ac0876f ARM: shmobile: armadillo800eva: Reference DT implementation
be1fc65 ARM: shmobile: add a reference DT implementation for mackerel
66f1162 ARM: mach-shmobile: sh73a0: Minimal setup using DT

In order to solve this problem, you'll need to adjust those changes
according to:

git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git timer/cleanup

(where "adjust" is probably "rebase on top of")
