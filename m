From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:46:55 +0100
Subject: [RFC PATCH 0/3] ARM: amba: defining module aliases for AMBA
	driver autoloading
In-Reply-To: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
References: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20111001164655.GL11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 05:56:39PM +0100, Dave Martin wrote:
> Issues:
> 
>   * Do new module alises need to be globally agreed/registered
>     somewhere?

I don't think there is.  Having the bus prefix in there is definitely a
good thing.

>   * Because a driver's ID table is in match-and-mask format whereas
>     udev uses string pattern matching, we effectively have to
>     maintain two ID tables per driver, containing the same
>     information in different formats.  The patch to mmci.c gives an
>     example.
> 
>     I predict that maintenance of those duplicated tables will be
>     somewhat painful and error-prone.  However, the necessary
>     transformations, while simple, are beyond the scope of the C
>     preprocessor.
> 
>     In order to avoid this duplication of information, an extra
>     (but simple) bit of build-time infrastructure would be needed.
> 
>     I think this effort would be worth it -- does anyone have
>     strong views on this?

I think there is some support for udev to use PCI ID tables directly.
I don't know how that works - I suspect it requires module tools
support though.  Might be worth investigating.
