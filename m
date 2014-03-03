From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 2 Mar 2014 17:13:00 -0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140301152756.67A02C40238@trevor.secretlab.ca>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
Message-ID: <20140303011300.GB12962@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 03:27:56PM +0000, Grant Likely wrote:
> Hi Christoffer. I've got another comment on the text, this time about the format of the ESP:
> 
> On Wed, 26 Feb 2014 10:34:54 -0800, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> [...]
> > Image format
> > ------------
> > The image format, as presented to the VM, needs to be well-defined in
> > order for prepared disk images to be bootable across various
> > virtualization implementations.
> > 
> > The raw disk format as presented to the VM must be partitioned with a
> > GUID Partition Table (GPT).  The bootable software must be placed in the
> > EFI System Partition (ESP), using the UEFI removable media path, and
> > must be an EFI application complying to the UEFI Specification 2.4
> > Revision A [6].
> > 
> > The ESP partition's GPT entry's partition type GUID must be
> > C12A7328-F81F-11D2-BA4B-00A0C93EC93B and the file system must be
> > formatted as FAT32/vfat as per Section 12.3.1.1 in [6].
> > 
> > The removable media path is \EFI\BOOT\BOOTARM.EFI for the aarch32
> > execution state and is \EFI\BOOT\BOOTAA64.EFI for the aarch64 execution
> > state.
> 
> I would also reference section 3.3 (Boot Option Variables Default Boot
> Behavior) and 3.4.1.1 (Removable Media Boot Behavior) here. It's fine to
> restate the meaning of the requirement in this spec, but the UEFI spec
> is the authoritative source. Distributed VM disk images fall under the
> same scenario as the firmware not having any valid boot variables.
> 
ack, thanks.

-Christoffer
