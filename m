From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Oct 2013 00:44:44 +0200
Subject: [RFC PATCH 1/5] ARM64: allow limited use of some NEON registers
 in exceptions
In-Reply-To: <alpine.LFD.2.03.1310071759190.3023@syhkavp.arg>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381147951-7609-2-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1310071759190.3023@syhkavp.arg>
Message-ID: <CAKv+Gu9655zQpQ60nN5dJ9yxWS4tk49_e=rBOs7MgfJK_9gTog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2013 00:03, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 7 Oct 2013, Ard Biesheuvel wrote:
>
>> Stack/unstack the bottom 4 NEON registers on exception entry/exit
>> so we can use them in places where we are not allowed to sleep.
>
> If you want to use Neon in places where you're not allowed to sleep,
> this also means you are not going to be scheduled away unexpectedly.
> Why not simply save/restore those Neon regs locally instead?  Same goes
> for interrupt context.
>

Hmm, I guess it is that simple: if you are certain you will not be
interrupted between stacking and unstacking, you can basically do
whatever you like at any time.
That is quite good news, actually, if that means there is no penalty
in general for allowing NEON in atomic context in some cases.

-- 
Ard.
