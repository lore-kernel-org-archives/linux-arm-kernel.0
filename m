From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 23 Oct 2014 09:36:35 -0300
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <20141022140847.GQ9845@lunn.ch>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155614.04d33791@free-electrons.com> <20141022140847.GQ9845@lunn.ch>
Message-ID: <5448F653.5070206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 11:08 AM, Andrew Lunn wrote:
>> You don't clearly state whether your patch series keep compatibility
>> with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
>> Z1.
> 
> Hi Thomas
> 
> That answers my question. Thanks
> 
>> I'm fine with that, but then it means we should officially declare
>> the Z1 support in mainline as dead, and get rid of the workarounds that
>> applied only to 375 Z1.
> 
> A big ACK.
> 
> How bad is it if you run these patches on a Z1? Is it worth adding a
> revision check and calling BUG()?
> 

So, I just tried this on a Z1. Here's the result:

sleep 3 -> sleeps for 6 seconds

Configuring the watchdog for 3 seconds and:

echo "barf" > /dev/watchdog -> resets after 6 seconds

So using the 25 MHz reference clock is broken on Z1, but the point at
least boots; it will "just" keep track of time wrongly.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
