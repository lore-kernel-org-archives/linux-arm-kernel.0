From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 14:07:22 +0000
Subject: [PATCH RFC] arm: Add argument to init_machine
In-Reply-To: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
References: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20101208140722.GD9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 04:42:56PM -0800, David Brown wrote:
> Some ARM SOCs are used in numerous configurations.  While much of the
> configuration is identical between these configuration, since it is
> contained within the SOC, there will often be slight differences in
> external hardware that is connected.
> 
> To reduce the number of machine_is_...() tests in the machine init
> code, pass an agrument from the machine descriptor through to the init
> function.
> 
> This adds 4-bytes to the kernel for every machine that is compiled in.
> Machines that make use of the pointer will have additional data, which
> will likely be offset by a reduction in runtime tests needed.

I guess most of the increases are within the .init sections, which get
lost because of their alignment(s).

> ---
> I wanted to see what people thought of doing this in general for ARM.
> We can get the same effect for some of our new targets by having short
> individual functions that call another function with a different
> pointer.

As far as the patch itself goes, it looks fine, but I'm not seeing
anything using this new facility in this patch.

I don't like adding things without seeing how they're going to be
used, as sometimes these things never get used.  Maybe you can give
some examples?
