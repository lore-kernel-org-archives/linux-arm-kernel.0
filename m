From: wmb@firmworks.com (Mitch Bradley)
Date: Wed, 11 Jan 2012 14:47:27 -1000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0E2B95.7070402@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0E1843.7030207@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A848@HQMAIL01.nvidia.com>
 <4F0E2B95.7070402@firmworks.com>
Message-ID: <4F0E2D9F.5080909@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More nits picked below ...


 >
 > i2c1: i2c at 7000c000 {
 >      #address-cells =<1>;
 >      #size-cells =<0>;
 >      compatible = "nvidia,tegra20-i2c";
 >      reg =<0x7000C000 0x100>;
 >      interrupts =<0 38 0x04>;
 > };
 >
 > mux at 0 {

The name "i2cmux" might be more evocative.

 >      #address-cells =<1>;
 >      #size-cells =<0>;
 >      compatible = "nvidia,tegra20-i2c";
 >      parent-bus =<&i2c1>;
 >      gpios =<&gpio 100 0&gpio 101 0>;
 >      gpio-values-idle =<0>; /* bitmask of values */
 >
 >      bus at 0 {

Since this implements the i2c bus abstraction, the name should be "i2c"

 >          #address-cells =<1>;
 >          #size-cells =<0>;
 >          /*
 >           * The GPIO values to set as a bitmask.
 >           * Formatted like gpio-i2cmux.c's mux->data.values[i].
 >           * Or name this gpio-values?
 >           */
 >          reg =<1>;
 >
 >          wm8903: wm8903 at 1a {
 >              compatible = "wlf,wm8903";
 >              reg =<0x1a>;
 >              ...
 >          };
 >      };
 >
 >      bus at 1 {

Ditto, name should be "i2c"

 >          #address-cells =<1>;
 >          #size-cells =<0>;
 >          reg =<2>;
 >
 >          light-sensor at 44 {
 >              compatible = "isil,isl29018";
 >              reg =<0x44>;
 >              ...
 >          };
 >      };
 > };
