From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 2 Aug 2013 10:59:24 +0900
Subject: [PATCH V2] ARM: allow DEBUG_UNCOMPRESS for Tegra
In-Reply-To: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
References: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAAVeFu+=sfk0zH59GFUqt58MfTZks8qWX1+wq1Rzuh7TUCr8tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 2:51 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> DEBUG_UNCOMPRESS was previously disallowed for Tegra due to tegra.S's
> use of global data that was not linked into the decompressor. Solve this
> by declaring this symbol in tegra.S when it is being built into the
> decompressor. For the kernel proper, leave the declaration in
> mach-tegra/common.c as explained in the comment.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks, I had to workaround this when debugging a kernel uncompression
issue, but have not yet found the time to craft a patch.

Alex.
