From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 12:41:09 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111202182054.GA3250@arm.com>
References: <20111202182054.GA3250@arm.com>
Message-ID: <20111206124109.GT14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 06:20:54PM +0000, Catalin Marinas wrote:
> Hi Russell,
> 
> If there are no further comments, could you please pull the ARM LPAE
> branch below? They should be merged after Will's idmap patches (no real
> conflict, just correctly functioning setup_mm_for_reboot).

Err, your tree contains a serious error.

tree bb5f2f68dd26a97343d255bb0b66f327cece91a5
parent b4521e369180054ddaacecbe83eadac8878f3501
author Russell King <rmk+kernel@arm.linux.org.uk> 1321983028 +0000
committer Catalin Marinas <catalin.marinas@arm.com> 1322842272 +0000

ARM: pgtable: switch to use pgtable-nopud.h

Nick Piggin noted upon introducing 4level-fixup.h:

| Add a temporary "fallback" header so architectures can run with
| the 4level pagetables patch without modification. All architectures
| should be converted to use the folding headers (include/asm-generic/
| pgtable-nop?d.h) as soon as possible, and the fallback header removed.

This makes ARM compliant with this statement.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

If you commit a patch into a git tree, _you_ are supposed to _always_
add your own sign-off line to it unless it's already there.

Because of this, I'm going to _have_ to throw out the merge of this from
the devel-stable branch (sorry folks) because it's not compliant with the
DCO standards required.
