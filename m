From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2012 08:13:49 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F729B99.4020909@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203271359.16553.arnd@arndb.de> <4F729B99.4020909@st.com>
Message-ID: <201203280813.49760.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 March 2012, Viresh Kumar wrote:
> 
> On 3/27/2012 7:29 PM, Arnd Bergmann wrote:
> > That would be even better. I think we should generally try do initialization
> > as late as possible, ideally from initcalls. The init_early() function should
> > only be used for code that absolutely has to be run from setup_arch() and
> > no later, while the map_io() function should ideally only be used to set up
> > the static mappings and nothing else.
> 
> I remember now why we do it in map_io().
> Timers need clock support and they are up before machine_init() is called.

I don't know what others do to get around this, this must be a fairly
common dependency, but there is no need to worry about it now. It might
all change if you device to port it to the common clk infrastructure.
 
> So, i believe i must have DT_MACHINE_START per SoC.

Ok.

> I will post V2 for 3xx DT support today, but can i have initial level of review
> from you, so that i can fixup minor issues in V2 only?

That's ok, yes.

	arnd
