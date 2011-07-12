From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jul 2011 08:30:37 +0100
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <CAK5ve-LNDCN0P6L_5-L4PT11n1Tiv0qz=8=rgmv-v7WsEDotBQ@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAK5ve-+Pr8EDa8mfhZVbf8ADc2YDU0EyTPL3Fwwipj237tgKQg@mail.gmail.com>
	<20110711210950.GE8486@n2100.arm.linux.org.uk>
	<201107112352.40424.arnd@arndb.de>
	<CAK5ve-LNDCN0P6L_5-L4PT11n1Tiv0qz=8=rgmv-v7WsEDotBQ@mail.gmail.com>
Message-ID: <20110712073037.GA23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 08:31:28AM +0800, Bryan Wu wrote:
> I think this is a great idea. what about moving it to include/asm-generic/

Except, instead of:

		if (machine_is(mach)) return fn(); \

we'd need:

		if (machine_is_##mach()) return fn(); \
