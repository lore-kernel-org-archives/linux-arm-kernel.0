From: robh@kernel.org (Rob Herring)
Date: Tue, 11 Sep 2018 16:54:40 -0500
Subject: i.MX DT memory nodes
Message-ID: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that many i.MX platforms have duplicate, incomplete memory
nodes with both "memory" and "memory@<addr>" nodes. Are you all aware
of this? Plan to fix it? I guess u-boot fixes things enough to work.

>From the DT schema checking:

arch/arm/boot/dts/imx31-bug.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx31-lite.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dt.yaml:8:5: 'reg'
is a required property
arch/arm/boot/dts/imx35-pdk.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx50-evk.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx51-apf51.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx51-apf51dev.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx51-digi-connectcore-jsk.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx51-babbage.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dt.yaml:8:5: 'reg'
is a required property
arch/arm/boot/dts/imx51-ts4800.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx51-zii-scu2-mezz.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx51-zii-rdu1.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx51-zii-scu3-esb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-ard.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-cx9020.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-kp-ddc.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-kp-hsc.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-m53evk.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-mba53.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-qsb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-qsrb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-ppd.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-smd.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-usbarmory.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx53-tx53-x13x.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-voipac-bsb.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx53-tx53-x03x.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw551x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw552x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw553x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw560x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw5903.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-gw5904.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml:9:5: 'reg'
is a required property
arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml:9:5: 'reg'
is a required property
arch/arm/boot/dts/imx6dl-icore.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-mamoj.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-riotboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-savageboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-sabresd.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-ts4900.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-ts7970.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-udoo.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-wandboard.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-apf6dev.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-arm2.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-b450v3.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-b650v3.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-b850v3.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-cubox-i.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml:8:5:
'reg' is a required property
arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gk802.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw51xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-evi.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw52xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw53xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw551x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw54xx.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw552x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw553x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw5903.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw560x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-gw5904.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-h100.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-hummingboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml:9:5: 'reg'
is a required property
arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml:9:5: 'reg'
is a required property
arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-icore.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-marsboard.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-mccmon6.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-novena.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-pistachio.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-rex-pro.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-sabreauto.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-savageboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-sabrelite.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-sbc6x.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-sabresd.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tbs2910.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-ts4900.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-ts7970.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-udoo.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-wandboard.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6qp-sabresd.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6sl-warp.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6sl-evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-nitrogen6sx.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-sabreauto.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-sdb-reva.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-sdb-sai.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-softing-vining-2000.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6sx-sdb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6sx-udoo-neo-basic.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6sx-udoo-neo-extended.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6sx-udoo-neo-full.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml:8:5: 'reg' is a
required property
arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-geam.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-liteboard.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml:10:5: 'reg' is a
required property
arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx7d-pico-pi.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx7d-sdb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx7s-warp.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/vf610m4-colibri.dt.yaml:587:5: 'reg' is a required property
arch/arm/boot/dts/vf500-colibri-eval-v3.dt.yaml:746:5: 'reg' is a
required property
arch/arm/boot/dts/vf610-colibri-eval-v3.dt.yaml:742:5: 'reg' is a
required property
arch/arm/boot/dts/vf610-cosmic.dt.yaml:614:5: 'reg' is a required property
arch/arm/boot/dts/vf610m4-cosmic.dt.yaml:584:5: 'reg' is a required property
arch/arm/boot/dts/vf610-twr.dt.yaml:723:5: 'reg' is a required property
arch/arm/boot/dts/vf610-zii-cfu1.dt.yaml:713:5: 'reg' is a required property
arch/arm/boot/dts/vf610-zii-ssmb-spu3.dt.yaml:741:5: 'reg' is a
required property
arch/arm/boot/dts/vf610-zii-dev-rev-b.dt.yaml:790:5: 'reg' is a
required property
arch/arm/boot/dts/vf610-zii-dev-rev-c.dt.yaml:845:5: 'reg' is a
required property
arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dt.yaml:22:7:
cpu at 0: 'reg' is a required property
arch/arm/boot/dts/imx1-apf9328.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx1-ads.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dt.yaml:8:5: 'reg'
is a required property
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dt.yaml:9:5:
'reg' is a required property
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dt.yaml:9:5:
'reg' is a required property
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dt.yaml:9:5:
'reg' is a required property
arch/arm/boot/dts/imx25-karo-tx25.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx25-pdk.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx27-apf27.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx27-apf27dev.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx27-pdk.dt.yaml:8:5: 'reg' is a required property
arch/arm/boot/dts/imx23-evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dt.yaml:8:5: 'reg'
is a required property
arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx23-sansa.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx23-olinuxino.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx27-phytec-phycore-rdk.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx23-stmp378x_devb.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx23-xfi3.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-apf28.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-apf28dev.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-apx4devkit.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10036.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10037.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10055.dt.yaml:10:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10049.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10056.dt.yaml:10:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10057.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-duckbill-2.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-cfa10058.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-duckbill-2-485.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-duckbill-2-enocean.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx28-duckbill-2-spi.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-duckbill.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dt.yaml:9:5: 'reg' is a
required property
arch/arm/boot/dts/imx28-m28cu3.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-m28evk.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-sps1.dt.yaml:9:5: 'reg' is a required property
arch/arm/boot/dts/imx28-ts4600.dt.yaml:9:5: 'reg' is a required property
