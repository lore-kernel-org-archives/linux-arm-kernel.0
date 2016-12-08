From: dhowells@redhat.com (David Howells)
Date: Thu, 08 Dec 2016 17:31:13 +0000
Subject: [PATCH 5/8] efi: Get the secure boot status [ver #5]
In-Reply-To: <20161208124236.GA8757@wunner.de>
References: <20161208124236.GA8757@wunner.de> <20161208065735.GB8549@wunner.de>
 <148111668193.23390.6340512985876251017.stgit@warthog.procyon.org.uk>
 <148111671977.23390.12452925207541146423.stgit@warthog.procyon.org.uk>
 <6009.1481184981@warthog.procyon.org.uk>
Message-ID: <14655.1481218273@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lukas Wunner <lukas@wunner.de> wrote:

> > +out_efi_err:
> > +	pr_efi_err(sys_table_arg, "Could not determine UEFI Secure Boot status.\n");
> > +	if (status == EFI_NOT_FOUND)
> > +		return efi_secureboot_mode_disabled;
> > +	return efi_secureboot_mode_unknown;
> > +}
> 
> In the out_efi_err path, the if-statement needs to come before the
> pr_efi_err() call.  Otherwise it would be a change of behaviour for
> ARM to what we have now.

As I understand it, if the BIOS is an EFI BIOS, these variables must exist -
in which case I would argue that the pr_efi_err-statement should be before the
if-statement.

David
