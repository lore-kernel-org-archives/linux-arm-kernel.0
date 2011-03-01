From: bones@secretlab.ca (John Bonesio)
Date: Mon, 28 Feb 2011 19:25:22 -0800
Subject: [PATCH 0/4] Support for device-tree appended to zImage
In-Reply-To: <20110301025836.GA3920@S2100-06.ap.freescale.net>
References: <20110228233153.24836.24176.stgit@riker>
	<20110301025836.GA3920@S2100-06.ap.freescale.net>
Message-ID: <4D6C6722.3040904@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I'm using Grant's tree with Nicolas Pitre's patch to the compressed
image wrapper. His patches went out to the ARM list and I'm told they
were accepted. These patches may not yet be in Grant's tree. These
patches are titled:

[PATCH 1/2] ARM: improvements to compressed/head.S
[PATCH 2/2] ARM: remove the 4x expansion presumption while decompressing
the kernel

Grant, is there a branch in your tree that people should be using, or
should be they applying both sets of patches?

- John

On 02/28/2011 06:58 PM, Shawn Guo wrote:
> Hi John,
> 
> On Mon, Feb 28, 2011 at 03:33:18PM -0800, John Bonesio wrote:
>> The following series support for device tree binary blobs (dtb) that are
>> appended to the compressed kernel image (zImage).
>>
>> Having appended dtb data is not required to boot with a device tree. If no dtb
>> data is appended to zImage, the kernel will boot using prior methods.
>>
>> ---
>>
>> John Bonesio (4):
>>       ARM:boot:device tree: Allow the device tree binary to be appended to zImage
>>       ARM:boot:device tree: Merge specific atags into the device tree
>>       ARM:boot:device tree: Add puthex routine for use in the boot wrapper
>>       ARM:boot:device tree: Allow multiple device trees to be appended to zImage
>>
>>
>>  arch/arm/Kconfig                  |    7 ++
>>  arch/arm/boot/compressed/Makefile |   31 +++++++-
>>  arch/arm/boot/compressed/atags.c  |   70 +++++++++++++++++++
>>  arch/arm/boot/compressed/head.S   |  136 +++++++++++++++++++++++++++++++++++--
>>  arch/arm/boot/compressed/misc.c   |  134 ++++++++++++++++++++++++++++++++++++
>>  5 files changed, 365 insertions(+), 13 deletions(-)
>>  create mode 100644 arch/arm/boot/compressed/atags.c
>>
> I'm trying to test and use it.  But it does not apply against any tree
> that I can find, neither mainline nor Grant's tree.  Need rebasing?
> 
