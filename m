From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 16 May 2014 12:52:45 +0200
Subject: [PATCH RFC 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <CAPdUM4P7Z1eLVKuc0N1iPaekM_7kNv7KCve2MgrEziszfnzz7A@mail.gmail.com>
References: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
 <1400175151-27779-4-git-send-email-t.figa@samsung.com>
 <CAPdUM4P7Z1eLVKuc0N1iPaekM_7kNv7KCve2MgrEziszfnzz7A@mail.gmail.com>
Message-ID: <5375EDFD.1020708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 16.05.2014 12:39, Rahul Sharma wrote:
> [snip]
>> +       gate->lock = &clkout_lock;
>> +
>> +       mux->reg = reg + EXYNOS_PMU_DEBUG_REG;
>> +       mux->mask = EXYNOS_CLKOUT_MUX_MASK;
>> +       mux->shift = EXYNOS_CLKOUT_MUX_SHIFT;
>> +       mux->lock = &clkout_lock;
>> +
>> +       clk = clk_register_composite(NULL, "clkout", parent_names,
>> +                                       parent_count, &mux->hw,
>> +                                       &clk_mux_ops, NULL, NULL, &gate->hw,
>> +                                       &clk_gate_ops, 0);
>> +       if (IS_ERR(clk))
>> +               goto err_unmap;
>> +
> 
> Hi Tomasz,
> 
> Do we really need a composite clock here? How about registering
> a mux and a gate separately?

What's wrong with a composite clock? It simplifies the code as just a
single clock needs to be registered. I don't see any drawbacks compared
to registering two clocks separately.

Best regards,
Tomasz
