From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jan 2010 13:13:35 +0100
Subject: [PATCH/RFC v2 0/3] Human readable platform-specific
	performance event support
In-Reply-To: <000101caa011$1ba9ee10$52fdca30$%fujak@samsung.com>
References: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
	<1264675934.4283.2088.camel@laptop>
	<000101caa011$1ba9ee10$52fdca30$%fujak@samsung.com>
Message-ID: <1264680815.4283.2100.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 12:57 +0100, Tomasz Fujak wrote:

please educate your MUA to wrap lines at ~80.

> Apparently I did not comprehend your attitude towards the events'
> description being exported from the kernel.
> There's been a lengthy discussion which ended in a conclusion that the
> platform detection is a complicated task.

If its really that complicated export a pmu identifier someplace.

The fact is, the kernel simply doesn't use this list, we have perf in
kernel so that resource scheduling and isolation can be done, for that
we need to know how to program the hardware and we need to know about
scheduling constraints, we do not need exhaustive lists of possible
events, let alone descriptive text for them, in the kernel.
