From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Aug 2011 13:52:32 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <CACRpkdY3_1cnsNuxy2bYgFcrcxEegx_6eSGDSsU9mpQZePAMhA@mail.gmail.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
	<CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
	<20110816095936.GE28656@e102144-lin.cambridge.arm.com>
	<CACRpkdY3_1cnsNuxy2bYgFcrcxEegx_6eSGDSsU9mpQZePAMhA@mail.gmail.com>
Message-ID: <20110816125232.GB17310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 02:44:21PM +0200, Linus Walleij wrote:
> The most probably cause being that the size of the combined
> kernel+initramfs passed the magic limit where it simply breaks,
> I wish we could handle that in some good way :-/

That should be fixed, because we now place the initramfs image
between the code sections and the data sections.
