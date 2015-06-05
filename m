From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 5 Jun 2015 13:39:51 +0200
Subject: [PATCH/RFC 1/2] ARM: multi_v7_defconfig: Make drm support modular
In-Reply-To: <2568731.dqdEiMuDro@wuerfel>
References: <1432905926-31606-1-git-send-email-geert@linux-m68k.org>
 <2568731.dqdEiMuDro@wuerfel>
Message-ID: <20150605113949.GA26607@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 05:41:34PM +0200, Arnd Bergmann wrote:
> On Friday 29 May 2015 15:25:25 Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Make drm support modular to reduce kernel size (-620 KiB):
> > 
> >        text    data     bss     dec     hex   filename
> >     12211122 1392076  338520 13941718  d4bbd6 vmlinux.before
> >     11581470 1387196  338264 13306930  cb0c32 vmlinux.after
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Slightly controversial:
> >   - Does anyone need drm for boot testing?
> 
> Only the tegra driver is affected, so let's ask the tegra
> maintainers.

As a matter of fact I do most of the DRM testing on boot using the
built-in driver. However I can do that easily using tegra_defconfig so
I'm fine with this change.

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150605/adbb4a75/attachment.sig>
