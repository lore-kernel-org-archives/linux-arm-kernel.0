From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Mar 2017 20:45:28 +0100
Subject: [RFCv2] arm64: support HAVE_ARCH_RARE_WRITE and
 HAVE_ARCH_RARE_WRITE_MEMCPY
In-Reply-To: <CAGXu5jLFDGO5OfOGa7B9H6pw8ivnL9MUsPZ=fQns-fbA6R-Ljw@mail.gmail.com>
References: <1490884982-5066-1-git-send-email-hoeun.ryu@gmail.com>
 <CAGXu5jLFDGO5OfOGa7B9H6pw8ivnL9MUsPZ=fQns-fbA6R-Ljw@mail.gmail.com>
Message-ID: <20170330194528.GJ7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 12:38:15PM -0700, Kees Cook wrote:
> Great work! I think this will need some further changes, though, since
> it doesn't look to me like this would pass LKDTM's tests if it was
> built as a module. (This is missing from my ARM attempt too... I
> haven't figured out how to set the domain on the kernel modules...)

You're not going to be able to do it very easily.  The only way I can
think of achieving it would be to split the module area into one
chunk for text, one chunk for write-rare and one chunk for data.

I still think that using domains is a mistake for this - it's a good
solution for things that are contiguous and big (like userspace), but
not for small amounts of data (like module sections.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
