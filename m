From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 26 Apr 2018 14:01:22 +0100
Subject: [RFC PATCH v4] tty: pl011: Avoid spuriously stuck-off interrupts
In-Reply-To: <CAFEAcA9aVWC2M4cExTgPdwGqAOofWgm-61FUuZHNFWvFeNiHJA@mail.gmail.com>
References: <1524740081-4979-1-git-send-email-Dave.Martin@arm.com>
 <CAFEAcA9aVWC2M4cExTgPdwGqAOofWgm-61FUuZHNFWvFeNiHJA@mail.gmail.com>
Message-ID: <20180426130122.GQ16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 01:11:41PM +0100, Peter Maydell wrote:
> On 26 April 2018 at 11:54, Dave Martin <Dave.Martin@arm.com> wrote:
> > This is an update to a previous RFC v3 [1], to fix a problem observed by
> > the qemu community that causes serial input to hang when booting a
> > simulated system with data already queued in the UART FIFO [2].
> >
> > RFC v3 did not solve the problem by itself, due to the problem being
> > triggered again in pl011_enable_interrupts() after working around it
> > in pl011_hwinit().  See the updated commit message in the patch for
> > details.
> >
> > This patch is intended to supersede the previous RFCs, so please test
> > _without_ RFC v2 (or 3) applied.
> >
> > If you can, please:
> >
> >  a) Check that you can still reproduce the bug on mainline without this
> >     patch.
> >
> >  b) Check whether this patch fixes the problem.
> 
> Adding back to the CC list the people who might be able to do
> this testing...
> Link to v4 patch:
> https://patchwork.kernel.org/patch/10365551/

Dang.  Thanks!

(Sorry guys)

---Dave
