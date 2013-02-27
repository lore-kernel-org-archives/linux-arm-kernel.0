From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 20:25:19 +0000
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <20130227171410.GC22286@mudshark.cambridge.arm.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
 <512E0F79.6080301@gmail.com>
 <20130227171410.GC22286@mudshark.cambridge.arm.com>
Message-ID: <201302272025.19848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Will Deacon wrote:
> As long as we remain compatible with "linux,dummy-virt" then I'm not fussed
> what happens to the support code. I don't envisage adding anything else to
> it that can't live under drivers/ (e.g. new virtio devices).

The idea with my patch is that you don't actually have to check anything
against "linux,dummy-virt" or another top-level "compatible value.

Basically any device tree would boot as long as all device you want to
use (including timer, irqchip, smp CPU setup method, ...) can be brought
up using the DT information. The SMP stuff is the only bit missing
right now, any other field of the machine_desc structure is already
optional with my patch, and if all fields are NULL, you can leave
out the entire structure. The best part of this is that an empty
machine_desc is exactly what we have on arm64, so any machine that
is supported on arm64 could also be supported on arch/arm without
any machine specific code.

	Arnd
