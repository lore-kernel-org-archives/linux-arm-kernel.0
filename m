From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Aug 2015 20:07:00 +0100
Subject: [PATCH 1/2] drivers: PL061: add support for platform driver
 probing
In-Reply-To: <1438614811.2338188.346456017.5D258EC5@webmail.messagingengine.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
 <CACRpkdY6ZfB-gnnr49He+BYELy4fhiV0g5jkEHhyVsJOc_SBFw@mail.gmail.com>
 <1438614811.2338188.346456017.5D258EC5@webmail.messagingengine.com>
Message-ID: <20150803190700.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 04:13:31PM +0100, Graeme Gregory wrote:
> 
> 
> On Mon, 3 Aug 2015, at 01:40 PM, Linus Walleij wrote:
> > On Mon, Aug 3, 2015 at 8:59 AM, Shannon Zhao <zhaoshenglong@huawei.com>
> > wrote:
> > 
> > > From: Shannon Zhao <shannon.zhao@linaro.org>
> > >
> > > Since PL061 currently only supports AMBA driver, to support using GPIO
> > > PL061 by DT or ACPI, it needs to add support for platform driver.
> > > A DT binding is provided with this patch, ACPI support is added in a
> > > separate one.
> > >
> > > Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> > > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > I already stated in 0/2 what the problem is with this, and it's obviously
> > adding
> > a huge codechunk, very similar to the AMBA probe path.
> > 
> > We need to investigate if ACPI can just spawn AMBA/PrimeCell type devices
> > instead.
> > 
> AMBA DT support is a hideous hack, we had kind of hoped to avoid doing
> that in ACPI.
> 
> If you notice ARM already updated pl011 driver to support platform
> device type probing this seems to be the way to go.

As the AMBA bus maintainer, NAK on that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
