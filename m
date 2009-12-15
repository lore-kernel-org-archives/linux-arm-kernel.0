From: swetland@google.com (Brian Swetland)
Date: Tue, 15 Dec 2009 13:07:13 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091215204803.GA26319@shareable.org>
References: <4B1ECEEE.3000209@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<1260813293.13078.15.camel@c-dwalke-linux.qualcomm.com>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9C6@mi8nycmail19.Mi8.com>
	<20091215204803.GA26319@shareable.org>
Message-ID: <a55d774e0912151307i12777a67jabf190742be3883e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 12:48 PM, Jamie Lokier <jamie@shareable.org> wrote:
>
> Perhaps the Dream's GPIOs are similar, but with opposite polarity.
> If it also has the same transition driving spike, writing a 1->0
> transition would be bad for the hardware making the shadow variable
> even more important.

Arve will certainly step in if I'm wrong here, but I believe the issue
is that the dream CPLD GPIOs (which is what we're talking about, not
the MSM7K's onboard GPIOs which are more flexible) have no way to read
the set output state back.  So, you can't read-modify-write to change
just one of the 8 bits in a given bank.  The default mask values in
the android msm tree's trout gpio board files are based on what he
shipping HTC bootloader initializes things to.

Brian
