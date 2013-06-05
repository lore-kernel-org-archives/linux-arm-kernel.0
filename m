From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 22:16:37 +0100
Subject: getting allwinner SoC support upstream (was Re: Uploading
 linux (3.9.4-1))
In-Reply-To: <51AFA6DD.3000202@wwwdotorg.org>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
Message-ID: <20130605211637.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:00:13PM -0600, Stephen Warren wrote:
> 2) Having U-Boot itself read a DT and configure itself, just like the
> kernel does. This is relatively new, and only supported by a few boards
> (all Tegra to some extent, and a couple each Samsung Exynos and Xilinx
> boards). I suspect/guess this is the kind of thing that Luke was
> referring to re: U-Boot fex integration.

Reading what I have of this thread, this is just another case of
$company runs of and does their own unique way of doing something,
which is in a totally different direction from that path chosen by
Linux kernel developers, and Linux kernel developers are _expected_
to roll over and accept $company's unique way of doing it.

$company could have assisted with the DT effort, helping to sort out
the common arch issues (which haven't been all that much), converting
drivers to DT and such like.  But no, instead they've gone off and
created their own thing.

I wonder how many more of these cases there needs to be before people
get the message that Linux kernel developers *do* *not* like this
behaviour, and if you do this, then chances are you're going to be
stuck with having code which isn't able to be merged into mainline.

And I don't buy the argument that we were still sorting out DT.  DT has
been well defined for many many years before we started using it on ARM.
It has been used for years on both PowerPC and Sparc architectures to
describe their hardware, and all of the DT infrastructure was already
present in the kernel.  What was left for us were:

* converting our platform-data based drivers to use data from DT.
* come up with ways of dealing with SoC issues such as clock
  representation, pin muxing and such like in DT.

But no... all that had to be created in this custom fex stuff which now
presents a barrier with getting support for something merged.

And somehow people make out that this is _our_ problem...
