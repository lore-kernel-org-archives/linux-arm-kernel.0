From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 24 Feb 2014 13:21:58 -0800
Subject: ccf: where to put constraints?
In-Reply-To: <20140224201046.GA13155@katana>
References: <20140224201046.GA13155@katana>
Message-ID: <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, 2014-02-24 at 09:10PM +0100, Wolfram Sang wrote:
> Hi,
> 
> Where do I put constraints when using the CCF? I have a CPU and GPU
> clock derived from the same PLL. Both clocks have their own divider.
> Now, there is the additional constraint that the CPU clock must not be
> lower than the GPU clock. Do I add checks in the set_rate functions?
> Feels like the wrong layer, but not checking it and blindly relying on
> somebody else does not feel correct, too. How to do it best?

I don't know if it's the best or only way, but so far, I did things like
that with clock notifiers.

I.e. when a clock consumer needs to be notified about its input clock
being changed it registers a clock notifier. In that notifier callback
it then can react to the rate change. E.g. adjust dividers to stay
within legal limits or reject the change completely.

	S?ren
