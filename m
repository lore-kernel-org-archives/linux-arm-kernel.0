From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 6 Apr 2013 16:40:48 -0300
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CAKGA1b=Z4M6t4BVFyfqxq=iZ6MHGbgHf5WodGbTCSaC7E_b7FA@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
 <6581638.FPkNsv6peb@flatron>
 <CALBypN4mHwWZNiAQqErh1bL1sPHNuRbO5-yxzY+R1enQqEJOSQ@mail.gmail.com>
 <CAKGA1b=Z4M6t4BVFyfqxq=iZ6MHGbgHf5WodGbTCSaC7E_b7FA@mail.gmail.com>
Message-ID: <CAOMZO5CcQgf+sTBNKhwXb8FWN3XN4f2Sgjfp5KHup6feOs4h9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Sat, Apr 6, 2013 at 4:24 PM, Matt Sealey <matt@genesi-usa.com> wrote:

> Indeed, but you can guarantee in the time it took you to do that
> someone changed a binding because the source code for the DTS, and the
> documentation for the binding, is still part of Linux and it means
> Linux "hack it in and we'll do it properly later" design methodology
> comes into play.
>
> If you have a fixed clock which cannot change, and the bare minimum
> functionality implemented is gating, you need to set this up in the
> bootloader and - at option, depending on if it's needed to boot - gate
> it. Then tell Linux there's a fixed rate clock and it can turn it on
> and off via the device tree.. that's the solution here, it's already
> written and has bindings, we don't need new ones to cover the case
> whereby someone forgot to do so.
>
> I am going to stand by my little proposal; we modify the clock
> initialization so effectively check whether the parent in the DTB is
> the same as the one in hardware, and if not then report this fact (and
> optionally set that clock's parent to the one in the DTB). This is a
> sly back-door approach in one sense, but in the future when people
> build a board, put initial revision of bootloader code on the board,
> boot a kernel with a device tree that is not describing the hardware,
> they will see warnings; "Your clock "fooclk" isn't the same as your DT
> says it is. Fix the bootloader, please."

Care to submit a patch about your proposal for the codec clock example, please?

It makes much easier to get comments/testing, etc in a real patch format.

I will be glad to test your proposal if you submit a patch for it.

Thanks,

Fabio Estevam
