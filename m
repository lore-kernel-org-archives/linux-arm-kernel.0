From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 22:09:50 +0100
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <CAK5ve-+Pr8EDa8mfhZVbf8ADc2YDU0EyTPL3Fwwipj237tgKQg@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<20110710092426.GR4812@n2100.arm.linux.org.uk>
	<CAK5ve-+Pr8EDa8mfhZVbf8ADc2YDU0EyTPL3Fwwipj237tgKQg@mail.gmail.com>
Message-ID: <20110711210950.GE8486@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 10:36:49PM +0800, Bryan Wu wrote:
> Right, I got it. So if we are going to run a single binary for all the
> sa1100 machines, how about we check the machine in each fs_initcall
> 
> static int __init assabet_leds_init(void)
> {
>  ? ? int i;
> 
>      if (!machine_is_assabet())
>           return -ENODEV,
> 
>  ? ? for (i = 0; i < ARRAY_SIZE(assabet_leds); i++) {
>  ? ? ? ? ? ? struct assabet_led *led;

Yes, that'll do, thanks.
