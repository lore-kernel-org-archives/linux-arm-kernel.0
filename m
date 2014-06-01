From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 01 Jun 2014 13:46:02 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5JDXVZAKQUUQ5ao1GzwhNtU-+Hs_afT0tYeaw9oUthu-A@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <4893591.dl3XO76euB@wuerfel>
 <CAHH3p5JDXVZAKQUUQ5ao1GzwhNtU-+Hs_afT0tYeaw9oUthu-A@mail.gmail.com>
Message-ID: <5174568.hMNHACE7UI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 June 2014 11:26:57 shiv prakash Agarwal wrote:
> I don't see all devices send VDMs, then why Intel I-210?

There is no obligation to do it of course.

> Also, Is it a bug in host bridge hardware or driver? If hardware, how
> can we make device not to send it?

If the hardware cannot handle them, it's a hardware bug. If the hardware
does handle them correctly but the software doesn't, that is a bug in
the bridge driver.

We have a couple of host bridge drivers that register a trap handler
and then look at the bridge registers to determine the exact cause.

Which host bridge driver do you use?

	Arnd
