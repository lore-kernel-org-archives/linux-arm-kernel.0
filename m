From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 1 Dec 2016 15:11:39 +0100
Subject: [PATCH] arm: kprobe: replace patch_lock to raw lock
In-Reply-To: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
References: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20161201141138.css266nzcutzfapw@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-10 16:17:55 [-0800], Yang Shi wrote:
> 
> Since patch_text_stop_machine() is called in stop_machine() which disables IRQ,
> sleepable lock should be not used in this atomic context, so replace patch_lock
> to raw lock.

I am taking this one. Thank you.
We have jump_labels() deactivated on ARM because stop_machine() may
cause latencies at runtime. kprobe and kgdb is used by the user on
purpose (and not because he changed some sched setting) I think we are
fine. I am going to document this.

> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Sebastian
