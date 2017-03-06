From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Mar 2017 17:33:30 +0000
Subject: [PATCH 1/2] arm/kvm: survive unknown traps from guests
In-Reply-To: <20170306150803.GB1502@lvm>
References: <1487593812-9174-1-git-send-email-mark.rutland@arm.com>
 <1487593812-9174-2-git-send-email-mark.rutland@arm.com>
 <20170306150803.GB1502@lvm>
Message-ID: <20170306173330.GH18519@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 07:08:03AM -0800, Christoffer Dall wrote:
> On Mon, Feb 20, 2017 at 12:30:11PM +0000, Mark Rutland wrote:
> >  static exit_handle_fn arm_exit_handlers[] = {
> > +	[0 ... HSR_EC_MAX]	= kvm_handle_unknown_ec,
> 
> Cool stuff, didn't know you could do this in C.

Strictly speaking, it's a GCC-ism, though we use it all over the place:

[mark at leverpostej:~/src/linux]% git grep '\[.*\.\.\..*\]\s=' | wc -l
394

It may also make checkpatch a bit grumpy, though I think that's being
worked on.

> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Cheers!

I assume you or Marc will pick this up?

Thanks,
Mark.
