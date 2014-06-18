From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 21:00:54 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201406182122.29623@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <CAL_JsqKw-C6uZBU3hccGmdofXcCcUKTV6z7Af6KwYwnZiy3HoQ@mail.gmail.com>
 <201406182122.29623@pali>
Message-ID: <20140618200053.GK32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:22:29PM +0200, Pali Roh?r wrote:
> So without this patch DT migration for Nokia N900 cannot be done 
> without breaking userspace - which is not acceptable...
> 
> Also I still did not know why DT kernel does not report Revision 
> number which is passed by bootloader via atags. Any idea?

It was a concious decision by the DT people to exclude most of the ATAGs
which provide that information.  Only memory information and command line
ATAGs are merged into DT.  Every other tag is ignored (as there's no
place for it in DT.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
