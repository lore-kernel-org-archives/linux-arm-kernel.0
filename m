From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 Mar 2016 19:14:05 +0530
Subject: [PATCH v2 03/11] ARM: davinci: da850: use clk->set_parent for
 async3
In-Reply-To: <56F2E13B.4000407@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-4-git-send-email-david@lechnology.com>
 <56F2BCAB.3040404@ti.com> <56F2D05C.8030909@lechnology.com>
 <56F2D27F.6040001@ti.com> <56F2E13B.4000407@lechnology.com>
Message-ID: <56F3EF25.4010305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 12:02 AM, David Lechner wrote:
> On 03/23/2016 12:29 PM, Sekhar Nori wrote:
>>
>> Alright, I guess 'can be called' in the comment should have used
>> stronger language :) How about late registration of USB clocks as I
>> suggested. It should also help consolidate code across da830 and da850.
>>
> 
> What about the new async3 clock? It will require later registration too,
> but it has many children that depend on it.

I guess that was the reason why it was done the way it was. Can we leave
that alone for now (not use the new set_parent interface)? You don't
really need that to be changed for USB functionality, right?

Thanks,
sekhar
