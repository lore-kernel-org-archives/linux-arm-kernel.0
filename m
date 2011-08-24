From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 13:54:55 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <20110824124201.GN32688@e102144-lin.cambridge.arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<20110824123431.GH23757@pulham.picochip.com>
	<20110824124201.GN32688@e102144-lin.cambridge.arm.com>
Message-ID: <20110824125455.GI23757@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 01:42:01PM +0100, Will Deacon wrote:
> On Wed, Aug 24, 2011 at 01:34:31PM +0100, Jamie Iles wrote:
[...]
> > Note that this is a device tree enabled platform so there is no 
> > /proc/atags.  I'm happy to test any related patches on our platform, but 
> > kexec isn't something we really use.
> 
> This is almost certainly the problem as the ARM kexec code doesn't have FDT
> support afaict, so the new kernel doesn't think it has any memory. Can you
> try hardcoding a command line into the kernel image which specifies the
> memory layout?

That does the trick.  It now gets to the point where the platform code 
starts looking for platform specific parts of the device tree (which it 
can't find) so I'd call that a success.

Feel free to add a Tested-by: Jamie Iles <jamie@jamieiles.com> if you 
like!

Jamie
