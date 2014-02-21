From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Feb 2014 10:37:10 +0000
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
 irq handler
In-Reply-To: <CAKohpo=FTk9SGCMJGBdOUheUg71WsG7qaeE9rwQRqd5dP4O8FQ@mail.gmail.com>
References: <20140218175703.GJ21483@n2100.arm.linux.org.uk>
 <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
 <20140219094322.GR21483@n2100.arm.linux.org.uk>
 <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
 <20140219095212.GT21483@n2100.arm.linux.org.uk>
 <CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
 <20140219105011.GU21483@n2100.arm.linux.org.uk>
 <CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
 <20140220105903.GY21483@n2100.arm.linux.org.uk>
 <CAKohpo=FTk9SGCMJGBdOUheUg71WsG7qaeE9rwQRqd5dP4O8FQ@mail.gmail.com>
Message-ID: <20140221103710.GB21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 04:48:58PM +0530, Viresh Kumar wrote:
> Nothing wrong in that, only right.. Do you want me to float a patch for
> this or you can get that done along with your series?

I'll send a follow-up mini-series of five patches for it.  It shouldn't
depend all that much on the bigger series - and I think the first two
patches could well do with going into -rc.

 drivers/mmc/host/sdhci-spear.c  | 190 +++++++++-------------------------------
 include/linux/mmc/sdhci-spear.h |   8 --
 2 files changed, 43 insertions(+), 155 deletions(-)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
