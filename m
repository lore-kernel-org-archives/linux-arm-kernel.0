From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Nov 2015 02:11:30 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
Message-ID: <HK2PR06MB05614D47A9C35ECB4CA72D3F8A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> So I've noticed. As far as I can tell, the XIP kernel stuff broke 
>> years ago.
>
> That, of course, brings the question about keeping XIP around.

Well, as the email address suggests, I work for Renesas. And since
the ARCH_R7S72100 has up to 10MB internal RAM and can XIP directly from
QSPI Flash, that's a pretty simple BOM.

I also revisted the AXFS file system (that never made it into the
kernel) and like the kernel, required some fixing up.
However, I can get a functioning and usefull ARMv7 system up and
running in under 3MB of total system RAM.
That's got to be worth something to someone ;)


> Everything can be fixed at once with a new linker script.

I do have to agree that a separate linker script would be a cleaner
solution for the section arrangements.
Of course, there are still some other XIP patches needed (like you can't
use text areas as a temporary stack on boot), but the sections are a
pretty logical place to start.


Chris
