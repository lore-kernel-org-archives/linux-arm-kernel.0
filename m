From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 14:46:36 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <2413859.DaWDFlIaaB@wuerfel>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <3461274.sjccN4r7lq@wuerfel>
 <HK2PR06MB0561F8D4A17AAEFEBD774E478AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <2413859.DaWDFlIaaB@wuerfel>
Message-ID: <HK2PR06MB05613CF6C996BF8BD459842E8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Feb 2016, Arnd Bergmann wrote:

> > A car with the best seat belts and airbags still won't help you
> > if you drive it off a cliff.
> 
> That was my point about DEBUG_LL: We already allow picking a DEBUG_LL
> option that immediately breaks booting on any other platform, and
> (worse) breaks even printing any useful output about that fact.

Ya, the DEBUG_LL issue seems like it could be an endless hole of options all throughout the Kconfigs.

DT was supposed to allow everything to be configured at boot time, but it looks like we still need an early-Device-Tree for settings before DT is available. That would solve your DEBUG_LL and PHYS_OFFSET issue.


> Even allowing XIP_KERNEL unconditionally doesn't make it much worse.
> 
> Other options that are able to ruin your day are CONFIG_CPU_BIG_ENDIAN
> (which breaks all user space when changed) and CONFIG_ARM_LPAE (which
> breaks booting on Cortex-A8/A9/A5 systems), or simply disabling essential
> drivers like your console or the block device for your rootfs.
> 
> 	Arnd
>

Yup. As I said...car...vroom vroom...cliff.

(to be humble, I've driven off that cliff before and spent hours trying to figure out what happened)



Chris
