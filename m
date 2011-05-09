From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 08:25:47 -0700
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <BANLkTin9-aKZjEGdBeZqDwHwADXCYERErg@mail.gmail.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0497F1B201@HQMAIL01.nvidia.com>
	<BANLkTimKU-=GXzrn8=MQn-GAmKHOvKmuNQ@mail.gmail.com>
	<20110504092219.GW2092@atomide.com>
	<BANLkTin9-aKZjEGdBeZqDwHwADXCYERErg@mail.gmail.com>
Message-ID: <20110509152547.GD11410@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Rapoport <mike.rapoport@gmail.com> [110507 12:03]:
> On Wed, May 4, 2011 at 12:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Colin Cross <ccross@google.com> [110502 14:26]:
> >> On Mon, May 2, 2011 at 1:52 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >>
> >> * Drive strength is also controlled through groups of pins, but
> >> different groups than pinmux. ?Most of the drive strength groups are
> >> collections of pad mux groups, but there are a few pins that are in
> >> the same pad mux group but a different drive strength group.
> >> * Setting a pin as a GPIO overrides its group's mux setting, except
> >> for the group's tristate. ?You must untristate the entire group to use
> >> a single pin as a GPIO.
> >> * Each group has a "safe mode", but which mux id to select to enter
> >> the safe mode is completely random.
> >
> > Just posted something in this thread regarding using standard data and
> > standard read and write functions, then allow setting platform specific
> > custom flags as needed. Care to see if that works for you too?
> 
> Tegra does not allow pin muxing on the pin by pin basis. And,
> registers that define mux config differ from those that define flags
> (pull, driver strength, safe mode etc).

Hmm well the separate config register could be added easily. But the
grouping of pins might be tricky then :)

Tony
