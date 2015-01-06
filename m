From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 20:21:35 +0100
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54AC0C4B.1000907@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
 <54AC0C4B.1000907@redhat.com>
Message-ID: <1596791.jNp4rCPpnN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 11:24:43 Jon Masters wrote:
> On 01/06/2015 06:20 AM, Catalin Marinas wrote:
> 
> > Now, what's preventing a vendor firmware from providing only ACPI
> > tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
> > that both DT and ACPI are supported, or at least that dts files are
> > merged in the kernel first?
> 
> I know of some (server) firmware that will only provide ACPI in the
> medium term, so this is coming.

Medium term is fine, as long as they are not expecting their hardware
to be supported by Linux before ACPI support is stable enough for
general consumption. I have no idea how long that will take, but my
guess is that we shouldn't plan on supporting ACPI-only platforms in
Linux for the next couple of years and just demand that all drivers
have DT support to let users add a valid DTB that can describe the
hardware.

That should always be possible using something like grub2 as an
intermediate that boots using the UEFI interfaces and loads the
kernel and DT from disk.

	Arnd
