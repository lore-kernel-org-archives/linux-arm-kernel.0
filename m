From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Feb 2015 19:46:56 +0000
Subject: [PATCH v2 2/2] ARM: perf: Add support for Scorpion PMUs
In-Reply-To: <54F0C72B.2090501@codeaurora.org>
References: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
 <1423851849-6069-3-git-send-email-sboyd@codeaurora.org>
 <20150220193552.GE1767@arm.com>
 <20150220201627.GD24928@codeaurora.org>
 <CAJ5Y-eYLeeNDcBtdvMf-k0XGxq-P21FDq-VMHPJsp4=ccuemig@mail.gmail.com>
 <CAJ5Y-ea8LBji1L3Q+NMgA9+eOrDVwWNodqPDD9XsyCzi=LMj9g@mail.gmail.com>
 <54F0C72B.2090501@codeaurora.org>
Message-ID: <20150227194656.GB24818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 07:36:11PM +0000, Stephen Boyd wrote:
> On 02/25/15 08:58, Ashwin Chaugule wrote:
> > Its a count control register (PMxEVCNTCR). Theres various conditions
> > on which you can select when to start/stop counting. e.g. start when
> > another counter register overflows. Setting it to 0 was the
> > recommended default value on Scorpions and Kraits. Reset value is
> > unpredictable. So, just need to make sure this is set every time a
> > counter is setup. Will that still work if this is moved to the reset
> > path?
> 
> I don't think anything in this register changes unless we reset the CPU
> or software changes it, right? We already have a hotplug notifier to
> handle the case where the CPU is hotplugged out (and may get reset) and
> we need to reset the PMU. The other case is deep idle, which we don't
> have yet but we'll need to do a save/reset/restore across idle when we
> get there. So it seems possible to move it to the PMU reset path.

That would be my preference! Please respin the patches and I'll take another
look.

Will
