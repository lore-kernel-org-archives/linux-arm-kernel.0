From: sunder.svit@gmail.com (Sundar)
Date: Sat, 12 Feb 2011 11:58:00 +0530
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Message-ID: <AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 12, 2011 at 2:49 AM, Meador Inge <meador_inge@mentor.com> wrote:
>
> ? ?1. Hardware specific bits somewhere under '.../arch/*'. ?Drivers
> ? ? ? for the MPIC message registers on Power and OMAP4 mailboxes, for
> ? ? ? example.

Yes; this can help.

> ? ?2. A higher level driver under '.../drivers/mailbox/*'. ?That the
> ? ? ? pieces in (1) would register with. ?This piece would expose the
> ? ? ? main kernel API.

A lot of mailboxes are too platform specific with regards to the communication
with the main CPU and probably it depends on the mailbox too; you can
find polling and
interrupt supported mailbox support at times on the same platform.
APIs should probably be
generic enough to be able to operate in any context.

> Now I have the following questions:
>
> ? ?1. Do others see value in this?

At least I would like this; I wanted to generalize such mailbox IPCs
right from the
day when I was working on one, but coudnt really work on that.

> ? ?2. Does something like this already exist?

Not generic as you say; but apart from the OMAP platforms,
you could refer to arch/arm/mach-ux500/prcmu for a mailbox based
IPC on the U8500 platform.

> ? ?3. Is someone else already working on this?

Not sure of that too :), but I am CCing Linus W, the maintainer
of U8500 if he thinks it is a good idea to come up with a mailbox IPC
framework

Cheers!
-- 
---------
The views expressed in this email are personal and do not necessarily
echo my employers.
