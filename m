From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 14 Oct 2012 20:02:55 +0000
Subject: [PULL REQ] IXP4xx changes for Linux 3.7
In-Reply-To: <m3bog6m5iz.fsf@intrepid.localdomain>
References: <m3bog6m5iz.fsf@intrepid.localdomain>
Message-ID: <201210142002.55841.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 October 2012, Krzysztof Halasa wrote:
> Linus,
> 
> please pull my ARM IXP4xx changes for 3.7:
> 
> The following changes since commit 4d7127dace8cf4b05eb7c8c8531fc204fbb195f4:
> 
> "Merge branch 'for-linus' of git://git.kernel.org/.../jmorris/linux-security"
> (2012-10-13 11:29:00 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux.git next
> 
> for you to fetch changes up to b94740b3b38fd8e37fcd3bb06a18ec2796061c7d:
>   IXP4xx: use __iomem for MMIO (2012-10-13 20:37:30 +0200)
> 
> Build-tested for now. This is based on your current tree tip because it
> depends on commits following 3.6 release.

Hi Krzysztof,

as mentioned before, all arch/arm/mach-* patches should go through the
arm-soc tree or get an Ack from the arm-soc maintainers. The same thing
is true for the char-misc and the crypto trees.

Also, never rebase your tree immediately before sending a pull request.
The preferred way is to have everything based on the -rc release that
is the latest one at the time when you do your testing. If you rebase
later, you essentially have to test everything again.

Finally when sending bug fixes, please annotate any patches with
'Cc: stable at vger.kernel.org' if they address bugs that are already
present in older kernels, so that the stable and longterm maintainers
can easily backport the fixes.

Almost all of the platform patches in your tree seem to be bug fixes,
so they are still good for inclusion in v3.7 if you submit them to
arm-soc soon, but please make sure you separate bug fixes from other
changes so we can group them appropriately when forwarding them to
Linus.

Thanks,

	Arnd
