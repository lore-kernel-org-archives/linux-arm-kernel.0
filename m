From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jul 2013 10:08:42 +0200
Subject: [PATCH 2/3] Added support for On Chip OTP in i.MX23/28
In-Reply-To: <1372855154-8422-3-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1372855154-8422-3-git-send-email-cb@sgoc.de>
Message-ID: <20130705080842.GG2959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Wed, Jul 03, 2013 at 02:39:13PM +0200, Christoph G. Baumann wrote:
> From: "Christoph G. Baumann" <cb@sgoc.de>
> 
> Signed-off-by: Christoph G. Baumann <cb@sgoc.de>
> ---
>  arch/arm/mach-mxs/include/mach/mx23-ocotp.h |  311 +++++++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/mx28-ocotp.h |  239 ++++++++++++++++++++
>  2 files changed, 550 insertions(+)
>  create mode 100644 arch/arm/mach-mxs/include/mach/mx23-ocotp.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/mx28-ocotp.h

Ah. Here are your includes.

Two things then:
  - Like I said in my previous mail, the include/mach doesn't play well
    with the multi-platform kernels. How should you choose one header
    instead of another in this case, or even one mach/ directory or
    another if you have several platforms enabled.
  - From what I can recall, the OCOTP is only something like a few MMIO
    bytes to access, with a bit of logic when writing, but nothing more
    than a few registers and a few bits in there. Are you sure you
    actually need 550 lines of define for only a dozen defines or so?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/db5ffe9a/attachment.sig>
