From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 08:46:53 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140708121252.GK21766@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140708053434.GH28931@quad.lixom.net>
 <20140708115727.GR23978@titan.lakedaemon.net>
 <20140708121252.GK21766@n2100.arm.linux.org.uk>
Message-ID: <20140708124653.GX23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 01:12:52PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 08, 2014 at 07:57:27AM -0400, Jason Cooper wrote:
> > Can you offer any suggestions as to how you would like this resolved?  I
> > thought when I voiced my opinion as above, and Russell didn't reply,
> > there was implied acknowledgement...
> 
> I didn't reply probably because I didn't see the message and/or I'm busy
> with other stuff.

Fair enough.

> I know that Sebastian asked Rabeeh on IRC yesterday whether the flash
> chip type could be used to detect the difference between the two, but
> has not yet received an answer.

Ok.

> As the two DT descriptions are mutually incompatible, there isn't much
> choice.  And (afaik) there's no choice of updating the boot loader to
> a version which can deal with DT - yes it may be u-boot, but I've no
> idea if modern u-boot works on it, and I really would not like to try.

Right, what I'm arguing for (since trimmed), is *not* bootloader
upgrades.  I think Sebastian's changes are ok because:

 - Most users have production boxes (Sebastian's patches provide their
   sane default)

 - Most users of mainline or distro kernels are appending the dtb, so
   swapping out a dtb, while not ideal, isn't earth-shattering.

The *only* failure condition I can see is what you already highlighted,
people who don't know they have an engineering sample.  Sebastian's
patches work for most people, and on the odd chance of the failure, the
user simply appends the other dtb and reboots.

Once we hear back from Rabeeh, at a minimum, we'll add a comment to the
dts file for distro maintainers and users to find.  If possible, we'll
add a hook in arch code to read from SPI and adjust the dtb accordingly.

In either case, comment or code, the dts files changed in this series
are correct and won't change.

I'm sorry to be dense, Russell, but what am I missing from your
objection?

thx,

Jason.
