From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2016 09:38:45 +0000
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <569D71F3.7000408@openwrt.org>
References: <569D71F3.7000408@openwrt.org>
Message-ID: <20160119093845.GJ19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 12:14:59AM +0100, Felix Fietkau wrote:
> I just wasted a few hours debugging user space hangs after updating my
> CNS3xxx device to Linux 4.4 - until I found this:
> http://www.spinics.net/lists/arm-kernel/msg450888.html

Sorry about that.  What you've found is an investigatory patch, not
a fix for it.

> I haven't seen any follow-up patches since that discussion in October,
> and this patch resolves the issue in my test.

If you read the remainder of the thread, you'll notice that there was
discussion about the problem and that isn't a proper fix.

> Could you guys please get this merged and pushed to stable to avoid
> wasting other people's time as well?

No one understands what's going on with ARM11 MPcore (not even ARM Ltd
people).  We certainly do not want to add the expense of writing to
the DACR each and every time we want to do a TLB flush, and as Will
said at the end of the thread, it should be predicated on ARM11 MPcore.
We don't know which revisions of ARM11 MPcore are affected.

Please can you provide your boot messages so we can see what revision
11MPcore you have in your device.  Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
