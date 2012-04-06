From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Apr 2012 10:16:48 -0300
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <20120406065302.GN7264@S2101-09.ap.freescale.net>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
 <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
 <20120405012343.GH7264@S2101-09.ap.freescale.net>
 <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
 <20120406023121.GK7264@S2101-09.ap.freescale.net>
 <CAOMZO5Dr+qVMOpG6T03L-+i6qYkJRPUPT87hcJAs6DxHs+EcmA@mail.gmail.com>
 <20120406065302.GN7264@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Ab=cdOevjBhEyQtxVo3mEuoq7xy0auGinUoyh-TddTDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 3:53 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Look, people can still test and find issue with no board in mainline
> using it.

Sure they can, then you need to assume that everyone who uses the
kernel is a kernel developer, which is not the case.

Please think on a user's perspective too, where people want just to
get the kernel from kernel.org and use it without doing any hacks to
it.

>> If we could have mx28evk supporting GPMI driver today it would
>> estimulate people to use it and more issues can be found and fixed.
>>
>> Waiting for DT support to be in place is just blocking the progress for mx28.
>>
> Please tell me what are exactly being blocked there.

The whole point of this discussion started when you stated the reasons
for not applying this patch of the thread:

"1) The pin confliction between gpmi and lcdif remains.
2) I intend to freeze the board file updates, as we are on the way to
  device tree."

1) is easily understood and can be fixed

2) is what we have been discussing.

So not accepting patches to mx28 board files while mx28 dt is not in
place will at least block: GPMI and SPI for mx28.

>> Please note that right now there is no dt support for mx28 in mainline.
>
> There are still no spi-mxs driver in mainline, why are you sending me
> spi board file patches?

I have it locally and I was ready to submit it till I read this
thread. I haven't made the mxs spi driver dt aware.

Since there is no dt support for mx28 yet, I cannot submit it now, so
this will have to wait.

It is like the "chicken-and-egg problem".

> I could accept your spi board file patch when spi-mxs driver hit
> mainline while mx28 dt does not.

Excellent, that's good news and we come to an agreement  :-) Thanks!
