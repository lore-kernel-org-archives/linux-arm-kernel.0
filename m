From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 27 Oct 2012 23:19:55 +0100
Subject: [PATCH 1/2] spi: spidev: Add device tree bindings
In-Reply-To: <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1351238873-25230-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121027221955.GO4564@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 10:07:52AM +0200, Maxime Ripard wrote:
> This will allow to probe spidev from device tree

So, this isn't really something we should have in DT in this format -
the fact that we happen to control some device from userspace isn't a
generic property of the board really, we may end up changing our minds
on Linux too.  The most obvious thing for this seems to be to add the
specific devices to spidev as the OF bindings rather than just register
as some non-specific "spidev" so we can change our minds later about how
to handle the devices.  Not sure that's urgently tasteful but it does
mean we move the "we handle this in userspace" bit out of the .dts into
the kernel which seems better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121027/bad6ce54/attachment.sig>
