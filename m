From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 16 Apr 2010 10:36:32 +0200
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
	<20100415075831.GL30801@buzzloop.caiaq.de>
	<i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
Message-ID: <20100416083632.GF30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 03:08:41PM -0600, Badguy Badguy wrote:
> On Thu, Apr 15, 2010 at 1:58 AM, Daniel Mack <daniel@caiaq.de> wrote:
> > Ah, one more thing: You need to pass a new variable to the kernel upon
> > startup: "mx31lite_baseboard=1". This was done in order to split module
> > code from baseboard code.
> >
> > In case you're using the 2-stage loading mechanism, you need to teach
> > this to your first-stage loader.
> >
> Thanks for the response,
> 
>  I have added that parameter and still no love,
> 
> LOLO 2.4.0 provides the tags so I simply upload the kernel in elf
> format and execute it passing the bootstring,
> I also modified an older second stage bootloader I have from Hasan and
> added the parameter and tried that for same result.
> 
> 
> > Also make sure you're downloading the full image to RAM from LoLo. The
> > new kernel is certainly bigger than the version you currently use.
> >
> 
>  I think you are onto something regarding the whole kernel being
> uploaded tho, as during uncompression I only get 3 periods and with
> other working kernels I get much more, however it does complete
> decompression.

That's ok.

> this is why I attempted the Hasan bootloader again as I provide the
> image as raw and provide the actual size in bytes.
> this did not give any different results however, and the kernel
> decompression still stops at 3 periods and states done, booting the
> kernel.
> 
> so using the Hasan bootloader I provide:
> 
> load raw 0x81000000 1073016 /tftp/192.168.1.161:zImage
                      ^^^^^^^
This is the length of the kernel image, and I doubt this is right. Check
the size of your zImage file again, it's almost certainly bigger than
that.

Daniel
