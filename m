From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2016 09:35:28 +0100
Subject: [PATCH kexec-tools 01/32] kdump: mmap() and munmap() only work
 on page-aligned quantites
In-Reply-To: <CAHB_GupQcopOR7Qn5Nk0kNvYT_p0AWTzp+vJe87b+BsQTwr1CQ@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXS0-0004gz-5a@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_GupQcopOR7Qn5Nk0kNvYT_p0AWTzp+vJe87b+BsQTwr1CQ@mail.gmail.com>
Message-ID: <20160526083528.GE19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:46:08AM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > The man page for mmap() and munmap() says that mmap() and munmap()
> > only works for page-aligned addresses, sizes and offsets.  Arrange
> > to give these interfaces what they want.
> >
> 
> If I read correctly, it talks only offsets to be page aligned.

Yes, it's not really needed, but as we have to adjust the size anyway to
compensate for the reduced file offset, it makes little difference whether
we align the size or not.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
