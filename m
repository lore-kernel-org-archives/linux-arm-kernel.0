From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 9 Dec 2011 14:48:48 -0500 (EST)
Subject: [RFC PATCH 1/8] ARM: Add commonly used cpuidle init code
In-Reply-To: <4EE212FF.1080202@gmail.com>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
 <4EDE2F91.5090104@gmail.com>
 <CAMXH7KFT+JP8uJwK=rzt1cjwMQMGPd-6RwPVma0ky0wSMbaz8A@mail.gmail.com>
 <4EE212FF.1080202@gmail.com>
Message-ID: <alpine.LFD.2.02.1112091434490.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Dec 2011, Rob Herring wrote:

> On 12/08/2011 03:46 PM, Rob Lee wrote:
> > to start with.  If the local_fiq_enable/disable calls can be handled
> > in a community friendly way for any architecture, then perhaps I can
> > just move the header file code to linux/include/cpuidle.h.
> 
> Maybe we should think about whether we even need to disable fiq. You
> probably don't use low latency interrupt and a high latency low power
> mode together.

Agreed.  FIQs should be invisible and normally not be interfered with by 
generic kernel code.  If some CPU specific special low power mode really 
needs FIQs to be masked out, then that should be done by the code 
dealing with that mode.  And that is valid only if you do make use of 
FIQs in the first place.


Nicolas
