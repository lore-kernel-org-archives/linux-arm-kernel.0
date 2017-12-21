From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 21 Dec 2017 09:14:49 +0530
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <db12818a-509f-2b28-7df0-dd923d956057@arm.com>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
 <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
 <20171220045219.GA6416@afzalpc>
 <b0e23a0b-8488-b1bc-8afe-cd68e47b9ad6@arm.com>
 <20171220114924.GA5377@afzalpc>
 <db12818a-509f-2b28-7df0-dd923d956057@arm.com>
Message-ID: <20171221034449.GB3944@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 20, 2017 at 12:22:16PM +0000, Vladimir Murzin wrote:

> >> Additionally, patch is not about Hivec only, but VBAR as well and TBH I
> >> don't follow what is your proposal...
> > 
> > i was referring to the fact that vector remapping can't be done in
> > Cortex-R, as security extension is a requisite for this feature, which
> > Cortex-R don't have on ARMv7.
> 
> For instance, just think of ARMv7A with 1:1 MMU running in SMP...

Hmm, 3 things,
1. MMU on would not take the path being patched here
2. w/ MMU on, currently it is always Hivecs
3. w/ MMU on & 1:1 mapping & due to pt. 2 above, if there is no memory
 @0xFFFF0000, suspect things might go wrong.

afzal
