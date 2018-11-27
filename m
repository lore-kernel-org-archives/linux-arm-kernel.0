From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 18:03:25 +0000
Subject: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
In-Reply-To: <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <CAKv+Gu8u2exYQ-Q=H1_WrpmQHEddNaC7VC=OYsz-C2kbCobyGA@mail.gmail.com>
 <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
Message-ID: <20181127180325.GA19216@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 01:46:48PM +0100, Ard Biesheuvel wrote:
> (add maintainers back to cc)
> 
> On Tue, 27 Nov 2018 at 12:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 27 Nov 2018 at 11:10, Jackie Liu <liuyun01@kylinos.cn> wrote:
> > >
> > > This is a NEON acceleration method that can improve
> > > performance by approximately 20%. I got the following
> > > data from the centos 7.5 on Huawei's HISI1616 chip:
> > >
> > > [ 93.837726] xor: measuring software checksum speed
> > > [ 93.874039]   8regs  : 7123.200 MB/sec
> > > [ 93.914038]   32regs : 7180.300 MB/sec
> > > [ 93.954043]   arm64_neon: 9856.000 MB/sec
> >
> > That looks more like 37% to me
> >
> > Note that Cortex-A57 gives me
> >
> > [    0.111543] xor: measuring software checksum speed
> > [    0.154874]    8regs     :  3782.000 MB/sec
> > [    0.195069]    32regs    :  6095.000 MB/sec
> > [    0.235145]    arm64_neon:  5924.000 MB/sec
> > [    0.236942] xor: using function: 32regs (6095.000 MB/sec)
> >
> > so we fall back to the scalar code, which is fine.
> >
> > > [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
> > >
> > > I believe this code can bring some optimization for
> > > all arm64 platform.
> > >
> > > That is patch version 3. Thanks for Ard Biesheuvel's
> > > suggestions.
> > >
> > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> 
> This goes with v4 of the NEON intrinsics patch.
> 
> Jackie: no need to resend these, but next time, please repost the
> series entirely, not just a single patch, and keep the maintainers on
> cc.

Actually, it would be helpful if they were resent since I'm currently CC'd
on a v4 1/1 and a v3 2/2 and don't really know what I'm supposed to do with
them :)

Will
