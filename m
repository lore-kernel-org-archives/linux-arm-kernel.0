From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 30 Nov 2010 10:34:53 +0530
Subject: [PATCH][ ARM cpu hotplug 2/2 ] Use common cpu hotplug code for
	UX500
In-Reply-To: <AANLkTi=o=vAHY+ixcRgt7kfqsLP=NsiO6JPwF=+ADbJ9@mail.gmail.com>
References: <AANLkTinOdaYoztaHCkbFhfRtuo4XEVaC+K_7aAB0N28N@mail.gmail.com>
	<AANLkTinmnN+Ta3LCpmL6kfjYLyY8eA8GspEmqEaaS8-p@mail.gmail.com>
	<AANLkTi=o=vAHY+ixcRgt7kfqsLP=NsiO6JPwF=+ADbJ9@mail.gmail.com>
Message-ID: <AANLkTi=8a=5WtwM__fvL0W80bEZ=u7sNoCufXCwfua4Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 7:31 PM, Sundar <sunder.svit@gmail.com> wrote:

> Hi Vincent,
>
> > On Mon, Nov 29, 2010 at 3:19 PM, Vincent Guittot <
> vincent.guittot at linaro.org> wrote:
> >>
> >> This patch extracts the common code of the cpu hotplug feature across
> >> arm platforms. The goal is to only keep the specific stuff of the
> >> platform in the sub-architecture. I have created a hotplug.c file in
> >> the  arm/common directory after studying the cpu hotplug code of
> >> omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
> >> platform dependent functions:
> >>  -platform_enter_lowpower which prepares the platform for low power.
> >>  -platform_do_lowpower on which the cpu will loop until it becomes
> >> really plugged (spurious wake up). This function must returned the cpu
> >> Id in order to leave the unplug state.
> >>  -platform_leave_lowpower which restore the platform context.
> >>  An ux500 patch is available which uses the common/hotplug.c code.
> >> This patch is quite short because the idle / power down functions are
> >> not yet upstreamed
> >>
> >
>
> I had posted a patch which does exactly the same thing sometime ago,
> but it got dropped
> off from the radar. The patch set can be referenced
> @ http://www.spinics.net/lists/arm-kernel/msg97600.html
> I remember getting it Acked by most of the platform maintainers, but
> Russell had some
> reservations on that.
>

It is unfortunate that we didn't catch that work when we started on this.
Let us continue discussion on the other sub-thread of the current posting.

/Amit
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101130/8e4f2145/attachment-0001.html>
