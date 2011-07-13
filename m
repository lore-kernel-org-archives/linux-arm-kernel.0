From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:49 +0100
Subject: [PATCH 0/24] ARM: kprobes: Migrate ARM instruction decoding to data
	tables
Message-ID: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series migrates kprobes' ARM instruction decoding to use the
table driven methods introduced by the Thumb-2 support changes. It also
requires rewriting the instruction emulation routines to make them
compatible with this.

This saves 2kB of space in the kernel binary and reduces the source code
by 500 lines.

 arch/arm/kernel/kprobes-arm.c    | 1914 ++++++++++++++------------------------
 arch/arm/kernel/kprobes-common.c |   15 +
 arch/arm/kernel/kprobes.h        |   28 +
 3 files changed, 744 insertions(+), 1213 deletions(-)
