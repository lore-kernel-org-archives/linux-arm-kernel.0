From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 15:48:37 +0100
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_Zhe_d-H10J8cH-fxcbusoJV8jMUW-pruXVkEKY7PnLMGFA@mail.gmail.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <4418090.U8XOXMKsEU@wuerfel>
 <CAJe_Zhe_d-H10J8cH-fxcbusoJV8jMUW-pruXVkEKY7PnLMGFA@mail.gmail.com>
Message-ID: <3593142.nVgVfPmW1o@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 20:04:21 Jassi Brar wrote:
> 
> > Using the bits of the pointer as the message instead of pointing
> > to the message feels like an abuse of the API.
> >
> I can see your POV.
> Now consider a client, like mine, that sends a u32 value as the data.
> But unlike me, the client uses the mailbox api in 'async' mode i.e,
> register a callback function, submit a 32bit message and move on. It
> is perfectly doable, but doesn't kalloc'ing a u32 for each submission,
> seem overkill?

That could easily be done by dereferencing the message data in the
function that queues the asynchronous message: instead of queuing
the pointer, you queue the data in the driver.

	Arnd
