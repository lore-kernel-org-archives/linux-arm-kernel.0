From: rth@twiddle.net (Richard Henderson)
Date: Wed, 27 Jun 2012 10:58:11 -0700
Subject: Detecting support for trapping floating-point exceptions on ARM
In-Reply-To: <Pine.LNX.4.64.1206121900150.1359@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1206121900150.1359@digraph.polyomino.org.uk>
Message-ID: <4FEB49B3.2030602@twiddle.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 12:11 PM, Joseph S. Myers wrote:
> ARM VFPv3 and VFPv4 do not support trapping floating-point exceptions; 
> VFPv2, VFPv3U and VFPv4U do.  The lack of support causes the glibc 
> math/test-fenv test to fail on VFPv3 and VFPv4 systems.
> 
> The natural fix for that would be for fesetenv (FE_NOMASK_ENV) to fail on 
> hardware not supporting trapping exceptions.  There is, however, no HWCAP 
> bit to indicate whether trapping floating-point exceptions is supported.  
> Could one be added to the kernel, or is there a good way fesetenv could 
> detect this from userspace without a new HWCAP bit?

I don't suppose those SBZ/RAZ bits just so happen to be ignored in
actual hardware, so that you can write 1 and read it back and get 0
to see if exceptions are unsupported?

Yes, that violates the spec as written, but if it just so happens to
work in current hardware that might be good enough convince someone
to adjust the spec to be slightly more handy.


r~
