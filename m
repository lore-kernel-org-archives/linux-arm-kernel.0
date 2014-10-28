From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 28 Oct 2014 10:58:14 +0000
Subject: [PATCH v6 0/7] ARM: kprobes: enable OPTPROBES for ARM 32.
In-Reply-To: <1414430259.1430.9.camel@linaro.org>
References: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
 <5449A2BB.1020207@hitachi.com> <1414141323.1441.1.camel@linaro.org>
 <544B7228.9050200@huawei.com> <1414430259.1430.9.camel@linaro.org>
Message-ID: <1414493894.1433.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-27 at 17:17 +0000, Jon Medhurst (Tixy) wrote:
[...]
> The decode table could possibly incorporate patterns to
> cover instructions types that you split up in PATCH 1, e.g. so we
> might not need separate PROBES_STORE and PROBES_STORE_EXTRA (

Sorry, I got that a bit wrong, the first patch only splits loads and
stores and doesn't create create any new 'extra' instruction types.
However, my comment could still apply to that split between between
loads and stores; for many of them, the difference is just a single bit
that is possibly cheap or free to test in the checkers.

The reason I am thinking along these lines is that each additional enum
value in the instruction types adds an entry into every action and
checker table, as well as expanding the decoding tables to detect them.
So I just want to make sure that we think these additions result in a
net benefit in code size and complexity.

-- 
Tixy
