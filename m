From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 19:06:20 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ@mail.gmail.com>
References: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ@mail.gmail.com>
Message-ID: <20120514180619.GH25668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 06:39:00PM +0100, Lee Jones wrote:

> Okay, so can you suggest a way to marry up the constraints found in DT to
> the remainder of the settings found in the driver without pointlessly
> applying it all to the DT itself (which is was some of the other drives
> have done)?

That's what people are using regulator_of_match() for - it's for mapping
the init data in DT array to a handle the driver can use for its
internal data (and vice versa).  See how tps65910 is using it for an
example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/c5fc4d96/attachment.sig>
