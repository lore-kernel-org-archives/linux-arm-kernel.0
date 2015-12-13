From: greg@kroah.com (Greg Kroah-Hartman)
Date: Sat, 12 Dec 2015 22:04:59 -0800
Subject: [PATCH 1/2] serial: amba-pl011: use cpu_relax when polling
 registers
In-Reply-To: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151213060459.GA30609@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 09:01:06AM -0600, Timur Tabi wrote:
> Busy loops that poll on a register should call cpu_relax().  On some
> architectures, it can lower CPU power consumption or yield to a
> hyperthreaded twin processor.  It also serves as a compiler barrier,
> so it can replace barrier() calls.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Doesn't apply to my tree :(
