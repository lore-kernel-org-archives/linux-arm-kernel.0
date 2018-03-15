From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 17:58:33 +0100
Subject: [GIT PULL 4/6] i.MX device tree updates for 4.17
In-Reply-To: <CAK8P3a3NXL_0z+Qm1O5Giz3SstGeHd1ghB320b6OSZPOeY1uuA@mail.gmail.com>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-4-git-send-email-shawnguo@kernel.org>
 <CAK8P3a3NXL_0z+Qm1O5Giz3SstGeHd1ghB320b6OSZPOeY1uuA@mail.gmail.com>
Message-ID: <CAK8P3a09BjAnRWitNbfMFvPr7nwmqcVNi28VK1pRMUu0VUL90w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>>  - A bunch of patches from Fabio and Marco to fix DTC warnings seen with
>>    W=1 switch.
>>  - Add missing '#sound-dai-cells' for sgtl5000 codec which is complained
>>    by DTC.

I still get a bunch of warnings in linux-next with your patches:

arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning
(chosen_node_stdout_path): /chosen:linux,stdout-path: Use
'stdout-path' instead
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning
(chosen_node_stdout_path): /chosen:linux,stdout-path: Use
'stdout-path' instead
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning
(chosen_node_stdout_path): /chosen:linux,stdout-path: Use
'stdout-path' instead
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning
(chosen_node_stdout_path): /chosen:linux,stdout-path: Use
'stdout-path' instead
arch/arm/boot/dts/imx6ul-isiot-emmc.dtb: Warning (sound_dai_property):
/sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in
node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle
(referred from sound-dai[0])
arch/arm/boot/dts/imx6ul-isiot-nand.dtb: Warning (sound_dai_property):
/sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in
node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle
(referred from sound-dai[0])

I hoped that they would be fixed with the pull request, but something
is still missing. Can you have another look? It should be related to
the fixes you already have.

       Arnd
