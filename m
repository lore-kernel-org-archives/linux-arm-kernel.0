From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 May 2014 13:51:40 -0600
Subject: [PATCH v3 4/9] of: mtd: add documentation for the ONFI NAND
 timing mode property
In-Reply-To: <537BAD59.3060902@free-electrons.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
 <20140520182542.GS28907@ld-irv-0074>
 <537BAD59.3060902@free-electrons.com>
Message-ID: <20140520195140.GA32287@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 09:30:33PM +0200, Boris BREZILLON wrote:

> AFAICT nothing, but the same goes for the ECC requirements, and we've
> recently added DT bindings to define these requirements.
> I'm not telling we should drop these ECC requirements bindings (actually
> I'm using them :-)), but what's different with the timings requirements ?

ECC requirements are almost always something that has to be matched to
the bootloader (since the bootloader typicaly reads the NAND to boot),
so it is sensible to put that in the DT

The timings are a property of the chip, and if they can be detected
they should be. IMHO, the main purpose of a DT property would be to
lower the speed if, for some reason, the board cannot support the
device's full speed.

> Indeed, I based it on the ONFI NAND timings mode model, but AFAIK
> (tell me if I'm wrong), it should work because most of the timings
> are min requirements.  This means, even if you provide slower
> signals transitions, the NAND will work as expected.

IIRC for ONFI a device must always work in the mode 0 timings, without
requiring a command?

Jason
