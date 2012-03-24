From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Mar 2012 19:32:00 +0000
Subject: Handling device shared SFR on dt platform
In-Reply-To: <4F6A5853.9090809@gmail.com>
References: <4F6A5853.9090809@gmail.com>
Message-ID: <20120324193200.822AD3E0B06@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Mar 2012 23:38:11 +0100, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> 
> Hello,
> 
> I'm working on adding the device tree support for two devices that
> share some IO registers. Exactly, there is one shared SFR that 
> contains a common bit to enable two PHY devices, and another two
> bits, each to separately reset each PHY.
> 
> Currently this shared register is statically memory mapped and it is
> handled by a platform specific callback, that both drivers use to
> control their corresponding (sub)devices in synchronised manner.
> 
> The two devices are a MIPI-CSI2 receiver and a MIPI-DSI transmitter, 
> and the common register is there to control the camera and the display 
> port PHY. The hardware design is a bit unfortunate, but there is not
> much I could do about it.

Generally, this is handled by having a third node for the shared
register block and both device nodes holding a phandle to it.

No, there isn't any common infrastructure for implementing this, but
it isn't very much code.

g.
