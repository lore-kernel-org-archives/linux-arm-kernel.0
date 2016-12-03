From: ao2@ao2.it (Antonio Ospite)
Date: Sat, 3 Dec 2016 17:55:13 +0100
Subject: [PATCH] ARM: pxa: ezx: fix a910 camera data
In-Reply-To: <df32cbf6-e897-56d9-89d8-c65af06323a8@datenfreihafen.org>
References: <20161124162955.3887066-1-arnd@arndb.de>
 <e0bdf159-93f2-5ed7-1e28-7fb80707d6c7@datenfreihafen.org>
 <87eg1zqqub.fsf@belgarion.home>
 <df32cbf6-e897-56d9-89d8-c65af06323a8@datenfreihafen.org>
Message-ID: <20161203175513.499a3affbb3e4a0640997f82@ao2.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Nov 2016 00:30:52 +0100
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

> Hello.
>

Hi everyone,

> On 25.11.2016 20:53, Robert Jarzmik wrote:
> > Stefan Schmidt <stefan@datenfreihafen.org> writes:
> > 
> >> Hello.
> >>
> >> On 24.11.2016 17:29, Arnd Bergmann wrote:
> >>> The camera_supply_dummy_device definition is shared between a780 and a910,
> >>> but only provided when the first is enabled and fails to build for a
> >>> configuration with only a910:
> >>>
> >>> arch/arm/mach-pxa/ezx.c:1097:3: error: 'camera_supply_dummy_device' undeclared here (not in a function)
> >>>
> >>> This moves the definition into its own section.
> >>>
> >>> Fixes: 6c1b417adc8f ("ARM: pxa: ezx: use the new pxa_camera platform_data")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> ---
> >>>  arch/arm/mach-pxa/ezx.c | 56 ++++++++++++++++++++++++++-----------------------
> >>
> >> I wonder what we should do with ezx.c.
> >>
> >> As far as I know neither Daniel nor Harald or myself are doing anything
> >> with this devices anymore. Besides a basic compile test having an ack or
> >> reviewed by from our side is a bit worthless. :/
> >>
> >> I should still have some of these phones around in a box somewhere. If
> >> there is someone with a good motivation and time to take over on this
> >> platform we will find a way to get the person this devices.
> >>
> >> Any takers? Robert? I guess you are already overloaded but you might
> >> also have an interest. Worth asking :)
> > Oh yes, I'm very interested in your box. Besides I really like old platforms
> > :)
> 
> 
> Great! I should have at least 3 or 4 different devices from the EZX
> platform around. I will go and search for the box over the weekend :)
> 
> >> In the case nobody wants to pick up here what would you consider the
> >> bets way forward? I could send a patch removing ezx platform support
> >> from the kernel (basically ezx.c plus build support) or I can send a
> >> patch marking it at least orphan in MAINTAINERS. Let me know what you think.
> >>
> >> Daniel, Harald, if one of you is still interested in these and what to
> >> pick up the work again, please speak up now. :)
> > Unless another maintainer steps in, you can submit a patch to transfer the
> > maintainance onto me, and we'll see off mailing lists how we could arange the
> > boards transfer.
> 
> I cc'ed another developer who did a lot of work regarding EZX.
> 
> Antonio, as you can see from the mail above we are pondering what who
> will maintain the ezx platform in the kernel going forward. Neither
> Daniel, Harald or me is going to do so. If you have time, interest and
> motivation to do so please speak up. I know life moved on and you ahve
> other projects and interests so do not feel pressured here. Just say no
> if you have no interest. Robert already agreed to act as a fallback so
> we would still be safe. :)
>

I still use a Motorola A1200 with the original EZX stack as my main
phone (and that tells something about how much I use a phone...)
however I haven't touched any OpenEZX stuff in a while.

I don't think I am going to play with these devices anytime soon, but I
can provide Robert any info he may need about OpenEZX, the development
tools and the out-of-tree patches required to make the phones somewhat
usable.

I have an off-line backup of the OpenEZX wiki as well if that should be
needed.

Robert, feel free to contact me off-list any time.
I also still hang out in the #openezx IRC channel on Freenode.

Ciao ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
