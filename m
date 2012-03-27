From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 27 Mar 2012 14:09:28 -0700
Subject: [PATCH 02/10] clk: remove unnecessary EXPORT_SYMBOL_GPL
In-Reply-To: <20120327131002.GC3719@S2101-09.ap.freescale.net>
References: <20120327092828.GA16397@lunn.ch>
 <20120327131002.GC3719@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zMEtyYuPwSAnnJ2PUnymkn-QWD7rJaymemH5on21EB4Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 6:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Mar 27, 2012 at 11:28:28AM +0200, Andrew Lunn wrote:
>> > Date: Tue, 27 Mar 2012 15:23:21 +0800
>> > From: Shawn Guo <shawn.guo@linaro.org>
>> > To: linux-arm-kernel at lists.infradead.org
>> > Cc: Shawn Guo <shawn.guo@linaro.org>, Mike Turquette
>> > ? ? ? ?<mturquette@linaro.org>
>> > Subject: [PATCH 02/10] clk: remove unnecessary EXPORT_SYMBOL_GPL
>> > Message-ID: <1332833009-4121-3-git-send-email-shawn.guo@linaro.org>
>> >
>> > It makes no sense to have EXPORT_SYMBOL_GPL on static functions.
>>
>> Hi Shawn
>>
>> I agree, exporting static functions makes no sense.
>>
>> However, i think it would be good to export them. I will probably need
>> to build a clk very similar to the gated clock. I would like to use
>> these functions when building my ops structure and just add wrappers
>> around them where needed.
>>
>> Could you instead remove the static?
>>
> Hmm, I would not.
>
> I have a similar need for clk_divider_ops calls. ?Instead of exporting
> every single clk_gate_ops call, we should just export "struct clk_ops
> clk_gate_ops". ?That's exactly why I have the patch #4 here.

Andrew, does this approach work for you?  I prefer it over the EXPORT madness.

Regards,
Mike
