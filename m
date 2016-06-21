From: dhdang@apm.com (Duc Dang)
Date: Tue, 21 Jun 2016 02:02:44 -0700
Subject: Warning when compiling DTB on X-Gene platform with dtc 1.4.1-g53bf130b
Message-ID: <CADaLNDnfH8Weo=9jVNAW7LQCvAw23-z5fafwWcer4FSKeYH=ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

I got warning on unit_address_vs_reg similar to this
https://lkml.org/lkml/2016/3/7/43 when using v4.7-rc2 dtc to build dtb
for X-Gene Mustang:

dhdang at xgene-next=>./scripts/dtc/dtc -O dtb -R 16 -o mustang.dtb
arch/arm64/boot/dts/apm/apm-mustang.dts
  Warning (unit_address_vs_reg): Node /soc/reboot at 17000014 has a unit
name, but no reg property
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges
property, but no unit name
  Warning (unit_address_vs_reg): Node /gpio-keys/button at 1 has a unit
name, but no reg property

There are nodes that I cannot change the node-name due to backward
compatible with old firmware reason (/soc/reboot at 17000014 as an
example). Is there any other way to avoid the warning?

Regards,
Duc Dang.
