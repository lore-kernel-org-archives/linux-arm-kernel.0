From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 13:38:27 +0100
Subject: Support for unaligned watchpoints in arm/arm64
In-Reply-To: <CAJt8pk8FBbTVMMM45SaEs86MZOp0o6xChAsMT1sO+_Xy-GENyw@mail.gmail.com>
References: <CAJt8pk8FBbTVMMM45SaEs86MZOp0o6xChAsMT1sO+_Xy-GENyw@mail.gmail.com>
Message-ID: <20160531123827.GF24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 05:04:46PM +0100, Pavel Labath wrote:
> Hello all,

Hi Pavel,

> I've been wondering if there are any plans about adding support for
> unaligned watchpoints to the kernel. It seems quite a shame that
> applications are not able not use them, even though the hardware
> should support that feature.

I'm actually coming round to the idea of ditching the perf hw_breakpoint
mechanism entirely and simply writing a ptrace back-end that can expose
the hardware features directly to userspace. The two issues with this
are:

  (1) It's a fair amount of work
  (2) We might already have users of the perf interface (including compat)

I'm really not happy with the way hw_breakpoint worked out :(

Will
