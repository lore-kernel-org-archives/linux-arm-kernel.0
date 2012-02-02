From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 2 Feb 2012 10:43:13 -0800
Subject: [PATCH] pinctrl: pin configuration states
In-Reply-To: <CACRpkdZAofVVQ5_b_R2FUWy5AfWOge1NOuO61q7vFiLB4wUizQ@mail.gmail.com>
References: <1326725496-28928-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1780DAB15E@HQMAIL01.nvidia.com>
 <CACRpkdZAofVVQ5_b_R2FUWy5AfWOge1NOuO61q7vFiLB4wUizQ@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E124AD2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, February 01, 2012 12:29 PM:
> On Thu, Jan 19, 2012 at 8:03 PM, Stephen Warren <swarren@nvidia.com> wrote:
...
> >> + ? ? /*
> >> + ? ? ?* Make a copy of the config state array - string pointers will end up
> > ...
> >> + ? ? pinconf_states = tmp;
> >> + ? ? pinconf_states_num += num_states;
> >
> > We need to allow multiple tables to be registered, for all the same
> > reasons we do for the pinmux mapping table. This implementation only
> > keeps the most recently registered table.
> 
> ? beats me.
> 
> Please check the code for how I realloc the tmp variable (in the v2
> patch set), I cannot spot the problem. It was designed to allow exactly
> multiple calls to add tables piece by piece.

Sorry, I must have been asleep when I wrote that...

I was expecting the implementation to copy each table separately and
store them in a list (since this would allow easy dynamic removel of the
entries too), hence when I saw the assignment to a single global, I
assumed it was just over-writing it; I guess I didn't even look at the
realloc above or noticed that it was assigning "tmp" not just the caller-
supplied parameter:-(

-- 
nvpublic
