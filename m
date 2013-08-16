From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 16 Aug 2013 10:39:20 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815174307.GA17245@localhost.localdomain>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CAGsJ_4w2hOgsOB=ZYmWqm7tM+pL6=UMR1fG++A+rdAReJzFSjw@mail.gmail.com>
 <520CFBDE.4000408@wwwdotorg.org>
 <20130815174307.GA17245@localhost.localdomain>
Message-ID: <CAGsJ_4yjZQ9a+VAXk-c5DGFpz-SpGrqm=p7zfYq2C=vTCz8X+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >>
>> >> Isn't that up to the hardware?  Nothing that Linux can do about that.
>> >
>> > right. but linux need to assign interrupts to right group in GIC
>> > hardware. now it doesn't care.
>>
>> I strongly hope that whatever is the secure OS is setting up these
>> routings, and the HW prevents the non-secure OS from modifying them and
>> hence never attempts to. Otherwise, the non-secure OS is able to affect
>> the functioning of the secure OS, which seems like a bad thing.
>
> Typically, the master controls are hard-wired for Secure-only access in
> hardware: so assigning GIC interrupts to groups is something the secure
> OS/firmware has to take care of.
>
> Of course, if Linux is acting as secure OS, it might have to understand
> what controls exist and to do some of that configuration itself.

that is just what i want. linux need to realize whether it is running
in security or non-security.
for example, if one irq is assigned to security, even though users
want to get it in non-security, linux should make it fail.
linux need security/non-security realization in GIC.

>
> Cheers
> ---Dave

-barry
