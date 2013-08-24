From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 24 Aug 2013 17:36:31 +0800
Subject: [PATCH v8 00/08] support Hisilicon Hi3xxx SoC
Message-ID: <CAD6h2NTtrVntj7Xt1vV+01h3NoS1rUonaUS-Q+rO4Zfqs1z+xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2013 17:29, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> Changelog:
> v8:
> 1. Drop to support CLK_GATE_SEPERATED_REG in common clock gate driver.
> Support this feature in hi3xxx clock driver.
> 2. Clean unnecessary device node in DTS.
> 3. Define all clocks in hi3620-clk.dtsi. And all clock nodes are defined
> in the clocks node.
> 4. Fix the clock gate & clock mux for timer.
> 5. Rename timer0~4 to dual_timer0~4 in DTS file. It's used to make
> name clearer.
>
> v7:
> 1. Add hi3xxx_defconfig.
> 2. Use reg property in clock node.
> 3. Drop origin clock divider table.
> 4. Reuse clock divider register helper.
> 5. Reuse clock gate register helper.
> 6. Append CLK_GATE_SEPERATED_REG flag in order to support Hisilicon
>    Hi3620 SoC.
> 7. Rebase DEBUG_LL for Hi3xxx.
> 8. Add more clock node in DTS file.
>
> v6:
> 1. Remove hisilicon string from properties in clock driver.
> 2. Replace array by pointer in clock driver. Since only sctrl parent
>    node exists at this time.
>
> v5:
> 1. Remove HIWORD clk patches since they're merged into clk git tree.
> 2. Set hisilicon,clk-reset property of clkgate node is optional.
> 3. Update on commandline args in DTS file. Remove earlyprintk, mem, nfs.
> 4. Move gpio-keys out of amba node in DTS file.
>
> v4:
> 1. Add clk gate with HIWORD mask for Rockchip.
> 2. Update comments and code of HIWORD flags for mux/divider.
> 3. Append a mux without HIWORD mask in Hisilicon 3620.
> 4. Fix the pinmux setting in Hi4511.
>
> v3:
> 1. Use clk_register_mux_table().
>
> v2:
> 1. Reuse mux & divider driver. So append CLK_MUX_HIWORD_MASK &
> CLK_DIVIDER_HIWORD_MASK for Hi3620 SoC.
> 2. Fix system timer running too fast because wrong divider is choosen.
> 3. Remove .init_irq in DT machine descriptor.
>

Forget to edit subject. So add it.

Regards
Haojian
