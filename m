From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jun 2017 16:45:46 +0200
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <201706031243.qNvuUbQX%fengguang.wu@intel.com>
References: <20170602223006.1653-1-sboyd@codeaurora.org>
 <201706031243.qNvuUbQX%fengguang.wu@intel.com>
Message-ID: <20170605144546.b6oh5sygrza22hbe@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 03, 2017 at 12:22:32PM +0800, kbuild test robot wrote:
> Hi Stephen,
> 
> [auto build test ERROR on sunxi/sunxi/for-next]
> [also build test ERROR on next-20170602]
> [cannot apply to clk/clk-next v4.12-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk-sunxi-ng-Move-all-clock-types-to-a-library/20170603-090538
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
> config: arm-sunxi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `sun8i_a83t_ccu_probe':
> >> sunxi_sid.c:(.text+0x2dc74): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sun9i_a80_ccu_probe':
>    sunxi_sid.c:(.text+0x2dd14): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sun9i_a80_de_clk_probe':
>    sunxi_sid.c:(.text+0x2de20): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sun9i_a80_usb_clk_probe':
>    sunxi_sid.c:(.text+0x2df34): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sun5i_ccu_init':
> >> sunxi_sid.c:(.init.text+0x3f9c): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o:sunxi_sid.c:(.init.text+0x4070): more undefined references to `sunxi_ccu_probe' follow
>    drivers/built-in.o: In function `sun6i_a31_ccu_setup':
> >> sunxi_sid.c:(.init.text+0x4084): undefined reference to `ccu_mux_notifier_register'
>    drivers/built-in.o: In function `sun8i_a23_ccu_setup':
>    sunxi_sid.c:(.init.text+0x411c): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sun8i_a33_ccu_setup':
>    sunxi_sid.c:(.init.text+0x41b8): undefined reference to `sunxi_ccu_probe'
> >> sunxi_sid.c:(.init.text+0x41c0): undefined reference to `ccu_pll_notifier_register'
>    sunxi_sid.c:(.init.text+0x41d0): undefined reference to `ccu_mux_notifier_register'
>    drivers/built-in.o: In function `sunxi_h3_h5_ccu_init':
>    sunxi_sid.c:(.init.text+0x425c): undefined reference to `sunxi_ccu_probe'
>    sunxi_sid.c:(.init.text+0x4270): undefined reference to `ccu_mux_notifier_register'
>    drivers/built-in.o: In function `sun8i_v3s_ccu_setup':
>    sunxi_sid.c:(.init.text+0x4308): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `sunxi_r_ccu_init':
>    sunxi_sid.c:(.init.text+0x4368): undefined reference to `sunxi_ccu_probe'
>    drivers/built-in.o: In function `.LANCHOR0':
> >> sunxi_sid.c:(.data+0x157c4): undefined reference to `ccu_gate_ops'
> >> sunxi_sid.c:(.data+0x15840): undefined reference to `ccu_mp_ops'
> >> sunxi_sid.c:(.data+0x158a4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15908): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15940): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1597c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x159b8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15a20): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15a84): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15aec): undefined reference to `ccu_div_ops'
> >> sunxi_sid.c:(.data+0x15b40): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x15ba4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15c08): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15c40): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15c7c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15cb8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15cf4): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15d30): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x15d6c): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR0':
>    sunxi_sid.c:(.data+0x15e4c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x15e84): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15ec0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15efc): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x15f78): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x15fcc): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x16020): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x16098): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x16110): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x16188): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x16200): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x16278): undefined reference to `ccu_mp_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x162f0): more undefined references to `ccu_mp_ops' follow
>    drivers/built-in.o: In function `.LANCHOR0':
>    sunxi_sid.c:(.data+0x16508): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x16544): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x16580): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x165bc): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x165f8): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x16634): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR0':
>    sunxi_sid.c:(.data+0x16ee4): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x16f48): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x16fd8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1703c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17094): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x170cc): undefined reference to `ccu_gate_ops'
> >> sunxi_sid.c:(.data+0x1713c): undefined reference to `ccu_mult_ops'
> >> sunxi_sid.c:(.data+0x17190): undefined reference to `ccu_nk_ops'
>    sunxi_sid.c:(.data+0x171f8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17260): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x172b4): undefined reference to `ccu_nk_ops'
> >> sunxi_sid.c:(.data+0x17328): undefined reference to `ccu_nkmp_ops'
>    sunxi_sid.c:(.data+0x17398): undefined reference to `ccu_mult_ops'
> >> sunxi_sid.c:(.data+0x17404): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x17478): undefined reference to `ccu_nkmp_ops'
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x17d40): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17db8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17e30): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17e94): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x17ef8): undefined reference to `ccu_div_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x17f5c): more undefined references to `ccu_div_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x18358): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x183d0): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x18408): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18444): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x184ac): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x184e4): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18520): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1855c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x185c4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1862c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18690): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x186f4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18758): undefined reference to `ccu_div_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x187bc): more undefined references to `ccu_div_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x18810): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x18864): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x188c8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1892c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18990): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x189f4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18a58): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18a90): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18acc): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18b08): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18b44): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18b80): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x18bbc): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x18d8c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18df0): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x18e68): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x18ea0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18edc): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18f18): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18f54): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x18f90): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x18fcc): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x19024): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x19078): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x190cc): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x19144): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x191bc): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x19234): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x192ac): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x19324): undefined reference to `ccu_mp_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x1939c): more undefined references to `ccu_mp_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
> >> sunxi_sid.c:(.data+0x193d4): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x19410): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1948c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x194c4): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x19500): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1957c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x195b4): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x195f0): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1966c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x196a4): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x196e0): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1975c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x197d4): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1984c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x19884): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x198c0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x198fc): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x19938): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x19974): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x199b0): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x1a56c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1a5d0): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1a660): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1a6c4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1a764): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1a7cc): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1a838): undefined reference to `ccu_nm_ops'
> >> sunxi_sid.c:(.data+0x1a8b0): undefined reference to `ccu_nkm_ops'
>    sunxi_sid.c:(.data+0x1a918): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1a984): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1a9d8): undefined reference to `ccu_nk_ops'
>    sunxi_sid.c:(.data+0x1aa50): undefined reference to `ccu_nkm_ops'
>    sunxi_sid.c:(.data+0x1aabc): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1ab28): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1ab94): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1abac): undefined reference to `ccu_nkm_ops'
>    sunxi_sid.c:(.data+0x1b154): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b1b8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b220): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b284): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b2e8): undefined reference to `ccu_div_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x1b34c): more undefined references to `ccu_div_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x1b384): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b3c0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b428): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b490): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b4f4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b558): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b5ac): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1b610): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b674): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1b6ac): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b6e8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b724): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b760): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1b79c): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x1b7d8): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x1b920): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1b974): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1b9ec): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1ba64): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1ba9c): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bad8): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bb54): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1bb8c): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bbc8): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bc44): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1bc7c): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bcb8): undefined reference to `ccu_phase_ops'
>    sunxi_sid.c:(.data+0x1bd34): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1bdac): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1bde4): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1be20): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1be5c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1be98): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1bed4): undefined reference to `ccu_gate_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x1bf10): more undefined references to `ccu_gate_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x1c61c): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1c680): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1c710): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1c774): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1c7cc): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1c834): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1c8a0): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1c918): undefined reference to `ccu_nkm_ops'
>    sunxi_sid.c:(.data+0x1c984): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1c9d8): undefined reference to `ccu_nk_ops'
>    sunxi_sid.c:(.data+0x1ca50): undefined reference to `ccu_nkm_ops'
>    sunxi_sid.c:(.data+0x1cabc): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1cb28): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1cb94): undefined reference to `ccu_nm_ops'
>    sunxi_sid.c:(.data+0x1cc08): undefined reference to `ccu_nkmp_ops'
>    sunxi_sid.c:(.data+0x1d25c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d2c0): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d328): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d38c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d3f0): undefined reference to `ccu_div_ops'
>    drivers/built-in.o:sunxi_sid.c:(.data+0x1d454): more undefined references to `ccu_div_ops' follow
>    drivers/built-in.o: In function `.LANCHOR1':
>    sunxi_sid.c:(.data+0x1d48c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d4c8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d504): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d56c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d5d4): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d638): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d69c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d6f0): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1d754): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d7b8): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d7f0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d82c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d868): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d8a4): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d8e0): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1d938): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1d99c): undefined reference to `ccu_div_ops'
>    sunxi_sid.c:(.data+0x1d9d8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1da14): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1da50): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1da8c): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1dac8): undefined reference to `ccu_gate_ops'
>    sunxi_sid.c:(.data+0x1db20): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1db74): undefined reference to `ccu_mux_ops'
>    sunxi_sid.c:(.data+0x1dbec): undefined reference to `ccu_mp_ops'
>    sunxi_sid.c:(.data+0x1dc64): undefined reference to `ccu_mp_ops'

It seems like even though the lib.a file is compiled properly, it is
never linked in. It looks like we would be supposed to add
drivers/clk/sunxi-ng/ to libs-y, but that doesn't seem to work for
Makefiles in drivers/*

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/f36d4088/attachment-0001.sig>
