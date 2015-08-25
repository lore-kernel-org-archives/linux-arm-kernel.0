From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Aug 2015 10:15:47 +0100
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <20150824174736.GD7557@n2100.arm.linux.org.uk>
References: <CAPAsAGy-r8Z2N09wKV+e0kLfbwxd-eWK6N5Xajsnqq9jfyWqcQ@mail.gmail.com>
 <CACRpkdZmHLMxosLXjyOPdkavo=UNzmTcHOLF5vV4cS1ULfbq6A@mail.gmail.com>
 <CAPAsAGw-iawTpjJh66rQN5fqBFT6UBZCcv2eKx7JTqCXzhzpsw@mail.gmail.com>
 <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
 <55AE56DB.4040607@samsung.com>
 <CACRpkdYaqK8upK-3b01JbO_y+sHnk4-Hm1MfvjSy0tKUkFREtQ@mail.gmail.com>
 <20150824131557.GB7557@n2100.arm.linux.org.uk>
 <CACRpkdYwpucRiXM05y00RQY=gKv8W6YjCNspYFRMGaM605cU0w@mail.gmail.com>
 <CAPAsAGwji7FpUJK9O=FWYN15-rJkYMQyOt9W9ncdY9uLybxkiA@mail.gmail.com>
 <20150824174736.GD7557@n2100.arm.linux.org.uk>
Message-ID: <20150825091547.GA21300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 06:47:36PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 24, 2015 at 05:15:22PM +0300, Andrey Ryabinin wrote:
> > Yes, ~130Mb (3G/1G split) should work. 512Mb shadow is optional.
> > The only advantage of 512Mb shadow is better handling of user memory
> > accesses bugs
> > (access to user memory without copy_from_user/copy_to_user/strlen_user etc API).
> 
> No need for that to be handed by KASan.  I have patches in linux-next,
> now acked by Will, which prevent the kernel accessing userspace with
> zero memory footprint.  No need for remapping, we have a way to quickly
> turn off access to userspace mapped pages on non-LPAE 32-bit CPUs.
> (LPAE is not supported yet - Catalin will be working on that using the
> hooks I'm providing once he returns.)

Hey, I only acked the "Efficiency cleanups" series so far! The PAN emulation
is still on my list.

Will
