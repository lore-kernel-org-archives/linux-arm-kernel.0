From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Apr 2012 02:49:05 -0300
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <20120406023121.GK7264@S2101-09.ap.freescale.net>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
 <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
 <20120405012343.GH7264@S2101-09.ap.freescale.net>
 <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
 <20120406023121.GK7264@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Dr+qVMOpG6T03L-+i6qYkJRPUPT87hcJAs6DxHs+EcmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 11:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I have to do that to motivate people to add DT support for the drivers
> they submit from the beginning.

Understand your point for new drivers.

If you take the GPMI driver for example: it has been available for a
long time and there is no board using it in mainline.

So how can people easily test it and find bugs with this driver?
Patching their own trees themselves? Sam Gandhi did extensive tests on
NAND and found some DMA issues with it.

If we could have mx28evk supporting GPMI driver today it would
estimulate people to use it and more issues can be found and fixed.

Waiting for DT support to be in place is just blocking the progress for mx28.

Please note that right now there is no dt support for mx28 in mainline.

If what blocks this patch "ARM: mxs/mx28evk: add GPMI-NAND device" to
be accepted is the pin mux conflict, that would be easy to fix and
Huang could do a v5 if you agree.

> Also I do not see much point to keep patching board files which are
> to be removed.

I understand your point, but again, right now there is no dt support,
so the only mechanism we have to register driver is via board files
for mx28.

So it would be nice if you could still accept patches for mx28 while
mx28 dt does not show up in mainline.
