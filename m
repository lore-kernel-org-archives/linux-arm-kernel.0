From: slash.tmp@free.fr (Mason)
Date: Sat, 11 Apr 2015 13:57:12 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150411073022.GJ12732@n2100.arm.linux.org.uk>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk> <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk> <5527EC90.9050900@free.fr>
 <20150410160817.GH12732@n2100.arm.linux.org.uk> <55282C1F.3000600@free.fr>
 <20150410204221.GI12732@n2100.arm.linux.org.uk> <55283F30.7030109@free.fr>
 <20150411073022.GJ12732@n2100.arm.linux.org.uk>
Message-ID: <55290C18.8070301@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2015 09:30, Russell King - ARM Linux wrote:

> On Fri, Apr 10, 2015 at 11:22:56PM +0200, Mason wrote:
>
>> It was you who wrote some time ago: "Timers are preferred
>> because of the problems with the software delay loop."
>> (My system implements DVFS.)
>>
>> It seems to me that a 90 kHz timer is still better than
>> the jiffy counter, or am I mistaken again?
> 
> Given the choice of a 90kHz timer vs using a calibrated software
> delay loop, the software delay loop wins.  I never envisioned that
> someone would be silly enough to think

I'm full of surprises.

> that a 90kHz timer would somehow be suitable to replace a software
> delay loop calibrated against a timer.

Only one message ago, you were arguing that loop-based delays
could be up to 50% inaccurate. Thus, if one wanted to spin for
500 ?s, they'd have to request 1 ms just to be sure. An 11 ?s
accuracy looks like a better deal to me, overall.

Add DVFS to the mix, and that 500 ?s loop-based delay turns into
a 50 ?s delay when the other core decides to boost the cluster
from 100 MHz to 1 GHz. And then drivers break randomly.

Regards.
