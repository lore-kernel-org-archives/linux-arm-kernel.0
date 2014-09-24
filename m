From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Sep 2014 10:43:02 +0100
Subject: [PATCH v2 1/8] ARM: add mach-asm9260
In-Reply-To: <54227A30.7010805@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <71905861.S3QD6rl7jU@wuerfel> <542136B0.3020305@rempel-privat.de>
 <6072405.iL4RqHeZrt@wuerfel> <54227A30.7010805@rempel-privat.de>
Message-ID: <20140924094302.GU5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:00:48AM +0200, Oleksij Rempel wrote:
> Am 23.09.2014 um 12:19 schrieb Arnd Bergmann:
> > No, all of them.
> 
> By removing it i triggered one error which i don't really understand. It
> will be great if you can help me.
> 
> By defaul kernel will do fallowing remapping, which will trigger:
> "Unable to handle kernel paging request at virtual address c2802174"
> 
> phys addr     ioremap        range size
> =======================================
> 0x80054000 -> c2800000 size: 0x200
> 0x80040000 -> c2802000 size: 0x204
> 0x80088000 -> c2808000 size: 0x4000
> 
> 
> But if change second range from 0x204 to 0x4000, then it works fine.
> 0x80054000 -> c2800000 size: 0x200
> 0x80040000 -> c2808000 size: 0x4000
> 0x80088000 -> c2810000 size: 0x4000
> 
> Why?

The "why" is in the text from your oops dump.  That's precisely /why/ we
print that text - so that we know /why/ the fault happened.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
