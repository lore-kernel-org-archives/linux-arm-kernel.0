From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 13 Jul 2012 09:10:28 +0100
Subject: [PATCH 1/4] clk:spear1340:Fix: Rename clk ids within predefined
 limit
In-Reply-To: <CAOh2x==4rQhAvZmmqiyi0jhF0Zz=v8OmuCBaFGFehOEt2kyd1w@mail.gmail.com>
References: <cover.1342160220.git.vipulkumar.samar@st.com>
 <b43c4e64ed61d4c18f5c3326539f7f03e9604ef1.1342160220.git.vipulkumar.samar@st.com>
 <CAOh2x==4rQhAvZmmqiyi0jhF0Zz=v8OmuCBaFGFehOEt2kyd1w@mail.gmail.com>
Message-ID: <CAOh2x=k1iA_C5HjO-Rq6pWW+=NZkBmTy0j7j-ZmyAGbWkHhWLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 9:06 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Fri, Jul 13, 2012 at 7:23 AM, Vipul Kumar Samar
> <vipulkumar.samar@st.com> wrote:
>> The max limit of con_id is 16 and dev_id is 20. As of now for spear1340, many
>> clk ids are exceeding this predefined limit.
>>
>> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
>
>> @@ -509,23 +507,23 @@ void __init spear1340_clk_init(void)
>
>> -       clk_register_clkdev(clk1, "uart0_synth_gate_clk", NULL);
>
>> -       clk_register_clkdev(clk1, "sdhci_synth_gate_clk", NULL);
>
>> -       clk_register_clkdev(clk, "gmac_phy_input_mux_clk", NULL);
>> -       clk_register_clkdev(clk1, "gmac_phy_synth_gate_clk", NULL);
>
> These are the only places in this entire patch, where i found con_id
> crossing the limit.
> Then why so many changes? Aligning all to similar naming?
>
>
>>         clk_register_clkdev(clk, NULL, "e0000000.serial");
>
> @Russell & Mike: Above line uses maximum length of dev_id, i.e. 16.
> And because with DT we have so long device names now, out of which
> 8 - address
> 1 - '.'
> 1 - '\0'
>
> 10 are already gone and so only 6 are left for device name. Should we
> consider updating
> dev_id array size??

Sorry, I thought dev_id is 16 and con_id is 20. And so above comments.
Please ignore. :(

--
viresh
