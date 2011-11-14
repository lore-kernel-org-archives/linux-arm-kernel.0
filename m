From: robherring2@gmail.com (Rob Herring)
Date: Mon, 14 Nov 2011 12:05:54 -0600
Subject: [PATCH 2/2] ARM: topdown mmap support
In-Reply-To: <alpine.LFD.2.02.1111141237080.3307@xanadu.home>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <1320709421-14469-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141237080.3307@xanadu.home>
Message-ID: <4EC15882.7070909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2011 11:41 AM, Nicolas Pitre wrote:
> On Mon, 7 Nov 2011, Rob Herring wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Similar to other architectures, this adds topdown mmap support in user
>> process address space allocation policy. This allows mmap sizes greater
>> than 2GB. This support is largely copied from MIPS and the generic
>> implementations.
>>
>> The address space randomization is moved into arch_pick_mmap_layout.
> 
> This is a problem by effectively weakening the randomization greatly.  
> Now you get a random starting point but all mmaps are otherwise fixed 
> relative to each other, whereas you had random distances between each 
> mmaps before.
> 

You mean within a single process the mmap's are not randomized? Couldn't
that end up wasting a lot of virtual space if you have a lot of mmaps?

It is aligned with other arch's and the generic implementation. The
generic implementation doesn't even do randomization for legacy layouts.

Rob
