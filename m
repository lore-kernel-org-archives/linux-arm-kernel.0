From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 May 2014 22:16:16 -0700
Subject: [PATCH] arm: edma: Fix xbar mapping
In-Reply-To: <534BED36.2060907@ti.com>
References: <alpine.DEB.2.02.1404132123100.22697@ionos.tec.linutronix.de>
 <534BED36.2060907@ti.com>
Message-ID: <CAOesGMh8xkukSsF4MSUpWcFu1YK1ipUOJWjWMXwAsy8HmZQLcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 7:14 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> + Matt with current e-mail address.
>
> On Monday 14 April 2014 02:18 AM, Thomas Gleixner wrote:
>> Subject: arm: edma: Fix xbar mapping
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Sun, 13 Apr 2014 20:44:46 +0200
>>
>> This is another great example of trainwreck engineering:
>>
>> commit 2646a0e529 (ARM: edma: Add EDMA crossbar event mux support)
>> added support for using EDMA on peripherals which have no direct EDMA
>> event mapping.
>
> I committed it, so the blame goes to me (at least in part).

Another part of the problem is that it's a feature without in-tree
users -- there's not a single DT that defines the nodes (and thus can
be used to test it). Sure, there are no strict requirements to have
all bindings implemented on a platform but it sure does help catch
problems if you can test without applying out-of-tree patches to make
a feature work.

(I just merged the pull request from Sekhar, I had missed it before.
Should make -rc6).


-Olof
