From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 18:52:23 +0000
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <20110217175156.GB31812@angua.secretlab.ca>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<20110217000923.GF2364@angua.secretlab.ca>
	<20110217092617.GB24627@n2100.arm.linux.org.uk>
	<20110217175156.GB31812@angua.secretlab.ca>
Message-ID: <20110217185223.GA30606@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 10:51:56AM -0700, Grant Likely wrote:
> As for knowing where it can relocate to, we already know (actually
> current code just makes an assumption) about how long the kernel
> proper image is and where it wants to live in the zImage's head.S.
> Assuming enough ram, if r6 reflects the size of the zImage + the size
> of the appended data then it should be good.

That isn't a valid argument.  Just because "the decompressor already
does it" does not mean that it'll work with ramdisks.  We've been
lucky so far that it has worked with the kernel - and that's exactly
what it is - luck.

It works for a 1-2MB kernel.  A 16MB ramdisk is a completely different
kettle of bytes.
