From: dhowells@redhat.com (David Howells)
Date: Mon, 30 Jan 2017 14:01:32 +0000
Subject: What should the default lockdown mode be if the bootloader
 sentinel triggers sanitization?
In-Reply-To: <20170130135002.GL31613@codeblueprint.co.uk>
References: <20170130135002.GL31613@codeblueprint.co.uk>
 <20170127140101.GD31613@codeblueprint.co.uk>
 <20170123212642.GA2766@codeblueprint.co.uk>
 <20170116144954.GB27351@codeblueprint.co.uk>
 <20170111143304.GA29649@codeblueprint.co.uk>
 <148120020832.5854.5448601415491330495.stgit@warthog.procyon.org.uk>
 <148120024570.5854.10638278395097394138.stgit@warthog.procyon.org.uk>
 <7948.1484148443@warthog.procyon.org.uk>
 <794.1484581158@warthog.procyon.org.uk>
 <6306.1485209503@warthog.procyon.org.uk>
 <25118.1485778229@warthog.procyon.org.uk>
Message-ID: <12081.1485784892@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Fleming <matt@codeblueprint.co.uk> wrote:

> > Matt argues, however, that boot_params->secure_boot should be propagated from
> > the bootloader and if the bootloader wants to set it, then we should skip the
> > check in efi_main() and go with the bootloader's opinion.  This is something
> > we probably want to do with kexec() so that the lockdown state is propagated
> > there.
>  
> Actually what I was arguing for was that if the boot loader wants to
> set it and bypass the EFI boot stub, e.g. by going via the legacy
> 64-bit entry point, startup_64, then we should allow that as well as
> setting the flag in the EFI boot stub.

That brings up another question:  Should the non-EFI entry points clear the
secure_boot mode flag and set a default?

David
