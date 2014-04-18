From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Apr 2014 09:41:41 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
 <20140417213502.GX24070@n2100.arm.linux.org.uk>
 <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
Message-ID: <20140418084141.GB24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 09:53:23PM -0500, Rob Herring wrote:
> On Thu, Apr 17, 2014 at 4:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > No.  You simply can't eliminate any of the above - each one has been
> > negotiated through quite an amount of discussion with relevant parties
> > and/or due to technical requirements and they just can't be magic'd
> > away.
> >
> > Plus the ARM64 image format is different from our zImage format.  It
> > would make far *more* sense to align our Image format with our zImage
> > format so existing boot loaders which look for the zImage magic numbers
> > can boot plain Image files too.
> >
> > Moreover, since we could *never* align zImage with the ARM64 format,
> > why on earth would we want to start using the ARM64 format for the
> > Image format?
> 
> I'm not talking about zImage. I'm talking about Image files only. The
> arm64 Image header could be added to ARM Image files and that would
> not hurt or change a thing for existing users. The cost is 64 bytes.

No it isn't.  The cost is 64-bytes *and* user confusion with two
completely different "headers" for no reason what so ever.

Why use the ARM64 version and then have it *block* existing boot
loaders which look for the zImage magic from being able to boot an
Image.

It's a much saner idea to use the ARM32 zImage header than to use the
ARM64 version - or nothing at all.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
