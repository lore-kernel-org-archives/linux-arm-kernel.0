From: GKing@nvidia.com (Gary King)
Date: Wed, 11 Aug 2010 08:54:27 -0700
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<4C627479.4060400@parrot.com>
	<AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>
Message-ID: <4C62C7B3.2030706@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2010 04:38 AM, Martin Fuzzey wrote:
>
>
> It seems to me these fixup functions are not intended to solve
> alignment issues but rather implement device specific framing (such as
> when the hardware packs multiple ethernet frames into a single urb)
>
I sent a patch to the list about 2 weeks ago that added support to
DMA bounce to bounce for misaligned buffers. We have a similar
problem with URB alignment for usbnet on Tegra's HCD:

http://lists.arm.linux.org.uk/lurker/message/20100729.005746.b43fa1d9.en.html

- Gary
