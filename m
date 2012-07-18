From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jul 2012 22:41:29 -0700
Subject: [PULL] [PATCH 0/4] arm: at91: gpio fix
In-Reply-To: <20120718052344.GB2629@game.jcrosoft.org>
References: <20120715131618.GF4450@game.jcrosoft.org>
 <CAOesGMgXAADDqAL5EvSdfaO0GzZJT0_a7-eNRPTJA73zYN-TEg@mail.gmail.com>
 <20120718052344.GB2629@game.jcrosoft.org>
Message-ID: <CAOesGMhieXmf-WvS0eRLJ9UN2Z63xNr4mOKY2QdPLRvm-zoXDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 10:23 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 20:54 Tue 17 Jul     , Olof Johansson wrote:
>> Hi Jean-Christophe,
>>
>> Comments below. As I mentioned in the SPEAr pull request just now, we
>> are very close to final 3.5, so only fixes to bugs should go in.
>> Please help me out a bit below.
>>
>> On Sun, Jul 15, 2012 at 6:16 AM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>>
>> > Jean-Christophe PLAGNIOL-VILLARD (4):
>> >       ARM: at91: gpio: implement request
>> >       ARM: at91: gpio: implement gpio_free
>>
>> Are the two above regressions, or just general improvement? Looks like
>> the latter to me?
> On non dt I agree but on DT the gpio are not mux in the kernel.
> Today it work if the bootloader mux it as gpio so the kernel work onther wise BUG
>
> and this is the case today

Ok, thanks -- that makes sense. Care to roll those two patches into
one and document that in the commit message?

>>
>> >       at91: regroup gpio and pinctrl under a simple-bus
>>
>> This looks like a cleanup patch to me. I'm also not sure that this is
>> appropriate use of a simple-bus. The patch seems to have been posted
>> for review the same day as you sent the pull request, and not cc:d to
>> devicetree-discuss.
> forget to cc the devicetree but on at91 the pintcrl and gpio use the same
> registers so you must you the simple-bus
>
> As I've a huge patch series that I'm finishing to fix after found this bug on
> the gpio it really help to do not rebase it

Defining the same device twice to have two drivers bind to it doesn't
seem like the right solution here. That patch needs an acked-by from
Rob Herring or Grant Likely before we pick it up. Existing device
trees don't include the pinctrl nodes, so this is 3.6 material as far
as I can tell.


-Olof
