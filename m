From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Aug 2013 18:14:38 +0000
Subject: [PATCH RFC v2 16/16] ARM: zynq: Don't call of_clk_init()
In-Reply-To: <201308291920.13983.arnd@arndb.de>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308291537.54608.arnd@arndb.de>
 <89b68978-7eeb-43e1-a456-d864ed313da5@DB8EHSMHS026.ehs.local>
 <201308291920.13983.arnd@arndb.de>
Message-ID: <8bcbe8e7-65c9-48b2-a854-f3bec600c6a8@DB9EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, August 29, 2013 7:20 PM
> To: Michal Simek
> Cc: Sebastian Hesselbarth; Soren Brinkmann; Mike Turquette; Russell King;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH RFC v2 16/16] ARM: zynq: Don't call of_clk_init()
>
> On Thursday 29 August 2013, Michal Simek wrote:
> > Is there any plan to remove all of them?
> > I expect that on almost all platforms it is a need to have at least
> > one early hook to be able to setup things.
>
> In an ideal world, we wouldn't need any, and on arm64 we don't plan to
> introduce callbacks in the first place. We don't put a lot of effort into eliminating
> all the ones from existing platforms in the near future, but but I do hope to have
> a situation where we don't use any callbacks for newly introduced 32-bit
> platforms soon, and remove a lot of the existing callbacks over time when we
> have the chance (like now for the clk init).

As you know we are open to change this when we have alternative for doing that.
I have read discussion about early device probing. Especially for this slcr case.
It is giant IP where generic locking is, clock stuff, pin muxing, reset, cpu startup.
It points to use syscon and regmap and I would love to use better solution
but slcr unlocking must be done very early for clock setup and smp startup.
If you know how to do it let me know. I am definitely open to try that solution.

I expect that this topic will be discussed on ksummit or at least on arm minisummit.

Thanks,
Michal



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
