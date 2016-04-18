From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 18 Apr 2016 18:44:48 +0200
Subject: [PATCH 3/5] clocksource/drivers/mtk_timer: add __init attribute
In-Reply-To: <1460991338-9845-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1460991338-9845-1-git-send-email-Julia.Lawall@lip6.fr>
 <1460991338-9845-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160418164448.GB2820@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 04:55:36PM +0200, Julia Lawall wrote:
> Add __init attribute on a function that is only called from other __init
> functions and that is not inlined, at least with gcc version 4.8.4 on an
> x86 machine with allyesconfig.  Currently, the function is put in the
> .text.unlikely segment.  Declaring it as __init will cause it to be put in
> the .init.text and to disappear after initialization.
> 
> The result of objdump -x on the function before the change is as follows:
> 
> 0000000000000000 l     F .text.unlikely 000000000000006f mtk_timer_setup.isra.4
> 
> And after the change it is as follows:
> 
> 0000000000000000 l     F .init.text	000000000000006a mtk_timer_setup.isra.4
> 
> Done with the help of Coccinelle.  The semantic patch checks for local
> static non-init functions that are called from an __init function and are
> not called from any other function.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> ---

Applied for 4.7.

Thanks !

  -- Daniel
