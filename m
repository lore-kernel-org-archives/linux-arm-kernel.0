From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Mar 2016 17:12:57 +0000
Subject: [PATCH] ARM: realview: DT support for the PBA8 and PBX-A9
In-Reply-To: <CACRpkdYBJ_4PbWoMK-wNwumuVaYPfxnxF1cw-01XyDU7rmD2jw@mail.gmail.com>
References: <1456329276-29529-1-git-send-email-linus.walleij@linaro.org>
 <56D04CC2.9010708@arm.com>
 <CACRpkdYBJ_4PbWoMK-wNwumuVaYPfxnxF1cw-01XyDU7rmD2jw@mail.gmail.com>
Message-ID: <20160305171257.GG19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2016 at 12:08:27AM +0700, Linus Walleij wrote:
> On Fri, Feb 26, 2016 at 8:01 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> > As with the Versatile AB I scored from a junk pile, trying to boot a
> > full userspace from SD card makes slow progress through a storm of data
> > transfer errors and eventually dies. USB is similarly flaky, with occasional
> > device resets and command errors, but I don't see that it's this patch's
> > fault
> 
> Neither SD/MMC or USB mass storage boots ever worked on these
> shaky PL180 and ISP1760 drivers. Only NFS boot really works.
> 
> I think PL180 can be made to work if we implement a pure polling mode
> (not IRQ, not DMA) to read it.

Don't even try that.  The DMA is very flakey from board to board, and
what works on one doesn't work on another.

>From what I remember playing with that on Versatile PB926, it was a
complete dead-end.  The only sort-of functional peripheral with DMA
on my boards was PL011, and only for transmit.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
