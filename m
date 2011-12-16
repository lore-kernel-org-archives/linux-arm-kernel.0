From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 16 Dec 2011 20:43:22 +0530
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
Message-ID: <CAMQu2gxNvrMXYs0gPYTS3wUL=toL=ccRxso25esXwmx9j4O5fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 7:20 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>
>> [1], add static dependency
>
> Sorry for the mess, see attachment for the change.
>
Your patch is setting static dependency between ISS and l3_2.
It's not dynamic dep. Dynamic dep is managed through hardware and they
are not configurable. But with static dep. you can over-ride that behavior
as you have done.

This will impact power since l3_2 can't idle as long as iss clock
domain is active.

I need to check internal code-base but I don't remember this
issue observed so far.

Regards
Santosh
