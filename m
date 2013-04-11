From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 03:25:53 -0700
Subject: [GIT PULL v2] Reset controller API
In-Reply-To: <20130411102047.GA7437@quad.lixom.net>
References: <1365495574.4023.32.camel@pizza.hi.pengutronix.de>
 <20130411102047.GA7437@quad.lixom.net>
Message-ID: <CAOesGMidoasD35LL4VvCUPwTPrrRE9hxPGUVmuGQtuvH_nxs0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 3:20 AM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Apr 09, 2013 at 10:19:34AM +0200, Philipp Zabel wrote:
>> Hi Olof,
>>
>> I have added two fixes on top of the reset series at
>> git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10.
>> Could you pull them in together with the rest?
>>
>> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
>>
>>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10
>>
>> for you to fetch changes up to fbdb93ecb869f02a5f8f145fa06a0984c415a7d4:
>>
>>   Documentation: gpio-reset.txt: Fix 'initially-in-reset' example (2013-04-09 09:55:00 +0200)
>>
>> They add a simple API for devices to request being reset by separate
>> reset controller hardware and implement the reset signal device tree
>> bindings proposed by Stephen Warren.
>> The patches have been discussed on the linux-arm-kernel list under the topic
>> "Reset controller API to reset IP modules on i.MX5 and i.MX6".
>>
>> ----------------------------------------------------------------
>> Dan Carpenter (1):
>>       reset: NULL deref on allocation failure
>>
>> Fabio Estevam (1):
>>       Documentation: gpio-reset.txt: Fix 'initially-in-reset' example
>>
>> Philipp Zabel (2):
>>       reset: Add reset controller API
>>       reset: Add driver for gpio-controlled reset pins
>>
>> Stephen Warren (1):
>>       dt: describe base reset signal binding
>
> Hmm, I don't see an ack or reviewed-by on these subsystem bindings from
> neither Rob nor Grant.
>
> Since it's a brand new subsystem binding, I'd like to see them ack it
> before we pick it up.

Sigh. Ok, so I now stumbled across the Ack from Rob that you didn't
pick up. Don't do it like that again, please. If Shawn prematurely
bases his code on top of unacked patches, then that's his problem, not
yours.

The problem still remains though, since the gpio-reset binding hasn't
seen an ack on the list, as far as I can tell. And I'll have a comment
on that as well in a minute, see separate reply on that patch.


-Olof
