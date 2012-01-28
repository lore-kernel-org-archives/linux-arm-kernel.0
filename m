From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 28 Jan 2012 23:55:19 +0100
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <1327574142.2355.30.camel@hornet.cambridge.arm.com>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
Message-ID: <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, Jan 26, 2012 at 11:35 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2012-01-25 at 18:37 +0000, Nicolas Pitre wrote:
>> On Wed, 25 Jan 2012, Pawel Moll wrote:
>>
>> > Since commit 576d2f2525612ecb5af029a76f21f22a3b82563d "ARM: add
>> > generic ioremap optimization by reusing static mappings" ioremap()
>> > is trying to reuse existing, static mapping when possible.
>> >
>> > The condition checking boundaries of the requested and existing
>> > mappings didn't take in-page offset into consideration though,
>> > which lead to obscure and hard to debug problems when.
>>
>> ... when what?
>
> Apparently I was hungry and ate the second half of the sentence ;-)
>
> ... when requested mapping crosses end of the static one.
>

"ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master

Breaks booting on my custom AT91RM9200 board.
There isn't any error messages or anything that indicates what goes
wrong it just stops after; Uncompressing Linux... done, booting the
kernel.

Reverting it makes my board boot again.

regards
Joachim Eastwood
