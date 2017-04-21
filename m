From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Apr 2017 10:30:11 +0200
Subject: linux-next: build failure after merge of the arm tree
In-Reply-To: <20170421181230.05dcf937@canb.auug.org.au>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
 <20170421181230.05dcf937@canb.auug.org.au>
Message-ID: <216e8509-e7e8-5a5c-918c-a1a6e0e5285d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2017 10:12, Stephen Rothwell wrote:

> Mason wrote:
>
>> Anyway, the fix is trivial.
>>
>> The "pchans_used" field is an unsigned long array.
>> for_each_clear_bit_from() expects an unsigned long pointer,
>> not an array address.
>>
>> I'll send a patch to the drivers/dma maintainers.
> 
> The fix really needs to go into the arm tree (as well?) since that is
> the tree that has the patch that causes the build to break (even if the
> actual bug was preexisting).

Hello Stephen,

Since it's a trivial patch, and since Vinod is on vacation
until Monday, I suppose Russell could push the patch through
his own tree? (Maybe after an ACK from a sunxi maintainer.)

I am currently building an allyesconfig next-20170420 kernel.
Considering the speed of this system, this will take a while.

Regards.
