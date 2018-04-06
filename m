From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Apr 2018 18:34:50 +0100
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
In-Reply-To: <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
 <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
 <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
 <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
Message-ID: <20180406173450.5h7lgh2xdtcs5fbs@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 06:30:50PM +0100, James Morse wrote:
> Hi Mark,
> 
> On 06/04/18 18:22, Mark Rutland wrote:
> > Digging a bit, I also thing that our ct_user_exit and ct_user_enter
> > usage is on dodgy ground today.
> 
> [...]
> 
> > I think similar applies to SDEI; we don't negotiate with RCU prior to
> > invoking handlers, which might need RCU.
> 
> The arch code's __sdei_handler() calls nmi_enter() -> rcu_nmi_enter(), which
> does a rcu_dynticks_eqs_exit().

Ah, sorry. I missed that!

Thanks,
Mark.
