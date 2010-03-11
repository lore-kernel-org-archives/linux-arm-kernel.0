From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Mar 2010 20:26:03 +0000
Subject: [PATCH 10/11] ST SPEAr: Added default configuration files for
	SPEAr machines
In-Reply-To: <63386a3d1003111218g5799974cv3336ceaa2b3367a9@mail.gmail.com>
References: <1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-6-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-7-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-8-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-9-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-10-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-11-git-send-email-viresh.kumar@st.com>
	<63386a3d1003111218g5799974cv3336ceaa2b3367a9@mail.gmail.com>
Message-ID: <20100311202603.GD25011@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 09:18:40PM +0100, Linus Walleij wrote:
> 2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:
> > (...)
> > +CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> 
> Not specifically related to this defconfig because hundreds of defconfigs
> use this, but HAVE_GENERIC_DMA_COHERENT is not used in anything but
> a few Kconfig files, all just defining it. No single Makefile, #ifdef
> or anything
> else seems to be using this, so what is it for?? I can't find any use even if I
> go back to kernel 2.6.11 on LXR.

Err...

drivers/base/Makefile:obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += dma-coherent.o

include/asm-generic/dma-coherent.h:#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
