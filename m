From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 9 Jan 2014 20:14:19 +0530
Subject: [PATCH V3 Resend] cpufreq: create cpufreq_generic_get() routine
In-Reply-To: <20140109113300.GA27432@n2100.arm.linux.org.uk>
References: <d9239e0a5df99392647ff8343673342f89d09476.1389059568.git.viresh.kumar@linaro.org>
 <CAOesGMgfFVoVJpOMXWtzVWj_F4pD-L9Osyv4u6=c8RUWOoLHFw@mail.gmail.com>
 <CAKohpo=EsaBPdF3wYsa2rEdjcpPagbhPcxWw1_PA=yVLDnjRiA@mail.gmail.com>
 <20140109113300.GA27432@n2100.arm.linux.org.uk>
Message-ID: <CAKohpo=rUjaJ8XapkS6uCONNSTrF2udLPo=H+Q+QGTTTzfLbSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2014 17:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> No, it implements only what it's clk API implementation requires.

I understand that platform specific parts/drivers aren't using anything
outside of the clk API's currently implemented. But then there are
generic parts of kernel which are free to use this routine. They
may or may not call it on that particular platform, which is currently
happening for SA1100. And so I feel that we need to have dummy
APIs like clk.h in there, as they wouldn't harm at all or break any
existing stuff.

> I've no idea at the moment, and I don't have time to look at this.

Okay. I will go ahead with dummy implementations for now. See
if you can give that a short review.

Thanks.
