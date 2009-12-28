From: swetland@google.com (Brian Swetland)
Date: Sun, 27 Dec 2009 16:46:58 -0800
Subject: tree with htc dream support
In-Reply-To: <20091227211322.GB29174@elf.ucw.cz>
References: <a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
	<1260627482.20913.7.camel@desktop>
	<d6200be20912121434x1a247837w75c518ba20fe684f@mail.gmail.com>
	<20091213212504.GD5114@elf.ucw.cz>
	<d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
	<20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
	<a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
	<20091227203704.GK11737@elf.ucw.cz>
	<20091227211322.GB29174@elf.ucw.cz>
Message-ID: <a55d774e0912271646m1b82687cy427083e64e91e323@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 1:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Switch smd code to the version in staging. Something to apply to
> dream/ tree I'd say... and yes, it still works.

Hi Pavel,

I think we might want to consider leaving at least the core smd code
under mach-msm.

To start with it's specific to the 7k/8k platform, not dream (though
that may just be a quirk of how things are named in staging).  Also
the lowest layers (proc_comm and smsm_state stuff) are required for
clock control and basic power management to work -- they're kinda
joined at the hip with the platform.  It seems weird to me to have the
necessary bits to implement clock/power/pm outside of the mach/arch
space.

The higher level stuff (qmi, rpcrouter, smdtty, etc) could easily live
elsewhere (though I'm not sure where the best space in the drivers
hierarchy for them would be).

Brian
