From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 11:25:33 -0800
Subject: [PATCH] ARM: integrator: move syscon remap for AP PCIv3
In-Reply-To: <1357809529-3851-1-git-send-email-linus.walleij@linaro.org>
References: <1357809529-3851-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130111192533.GA1461@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:18:49AM +0100, Linus Walleij wrote:
> The Integrator/AP syscon remapping was done in the .setup()
> function rather than .preinit() which is wrong - .preinit()
> is called before .setup() and the former also use the syscon
> base and cause a crash since it was not yet remapped.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: please apply this patch directly to the fixes branch
> if there are no comments, it is a pure v3.8 regression fix for
> the -rc:s and I do not expect to send more regression fixes for
> the Integrators this cycle.

Applied to fixes.

Thanks!

-Olof
