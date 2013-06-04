From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Jun 2013 17:38:19 +0100
Subject: [PATCH 2/2] ARM: ux500: Silence compiler warnings due to missing
 __cpuinitdata
In-Reply-To: <1916856.3pBBOMscik@wuerfel>
References: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
 <1370360208-6500-2-git-send-email-lee.jones@linaro.org>
 <1916856.3pBBOMscik@wuerfel>
Message-ID: <20130604163819.GO3370@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Jun 2013, Arnd Bergmann wrote:

> On Tuesday 04 June 2013 16:36:48 Lee Jones wrote:
> > WARNING: vmlinux.o(.text.unlikely+0x25c): Section mismatch in reference \
> >   from the function write_pen_release() to the variable                 \
> >   .cpuinit.data:pen_release
> > The function write_pen_release() references
> > the variable __cpuinitdata pen_release.
> > This is often because write_pen_release lacks a __cpuinitdata
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I don't see bug on my machine. Are you sure it's not already fixed in 
> a different way in linux-next?

It's a possibility.

Basically I have a v3.10-rc3 kernel and I did:

`git checkout next/master -- scripts`

I assumed some extra checking appeared in the scripts directory, so I
just fixed the warnings and sent out a patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
