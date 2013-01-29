From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 19:34:09 +0800
Subject: [PATCH] ARM:common: setting saved_state to NULL after kfree
In-Reply-To: <20130129111526.GQ23505@n2100.arm.linux.org.uk>
References: <5107AE6F.3080206@asianux.com>
 <20130129111526.GQ23505@n2100.arm.linux.org.uk>
Message-ID: <5107B3B1.1030406@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?29? 19:15, Russell King - ARM Linux ??:
> On Tue, Jan 29, 2013 at 07:11:43PM +0800, Chen Gang wrote:
>> >   need set NULL before return, just like function sa1111_remove has done.
>> >   and better to use sa1111_remove directly, instead of current implementation.
> NAK.
> 
> 1. __sa1111_remove() will kfree sachip, so the value of sachip->saved_state
>    at this point is meaningless.

  yes, just like what you said. it is not a bug
    (it seems not necessary to set saved_state to NULL in sa1111_remove, either).

  I think, this patch can make the source code simpler and clearer.
  so I still suggest to apply it (although it seems a minor patch).


> 2. I don't think you tried to build with your patch in place.
> 
> 
  it is my fault, just like what you said, I did not try to build.
  and I should try now.

  thanks.

-- 
Chen Gang

Asianux Corporation
