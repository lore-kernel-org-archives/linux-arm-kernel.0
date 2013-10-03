From: olof@lixom.net (Olof Johansson)
Date: Thu, 3 Oct 2013 09:39:45 -0700
Subject: [PATCH] arm: Fix conversion to early_init_dt_scan() for non-DT
 platforms
In-Reply-To: <1380804633-14130-1-git-send-email-broonie@kernel.org>
References: <1380804633-14130-1-git-send-email-broonie@kernel.org>
Message-ID: <CAOesGMgJS7Ou1Y6i9O+_A-+dkHCXGaX_eDMw5zrEDi-40V0pew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 5:50 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Commit 67a964490bfd14 (arm: use early_init_dt_scan) in the OF tree in
> -next converts ARM to use early_init_dt_scan(), factoring out some common
> code. However it ignores the return value of the function meaning that on
> non-DT platforms the kernel fails to boot as it attempts to configure
> itself using DT.
>
> Fix this by adding the appropriate return value check.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Hm, I thought I had reported this to Rob and he had fixed it already.
Is a stale version of the patches in the DT tree?


-Olof
