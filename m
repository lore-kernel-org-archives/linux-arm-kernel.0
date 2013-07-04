From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 18:11:48 +0100
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <51D5A938.30607@gmail.com>
References: <51D5A938.30607@gmail.com>
Message-ID: <20130704171148.GJ27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 06:56:24PM +0200, Daniel Mack wrote:

> Unless I missed some recent discussion, this case is not easy to handle.
> Yes, I know that these kind of things should be handled by a
> next-generation bootloader, but in our case, we want to avoid a loader
> update of already shipped hardware by all means.

There was some discussion about appending multiple DTBs recently.  I
can't actually recall anything about it though so that's not an entirely
helpful thing...

> As a solution, I'm thinking of a small framework that could for example
> work as follows.

> a) A small mechanism allows storing multiple DTB binary files inside the
> kernel binary at compile time, and a simple function can extract them
> again by name at runtime (something like what the firmware framework
> does, but I don't know if that one can be used at such an early stage in
> the boot process).

Another way of skinning this would be for either the kernel to contain
a set of machine ID to compatible string mappings or for the device
trees for the boards to have an additional properties giving the machine
IDs that the boards match.  The kernel could then look for multiple DTBs
appended to the image and try to pick one based on ATAGs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/ecc19fcd/attachment.sig>
