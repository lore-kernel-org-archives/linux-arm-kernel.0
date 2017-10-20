From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 23:01:52 +0200
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 9:37 PM, Li Yang <leoyang.li@nxp.com> wrote:
> Hi arm-soc maintainers,
>
> This pull request includes updates to the QMAN/BMAN drivers to make
> them work on the arm/arm64 architectures in addition to the power
> architecture and a few minor update/bug-fix to the soc/fsl drivers.
>
> We got the Reviewed-by from Catalin on the ARM architecture side.
>
> DPAA (Data Path Acceleration Architecture) is a set of hardware
> components used on some FSL/NXP QorIQ Networking SoCs, it provides the
> infrastructure to support simplified sharing of networking interfaces
> and accelerators by multiple CPU cores, and the accelerators
> themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
> infrastructural components within the DPAA framework.  They are used to
> manage queues and buffers for various I/O interfaces, hardware
> accelerators.
>
> More information can be found via link:
> http://www.nxp.com/products/microcontrollers-and-processors/power-architecture-processors/qoriq-platforms/data-path-acceleration:QORIQ_DPAA

Hi Leo,

Sorry for the long delay in processing this. I've pulled the branch into
our next/drivers branch now, after taking another look at the contents.
The code looks fine to me in this version, but I have  a couple of
comments about the submission:

- We should come to an agreement on how we do these in the future.
  Usually I expect any Freescale/NXP/ARM changes to come through the
  i.MX maintainers (Shawn and Sascha), not directly from other developers.
  There is usually some degree of coordination required between the
  SoC drivers and the DT files and platform code, so it's really best to
  have someone be aware of all the components, and I prefer to have
  a smaller number of people sending me pull requests. If you already
  talked to Shawn about it and he prefers you to send the pull request
  to us directly, that's fine too, but please at least keep him on Cc.

- You have a very nice detailed description of the contents above,
   but the signed tag only has a single line saying 'This adds the
   DPAA QBMan support for ARM SoCs and a few minor fixes/updates'.
   I decided to just take your long description as the merge commit
   since it explains the contents better. It would be good to have
   a long description like that in the tag next time to keep it in the
   git history.

        Arnd
