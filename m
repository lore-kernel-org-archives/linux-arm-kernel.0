From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 Nov 2012 10:48:45 +0200
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <1699753.ZQsWMHINxd@percival>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <4316169.5QXVzv7peZ@percival> <50AC8D3B.6040300@ti.com>
 <1699753.ZQsWMHINxd@percival>
Message-ID: <50AC956D.7020303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-21 10:32, Alex Courbot wrote:

>> Ok. I'll need to dig up the conversation
> 
> IIRC it was somewhere around here:
> 
> https://lkml.org/lkml/2012/9/7/662
> 
> See the parent messages too.

Thanks.

>> Did you consider any examples
>> of how some driver could handle the error cases?
> 
> For all the (limited) use cases I considered, playing the power-off sequence 
> when power-on fails just works. If power-off also fails you are potentially in 
> more trouble though. Maybe we could have another "run" function that does not 
> stop on errors for handling such cases where you want to "stop everything you 
> can".

If the power-off sequence disables a regulator that was supposed to be
enabled by the power-on sequence (but wasn't enabled because of an
error), the regulator_disable is still called when the driver runs the
power-off sequence, isn't it? Regulator enables and disables are ref
counted, and the enables should match the disables.

> Failures might be better handled if sequences have some "recovery policy" 
> about what to do when they fail, as mentioned in the link above. As you 
> pointed out, the driver might not always know enough about the resources 
> involved to do the right thing.

Yes, I think such recovery policy would be needed.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/80b35acd/attachment.sig>
