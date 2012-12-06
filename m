From: yasushi.asano@jp.fujitsu.com (Asano, Yasushi)
Date: Thu, 6 Dec 2012 12:44:48 +0000
Subject: About the workaround for the 484863 L220 erratum
In-Reply-To: <CAHkRjk7+EgN67VoJaS2e+PryJy-hyOx4-RJASzkLcaEidSLGxA@mail.gmail.com>
References: <4AE7B88EC8BA74469869BB7EEB7D66671BCA3685@g01jpexmbyt23>
 <20121204132950.GO23368@mudshark.cambridge.arm.com>
 <CAHkRjk7+EgN67VoJaS2e+PryJy-hyOx4-RJASzkLcaEidSLGxA@mail.gmail.com>
Message-ID: <4AE7B88EC8BA74469869BB7EEB7D66671BCA7C88@g01jpexmbyt23>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 4 December 2012 13:29, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Dec 04, 2012 at 12:57:57PM +0000, Asano, Yasushi wrote:
> >> I am looking for a workaround for the 484863 L220 erratum.
> >> "484863: The Cache Sync operation does not guarantee that the Eviction
> Buffer is empty"
> >>
> >> Then I found a patch as below.
> >>
> http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=6
> 1
> >> f0ab1658f41f34c1910848063c565095a47864
> ...
> >> Could you please tell me if you know the reason why it does not get
> into the mainline.
> >
> > Probably because, looking at the patch in question, it uses a swp
> > instruction in the kernel which could be fatal if we have swp
> > emulation enabled (we only emulate for user mode).
> 
> Another reason I remember is that swp on that register caused hardware
> deadlocks on some platforms. So the workaround is highly dependent on
> the L2 wiring.
> 
> --
> Catalin

Thank you so much for your prompt reply, Will and Catalin.
I understood using a swp instruction is not stable for some platforms.
That is the reason why it has not been merged into the mainline.
However, I would like to know how to avoid this erratum.
Could you please tell me if you know about another workaround.
