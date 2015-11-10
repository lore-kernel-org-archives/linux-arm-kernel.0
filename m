From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Tue, 10 Nov 2015 11:44:31 +0100
Subject: Minimal support for dm814x
In-Reply-To: <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
Message-ID: <CAALWOA9tn2FyZ8AawAxyS37N8B40eoMwz3frr7=N31UxUg8xCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2015 at 11:23, Delio Brignoli <dbrignoli@audioscience.com> wrote:
> are you aware of section 2.1.2 of ...

I am. It seems that the digital PLLs tend to produce an asymmetrical
clock in general hence you need an even postdivider to get a 50% duty
cycle. DPLL-S however already has an implicit /2 divider integrated,
and a few peripherals seem to be fine with an asymmetrical clock (e.g.
apparently the USB subsystem which is clocked by PLL_USB / 5).

In the most recent SoCs they included a "DC corrector" in some PLLs to
be able to symmetrize the clock without the need for postdivision.
