From: joramar76@yahoo.es (=?UTF-8?B?Sm9yZ2UgQW1vcsOzcyBBcmdvcw==?=)
Date: Thu, 17 May 2012 19:24:13 +0200
Subject: A good sub-architecture to base new ports on?
In-Reply-To: <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
References: <CAB9v_DFdTkAFQWFthLncx5frJX0jed11CUoKXJDT-ac6j3hWOQ@mail.gmail.com>
 <201205161557.45362.arnd@arndb.de>
 <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
Message-ID: <4FB5343D.5090509@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey and co,

I up-ported Solos open code to Openwrt with Linux 2.6.30. I think the 
only missing module was ADSL.

Anyway, compiling was successful but I can't tell if it was functional.

Mainly 2 big issues:

  * No knowledge how to build the image (I wanted to have a self-lzma
    image in order to save room)
  * My Solos based router, Xavi 7968, is a bitchy one. I found no way to
    easily upload firmware into flash. It took me hours to make 1 trial.


I'll be glad to share the code with whoever need it and maybe we can 
take those old routers back to a better world.

Regards,
Jorge

El 17/05/2012 17:29, Alexey Zaytsev escribi?:
> On Wed, May 16, 2012 at 6:57 PM, Arnd Bergmann<arnd@arndb.de>  wrote:
>> On Wednesday 16 May 2012, Alexey Zaytsev wrote:
>>> Hey.
>>>
>>> With all the ARM tree rework, I'm wondering, what would be a good (and
>>> simple) sub-architecture on which to base new ports. The target is a
>>> somewhat dated chip used in ADSL routers, so no DT, or multiplatform.
>>> I'm looking at ixp4xx, because I'm somewhat familiar with the
>>> platform, but is it a good reference?
> Thanks for the reply.
>
>> For a new subarchitecture, using DT is required, but it should not make
>> your work harder. spear3xx/6xx is a good example of an older platform
>> that was recently converted (take the arm-soc tree as a base, it contains
>> the latest version).
> Will do. Thanks for the arm-soc pointer.
>
>> Another good one would be highbank, but that contains a lot of stuff you
>> don't need.
>>
>> ixp4xx is not very actively maintained, so I would not use that as
>> a base.
>>
>> What platform are you talking about? I know of a few people that are
>> working on getting older platforms ported to Linux, so maybe someone
>> is already working on a port.
> It's a 'Solos' soc from Connexant. They released kernel code for
> 2.6.11, and I'm up-porting it to the current kernel. I know at least
> two other people interested in the port, adding them to CC. If you
> know anyone else, it would be great to share the effort.
>

-- 
Jorge Amor?s Argos

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120517/da3d3ed1/attachment-0001.html>
