From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 16:14:41 -0800
Subject: [PATCH] ARM: dts: artpec: update clock bindings in artpec6.dtsi
In-Reply-To: <1456392854-13527-1-git-send-email-larper@axis.com>
References: <1456392854-13527-1-git-send-email-larper@axis.com>
Message-ID: <20160313001441.GD17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 10:34:14AM +0100, Lars Persson wrote:
> The clock bindings for the main clock controller was changed to an
> indexed controller style binding on request of the clk
> maintainers. This updates the dtsi to use the new bindings.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
> Note: This patch depends on a header file delivered through the clk tree in
> "clk: add device tree binding for Artpec-6 clock controller".

This is a bit painful for us. It works when we get contents sent as pull
requests, since then we can share a branch with the clk header file on it.

However, when we apply patches that's harder.

I suggest we merge this after both trees have been picked up instead. Please
resend after that if we for some reason forget.


The alternative is to just use the numerical constants now, and switch to the
symbols after the merge window (or in the next release). I'm getting tempted to
propose that solution for more and more of these in the future, since it's a
somewhat annoying dependency to have (and we often have them).

Either way, we're close to the merge window opening, so let's aim to do this
patch towards the end. Since it's a new platform, risk for regression doesn't
exist, etc.


-Olof
