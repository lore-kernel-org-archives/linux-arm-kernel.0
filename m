From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 15 Aug 2016 13:57:41 +0800
Subject: [PATCH v3 3/4] arm64: kaslr: Fix incorrect placement of
 __initdata and __read_mostly
In-Reply-To: <20160815125214.2727bf88@xhacker>
References: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
 <1470988871-2799-4-git-send-email-jszhang@marvell.com>
 <CAKv+Gu_ci37u6av9gjchBTVwoMCiqdnwtnDHxLT3cV3+kG0wUw@mail.gmail.com>
 <20160815125214.2727bf88@xhacker>
Message-ID: <20160815135741.35e60cd1@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, 15 Aug 2016 12:52:14 +0800 Jisheng Zhang wrote:

> Hi Ard,
> 
> On Fri, 12 Aug 2016 14:02:40 +0200 Ard Biesheuvel wrote:
> 
> > Hi Jisheng,
> > 
> > On 12 August 2016 at 10:01, Jisheng Zhang <jszhang@marvell.com> wrote:  
> > > __initdata and __read_mostly should be placed after the variable name
> > > for the variable to be placed in the intended section.
> > >    
> > 
> > Why?  
> 
> include/linux/init.h says something as:
> 
>  * For initialized data:
>  * You should insert __initdata or __initconst between the variable name
>  * and equal sign followed by value, e.g.:
>  *
>  * static int init_variable __initdata = 0;
>  * static const char linux_logo[] __initconst = { 0x32, 0x36, ... };
> 
> and examples in gcc manual also put __attribute__ (...) after variable name.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#Common-Variable-Attributes
> 
> Then I grep the source, found most lines (especially arch/arm64/*) put the
> __initdata and __read_mostly after the variable name.
> 
> However, I built the code with three different gcc, the result looks identical
> no matter where these markers put. So the commit msg looks wrong, what about
> changes it as
> 
> "put __initdata and __read_mostly after the variable name
> to keep the style consistent"?

After some consideration, I want to drop this patch in newer version since
it's not a bug, just "style"

Thanks for your reviewing,
Jisheng
