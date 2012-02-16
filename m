From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 22:14:55 +0000
Subject: [PATCH] ARM: amba: don't include <asm/sizes.h>
In-Reply-To: <20120216160525.GA30558@mail.gnudd.com>
References: <20120216160525.GA30558@mail.gnudd.com>
Message-ID: <20120216221455.GK27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 05:05:25PM +0100, Alessandro Rubini wrote:
> The file uses no SZ_* symbol and some architectures miss sizes.h
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> ---
> 
> There a number of files including but not using it. This one
> in particular I need under x86 so the fix is trivial.
> 
> However, I remember different feelings about sizes.h . Should it die
> or should it proliferate to other archs using asm-generic/sizes.h ?

If you're going to continue with this change, please make sure you
test build Versatile Express, Versatile and Realview to ensure that
this doesn't cause breakage.
