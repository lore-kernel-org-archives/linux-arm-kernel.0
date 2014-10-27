From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Oct 2014 11:14:04 +0000
Subject: [PATCH v6 4/7] ARM: l2c: Add support for overriding prefetch
 settings
In-Reply-To: <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
 <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20141027111404.GW12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 12:05:47PM +0100, Marek Szyprowski wrote:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
> settings configured in registers leading to crashes if L2C is enabled
> without overriding them. This patch introduces bindings to enable
> prefetch settings to be specified from DT and necessary support in the
> driver.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [mszyprow: rebased onto v3.18-rc1, added error messages when property value
>  is missing]

Why?  What if the boot loader has already set these up appropriately?  Why
should we force people to list these in the DT?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
