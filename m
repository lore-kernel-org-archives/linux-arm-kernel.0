From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Mar 2015 20:45:08 +0100
Subject: [PATCH] ARM: sunxi: DT: Add stdout-path property
In-Reply-To: <55068E7C.4060400@redhat.com>
References: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
 <55068E7C.4060400@redhat.com>
Message-ID: <20150316194508.GB4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 09:04:12AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 15-03-15 20:47, Maxime Ripard wrote:
> >Add UART aliases and stdout-path property for all the Allwinner boards so that
> >we won't have to rely on the bootargs' console= value, while working with
> >legacy bootloaders.
> >
> >While we're at it, also remove the mentions of earlyprintk in the bootargs,
> >that will remove our default bootargs entirely, and allow the kernel to boot on
> >a system even if DEBUG_LL is configured for another system.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Erm, AFAIK stdout-path does not support aliases so you must put full paths
> in there, see:
> 
> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=f3133962f469a8b6b9ba237ba670f0ca7c88a02e

This was tested on an A31 Hummingbird, and it works just fine, so I
guess it also works with aliases ;)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150316/dcfdf528/attachment.sig>
