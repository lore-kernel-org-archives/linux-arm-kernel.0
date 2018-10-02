From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:59:25 +0200
Subject: [GIT PULL] i.MX fixes for 4.19, round 2
In-Reply-To: <20181001023923.GQ26692@dragon>
References: <20181001023923.GQ26692@dragon>
Message-ID: <CAK8P3a1e8+HMwsFjE5AJW1E8M309dTkXHLqQb0Dne1gO_n61vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 4:39 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit 57361846b52bc686112da6ca5368d11210796804:
>
>   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.19-2
>
> for you to fetch changes up to 4d8d4712e47c028306149bda04b79f70325aefb0:
>
>   soc: imx: gpc: set DMA mask for PD platform devices (2018-09-26 10:38:38 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.19, round 2:
>  - There appears an uninitialized DMA mask warning on i.MX GPC driver
>    with 4.19-rc kernel.  Set the DMA mask for powerdomain platform
>    device to fix the warning given by device core.

I don't think this is the right fix, we should generally not just make up a dma
mask pointer.

Lucas, do you have any more information regarding that warning?
Are we trying to do DMA on a virtual device? What operation
causes that warning?

      Arnd
