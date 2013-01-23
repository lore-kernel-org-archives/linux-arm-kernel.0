From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 09:15:37 +0000
Subject: arm: Kernel failures when several memory banks are used with
 starting address above 128MB
In-Reply-To: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
References: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
Message-ID: <20130123091537.GN23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 08:18:13PM +0100, Michal Simek wrote:
> I have a question regarding to the case where DTS specify one memory bank
> for example <0x0 0x40000000> with CONFIG_ARM_PATCH_PHYS_VIRT=y
> where the kernel can be loaded at a 16MB boundary.

That's where you're going wrong.  We assume that the kernel is loaded
within the 16MB of memory _always_.  Can't get around this on a
multiplatform kernel.
