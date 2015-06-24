From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 24 Jun 2015 11:24:29 +0530
Subject: [PATCH v6 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <20150624055429.GC11753@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 15-06-23 21:47:34, Stefan Wahren wrote:
> Hi Srinivas,
> 
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 23. Juni 2015 um
> > 01:07 geschrieben:
> >
> >
> > [...]
> >
> > Device Tree:
> >
> > /* Provider */
> > qfprom: qfprom at 00700000 {
> > ...
> >
> > /* Data cells */
> > tsens_calibration: calib at 404 {
> > reg = <0x404 0x10>;
> > };
> >
> > tsens_calibration_bckp: calib_bckp at 504 {
> > reg = <0x504 0x11>;
> > bit-offset = 6;
> > nbits = 128;
> > };
> >
> > pvs_version: pvs-version at 6 {
> > reg = <0x6 0x2>
> > bit-offset = 7;
> > nbits = 2;
> > };
> >
> > speed_bin: speed-bin at c{
> > reg = <0xc 0x1>;
> > bit-offset = 2;
> > nbits = 3;
> >
> > };
> > ...
> > };
> >
> > userspace interface: binary file in /sys/class/nvmem/*/nvmem
> >
> > ex:
> > hexdump /sys/class/nvmem/qfprom0/nvmem
> >
> > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
> > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > ...
> > *
> > 0001000
> >
> 
> i want to port OCOTP driver for MXS, which hasn't MMIO. From my understanding
> hexdump would readout the complete register range defined in provider DT node.
> 
> How can i achieve that hexdump only reads the data area within the register
> range?

I also had a similar question in my mind.

- Sanchayan.
