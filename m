From: agraf@suse.de (Alexander Graf)
Date: Thu, 15 Nov 2018 10:46:43 +0100
Subject: [PATCH] arm64: Make kpti command line options x86 compatible
In-Reply-To: <20181115094116.GA18154@infradead.org>
References: <20181113152046.22389-1-agraf@suse.de>
 <20181115094116.GA18154@infradead.org>
Message-ID: <7af8ab89-6c55-3e54-e81c-4b5397cf0904@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15.11.18 10:41, Christoph Hellwig wrote:
> On Tue, Nov 13, 2018 at 04:20:46PM +0100, Alexander Graf wrote:
>> I've already stumbled over 2 cases where people got confused about how to
>> disable kpti on AArch64. In both cases, they used existing x86_64 options
>> and just applied that to an AArch64 system, expecting it to work.
>>
>> I think it makes a lot of sense to have compatible kernel command line
>> parameters whenever we can have them be compatible.
>>
>> So this patch adds the pti= and no_pti kernel command line options, mapping
>> them into the existing kpti= command line framework. It preserves the old
>> syntax to maintain compatibility with older command lines.
>>
>> While at it, the patch also marks the respective options as dual-arch.
> 
> Thanks.  Which also brings up my old complain? that arm64 and x86 should
> use the same config option.  Bonus points for moving the parsing code
> to a common file..

Both archs handle the parameters in completely different code paths
(probably due to arch constraints), so I'm not sure how doable it would
be to combine the parsing.

I'm also quite sure that we have more parameters like this around,
especially with the other spectre mitigations. So if you see any, please
feel free to send patches like this one to at least synchronize the user
view.


Alex
