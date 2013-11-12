From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Nov 2013 12:43:09 -0800
Subject: [PATCH] ARM: tegra: init fuse before setting reset handler
In-Reply-To: <1384286596-13761-1-git-send-email-swarren@wwwdotorg.org>
References: <1384286596-13761-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMhRHwD669fHmzXsGsuTQV89MdLA8P+ajAuua3jbADj7qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:03 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
>
> CPU reset handler was set before fuse is initialized, but
> tegra_cpu_reset_handler_enable() uses tegra_chip_id, which is set by
> tegra_init_fuse(). This patch reorders the calls so the CPU reset
> handler code does not read an uninitialized variable.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> arm-soc, if you could apply this as a fix for 3.13, that'd be great.
> Thanks.

Done!


-Olof
