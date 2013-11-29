From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 15:20:33 +0100
Subject: [PATCH V2] serial: tegra: convert to standard DMA DT bindings
In-Reply-To: <1385416270-3421-1-git-send-email-swarren@wwwdotorg.org>
References: <1385416270-3421-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129142032.GB22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 02:51:10PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> By using dma_request_slave_channel_or_err(), the DMA slave ID can be
> looked up from standard DT properties, and squirrelled away during
> channel allocation. Hence, there's no need to use a custom DT property
> to store the slave ID.
> 
> Cc: treding at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-serial at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> * Don't allocate DMA channels inside probe(); the DMA channel setup
>   relies on some buffers that don't get allocated until startup().
> 
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> 
> Greg, you'd previously ack'd this, but I had to change the patch to fix
> some bugs, which was a fair textual change, so I dropped your ack.
> ---
>  drivers/tty/serial/serial-tegra.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/23b7fd3f/attachment.sig>
