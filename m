From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 26 Jul 2017 17:18:05 +0100
Subject: "external abort on linefetch (0x814)" on Kirkwood 6282 SoC
In-Reply-To: <20170726152251.GE12049@lunn.ch>
References: <1500801941.22097.24.camel@hellion.org.uk>
 <20170726152251.GE12049@lunn.ch>
Message-ID: <1501085885.3330.24.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-07-26 at 17:22 +0200, Andrew Lunn wrote:
> I have a 6282 system i can try to reproduce this on. It will probably
> be a few days before i get around to it.

Thanks!

For some reason my original mail never made it to debian-arm or linux-
arm-kernel, suspiciously the mail which I attached _also_ doesn't
appear in the archives. I suspect something has decided (false +ve)
that it was spam or a virus or something and blocked it.

FTR below is the full text of my original mail. I'd attach boot-7.log
as well but I worry it might get nobbled again, let me know if anyone
wants it...

Ian.

Hello kirkwood folks,

We have been seeing reports on the Debian arm list about
instability/errors running Debian Stretch (4.9 based) on
various?Kirkwood 6282 based QNAP systems. Errors are things like [0,
actually one of the earlier pre-4.9 reports, same symptoms as with 4.9
though]:

[???37.167103] BUG: Bad rss-counter state mm:c0caa1e0 idx:1 val:1
[??783.570365] BUG: Bad rss-counter state mm:c09e6220 idx:1 val:1
[??800.172223] BUG: Bad rss-counter state mm:ecbc05e0 idx:1 val:1
[??829.005336] BUG: Bad rss-counter state mm:c0d4b880 idx:1 val:1
[??871.773956] BUG: Bad rss-counter state mm:c09e63c0 idx:1 val:1
[ 1299.565344] BUG: Bad rss-counter state mm:ecaf8c40 idx:1 val:1

and

[???71.033784] Unhandled fault: external abort on linefetch (0x014) at
0xb6c73db0
[???71.041037] pgd = ead9c000
[???71.043747] [b6c73db0] *pgd=3fd72831
[???84.144056] Unhandled fault: external abort on linefetch (0x014) at
0xb6d44db0
[...]

Many of the affected systems were running Debian Jessie (3.16 based)
fine (as is my own 6282 based system). Some reports have been on
intermediate kernels during the Stretch development cycle, it appears
(again from [0]) that 4.3 was ok but 4.7 was not.

>From the reports it seems that 6281 SoCs are not affected, I only have
a spare 6281 to?test on and can confirm that it appears to be fine when
running 4.9.

Some other reports:
-?https://lists.debian.org/debian-arm/2017/04/msg00056.html
? (might have been an unrelated failing disk though?)
-?https://lists.debian.org/debian-arm/2017/07/msg00010.html?
? which also includes a "corrupted status flag!!: 0" message making me
? wonder about possible RAM issues.
-?https://lists.debian.org/debian-arm/2017/07/msg00011.html
? Rob, author of [0], confirming 6281 is ok.
- In the attached mail (which was copied to debian-arm but didn't make
? it to the?list archives for some reason so I think it is ok to?
? share)?has the results of various experiments by Rob (of [0] fame)?
? including boot-7.log which is a full log with the error occuring.

I've had a look through the kernel git logs, both in the 4.3..4.7 range
for possible culprits and in the 4.9..now range for possible fixes but
couldn't spot anything obvious (I didn't spot very much at all touching
these processors, mostly it looks like changes for the newer Armada
platforms).

I'm afraid I've not been able to find someone to try with a newer
kernel, for my part my only 6282 based system is in "production" as
storage for a mythtv setup so it is tricky to experiment with.

Any ideas what may be going on here?

Cheers,
Ian.

[0]?https://lists.debian.org/debian-arm/2016/10/msg00041.html
