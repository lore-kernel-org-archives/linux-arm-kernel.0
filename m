From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 10:07:26 +0100
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than
 0xf0000000
In-Reply-To: <1441269272.3102.3.camel@pengutronix.de>
References: <20150903080028.GS21084@n2100.arm.linux.org.uk>
 <1441268887-11618-1-git-send-email-ytk.lee@samsung.com>
 <1441269272.3102.3.camel@pengutronix.de>
Message-ID: <20150903090726.GV21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 10:34:32AM +0200, Lucas Stach wrote:
> Am Donnerstag, den 03.09.2015, 17:28 +0900 schrieb Yongtaek Lee:
> > As i know "vmalloc=size" is not mandatory so that i think default value of
> > vmalloc_min is wrong. 
> > 
> So, if we go and apply your logic to a 1GB system we should resize the
> vmalloc area to 0 bytes in order to avoid RAM truncation without
> CONFIG_HIGHMEM?
> 
> Sorry, but the only sane options here are to either live with the
> truncation, enable CONFIG_HIGHMEM, or set vmalloc size manually.
> Changing a default value that affects everyone for the benefit of your
> specific use-case isn't a sane option.

Exactly right.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
