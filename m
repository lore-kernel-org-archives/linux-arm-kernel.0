From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Mar 2013 16:22:55 +0000
Subject: [PATCH 4/4][V2] ARM: timer-sp: Set dynamic irq affinity
In-Reply-To: <513A03B7.7000004@linaro.org>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
 <1362219013-18173-5-git-send-email-daniel.lezcano@linaro.org>
 <513A03B7.7000004@linaro.org>
Message-ID: <20130311162255.GI4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 04:28:55PM +0100, Daniel Lezcano wrote:
> On 03/02/2013 11:10 AM, Daniel Lezcano wrote:
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > When a cpu goes to a deep idle state where its local timer is shutdown, it
> > notifies the time frame work to use the broadcast timer instead.
> > 
> > Unfortunately, the broadcast device could wake up any CPU, including an idle one
> > which is not concerned by the wake up at all.
> > 
> > This implies, in the worst case, an idle CPU will wake up to send an IPI to
> > another idle cpu.
> > 
> > This patch fixes this for ARM platforms using timer-sp, by setting
> > CLOCK_EVT_FEAT_DYNIRQ feature.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> 
> Hi Russell,
> 
> I asked Thomas if he could take this patch in its tree but it falls
> under your umbrella. Thomas agreed to take it if you ack this patch.
> 
> Is this patch acceptable for you ?

It's simple enough.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
