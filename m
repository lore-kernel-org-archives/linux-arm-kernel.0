From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 15:25:07 +0100
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <4DE64B0E.8030008@stericsson.com>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>
	<alpine.LFD.2.02.1105311236250.3078@ionos>
	<4DE51EB7.7010606@stericsson.com>
	<BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
	<4DE5F0DB.2050409@stericsson.com> <4DE64B0E.8030008@stericsson.com>
Message-ID: <20110601142507.GK3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 04:22:06PM +0200, Mattias Wallin wrote:
> On 06/01/2011 09:57 AM, Mattias Wallin wrote:
>> I'll experiment with it during the day and see how it goes.
> It did not work to have the clocksource init as a core_initcall.
> I got an null pointer oops in sched_clock_poll.
> The lauterbach trace showed that the sched_clock_update_fn was null  
> since the poll function was called before the init.

sched_clock is supposed to be setup and initialized really early.  Why
are you doing trying to move it soo late?
