From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 2 May 2014 04:16:48 -0700
Subject: [PATCH v5 2/6] arm64: Introduce VA_BITS and translation level
 options
In-Reply-To: <000a01cf65a9$d3cbf030$7b63d090$@samsung.com>
References: <000201cf64e5$cd3366a0$679a33e0$@samsung.com>
 <20140501100628.GB2848@lvm>
 <000a01cf65a9$d3cbf030$7b63d090$@samsung.com>
Message-ID: <20140502111648.GA3002@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 10:57:09AM +0900, Jungseok Lee wrote:
> On Thursday, May 01, 2014 7:06 PM, Christoffer Dall wrote:
> > On Thu, May 01, 2014 at 11:33:56AM +0900, Jungseok Lee wrote:

[...]

> > > +
> > > +choice
> > > +	prompt "Virtual address space size"
> > > +	default ARM64_VA_BITS_39 if ARM64_4K_PAGES
> > > +	default ARM64_VA_BITS_42 if ARM64_64K_PAGES
> > > +	help
> > > +	  Allows virtual address space size. A level of translation tables
> > 
> > What does "Allows virtual address space size" mean exactly?
> 
> It means that VA space size can be chosen. For example, there are
> two VA size options, 39-bit and 48-bit, with 4KB pages. If 39-bit
> VA space is not enough, 48-bit can be selected instead. The 5th patch
> adds a 48-bit option to this choice blocks.
> 
> If 16KB pages are supported with both 47-bit and 48-bit VA size,
> people could configure it in menuconfig.
> 
> In this context, I've written it down like page size.
> 
> I think Catalin's comment would be helpful.
> http://www.spinics.net/linux/lists/arm-kernel/msg319552.html
> 
I didn't have problems understanding the concept, I was questioning the
language.  The way it is written now it suggests having a virtual
address space size, as opposed to not having a size at all, which
doesn't make sense.

I think you want to say something along the lines of "Allows choosing a
virtual address space size", or "Allows choosing one of multiple
possible virtual address space sizes".

-Christoffer
