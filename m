From: ijc@debian.org (Ian Campbell)
Date: Tue, 02 Jun 2015 08:14:11 +0100
Subject: [PATCH 1/3] bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on
 non io-coherent platforms.
In-Reply-To: <1432802414-12355-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433229251.5748.290.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-28 at 10:40 +0200, Thomas Petazzoni wrote:
> From: Nicolas Schichan <nschichan@freebox.fr>
> 
> Commit a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O
> synchronization barriers") enabled the usage of automatic I/O
> synchronization barriers by enabling bit WIN_CTRL_SYNCBARRIER in the
> control registers of MBus windows, but on non io-coherent platforms
> (orion5x, kirkwood and dove) the WIN_CTRL_SYNCBARRIER bit in
> the window control register is either reserved (all windows except 6
> and 7) or enables read-only protection (windows 6 and 7).
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v4.0+
> Fixes: a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O synchronization barriers")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Tested-by: Ian Campbell <ijc@debian.org> (On QNAP TS-419P, it fixed SATA
reset issue)
