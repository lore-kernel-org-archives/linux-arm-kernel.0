From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2018 18:16:44 +0200
Subject: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
In-Reply-To: <20180717125855.GA3681@infradead.org>
References: <20180713133204.3123939-1-arnd@arndb.de>
 <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
 <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
 <20180717125855.GA3681@infradead.org>
Message-ID: <CAK8P3a3suHZo25uNKnWRz3MLJOFTBRwixTfTW7fSxG2CNoU-NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 2:58 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 16, 2018 at 12:11:53PM +0200, Arnd Bergmann wrote:
>> I don't think it makes a big difference whether we change it now or later,
>> but if Christoph feels that it addresses his concern about the compat_
>> namespace being reused during the transition, doing it earlier would
>> enable us to finish the remaining syscalls.
>
> Yes, I've been looking at your new series and the reuse of compat_*
> is really confusing

Ok, let's do that then. Do you think it's sufficient to change it on top
of the existing patch series? While I can rebase everything on top of
the rename, the header file dependencies are a bit tricky and adding
a patch at the end would make it easier to ensure that I don't
introduce any bisection issues.

       Arnd
