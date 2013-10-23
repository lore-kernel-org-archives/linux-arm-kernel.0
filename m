From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Oct 2013 16:11:46 +0200
Subject: [RFC PATCH 00/11] Embeddable Position Independent Executable
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <CACRpkdZpAqmnS5=F9va6xWECmG85TO_Lv7Gicx5qx=m6bNgohw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 2:43 PM, Russ Dill <Russ.Dill@ti.com> wrote:

> This patch adds support for and demonstrates the usage of an embedded
> position independent executable (PIE). The goal is to allow the use of C
> code in situations where carefully written position independent assembly
> was previously required.

This is perfectly applicable to the ARM TCM memory as well.

Currently we have arch/arm/kernel/tcm.c and related extensions to
kernel/vmlinux.kds.S, which enables us to tag some certain code
to be compiled into TCM memory which we map statically to
0xfffe0000 thru 0xfffeffff, but this is a better approach, especially
nice since it is the solution to the multiplatform situation, as we
need to select to copy code into that memory only on the specific
target.

I'll try to have a deeper look at this, please keep me on CC for
this series.

Yours,
Linus Walleij
