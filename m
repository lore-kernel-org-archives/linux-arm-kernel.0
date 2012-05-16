From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 15 May 2012 22:40:11 -0700
Subject: [PATCH] clk: Fix CLK_SET_RATE_GATE flag validation in
 clk_set_rate().
In-Reply-To: <20120516002500.GD29393@b20223-02.ap.freescale.net>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <1337114622-11292-1-git-send-email-skannan@codeaurora.org>
 <20120516002500.GD29393@b20223-02.ap.freescale.net>
Message-ID: <CAJOA=zP4kS1CPry5nWo-mTba+9dAdK_a+rUrNCkQrzgixa3kRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 5:25 PM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> On Tue, May 15, 2012 at 01:43:42PM -0700, Saravana Kannan wrote:
>> The clk_set_rate() code shouldn't check the clock's enable count when
>> validating CLK_SET_RATE_GATE flag since the enable count could change after
>> the validation. Similar to clk_set_parent(), it should instead check the
>> prepare count. The prepare count should go to zero only when the end user
>> expects the clock to not be enabled in the future. Since the code already
>> grabs the prepare count before validation, it's not possible for prepare
>> count to change after validation and by association not possible for a well
>> behaving end user to enable the clock while the set rate is in progress.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Reviewed-by: Richard Zhao <richard.zhao@freescale.com>

Looks good to me.  I'll take into clk-next for one final pull request
to arm-soc.

Thanks,
Mike
