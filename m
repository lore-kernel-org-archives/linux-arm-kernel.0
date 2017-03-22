From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 22 Mar 2017 15:26:28 +0000
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <CAKv+Gu8VoSLOUiNSXsrtQUr8TQdGBqiOmhsKS+N2dhToMusOUg@mail.gmail.com>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
 <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
 <1490175988.2890.1.camel@linaro.org>
 <CAKv+Gu8VoSLOUiNSXsrtQUr8TQdGBqiOmhsKS+N2dhToMusOUg@mail.gmail.com>
Message-ID: <1490196388.2890.8.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-22 at 12:13 +0000, Ard Biesheuvel wrote:
> On 22 March 2017 at 09:46, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > On Tue, 2017-03-21 at 19:00 +0000, Ard Biesheuvel wrote:
> > 
> > > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > 
> > > UEFI boot and earlycon both still work for me, so
> > > 
> > > Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I forgot to say thanks?earlier, so thanks! :-)

> > > It looks like nommu should be unaffected, but it is worth giving it a
> > > spin as well
> > 
> > I did build test a couple of nommu platforms. I'll try and work out how
> > to get Linux on the only nommu hardware I have (ARM's MPS2) but if that
> > kernel doesn't work before my applying my changes I'm not going to
> > debug, I've opened enough cans of worms for now.
> > 

After much faffing around I got MPS2 booting a Linux kernel, and
somewhat to my surprise?it seems to boot fine, all the way up to
panicking because it didn't find an init. This was with $subject patch.

-- 
Tixy
