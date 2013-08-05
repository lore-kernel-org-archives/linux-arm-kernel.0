From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 11:37:15 +0100
Subject: [PATCH] ARM: fix is_gate_vma() when CONFIG_KUSER_HELPERS is
 enabled
In-Reply-To: <1375698743-2738-1-git-send-email-marc.zyngier@arm.com>
References: <1375698743-2738-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130805103715.GR23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 11:32:23AM +0100, Marc Zyngier wrote:
> Commit a5463cd34354 (ARM: make vectors page inaccessible from
> userspace) introduced the is_gate_vma() facility to identify the
> vectors page, but a typo broke the /proc/<pid>/maps output:

Known about, and between myself and Linus we elected not to fix it for
rc4.  You're not the first to report it, and it will get fixed, just
not as a high priority.
