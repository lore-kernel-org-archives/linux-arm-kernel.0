From: mickael.guene@st.com (mickael guene)
Date: Mon, 12 Dec 2016 08:07:16 +0100
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <87fulus094.fsf@dell.be.48ers.dk>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc> <878trntrig.fsf@dell.be.48ers.dk>
 <20161211070104.GB3035@afzalpc> <87fulus094.fsf@dell.be.48ers.dk>
Message-ID: <238a0185-db3a-fa43-cd7d-91baebdb82d4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

  You can find an R toolchain here:
https://github.com/mickael-guene/fdpic_manifest/releases/download/v7-r-1.0.1/toolset-v7-r-1.0.1-0-gbdcc6a7c-armv7-r.tgz

  It's an fdpic toolset for cortex-r cpu class. gcc version is
quite old (4.7).

  Note also that generated code may crash on class A cpu due to
generation of udiv/sdiv which is optional for class A.
(cortex a15 is ok but not a9).

Hope it helps

Regards
Mickael

On 12/11/2016 09:01 PM, Peter Korsgaard wrote:
>>>>>> "Afzal" == Afzal Mohammed <afzal.mohd.ma@gmail.com> writes:
>
> Hi,
>
>  >> You can build a toolchain and initramfs with Buildroot. Have a look at
>  >> the stm32f429 nommu config:
>  >>
>  >> https://git.buildroot.net/buildroot/tree/configs/stm32f429_disco_defconfig
>
>  > iiuc, it builds one for Cortex-M. i already had a file system w/
>  > busybox compiled using a Cortex-M toolchain (stolen from
>  > Pengutronix's OSELAS.Toolchain), which works on Cortex M4 (Vybrid
>  > VF610 M4 core). But it does not work here, i.e. on Cortex A, seems the
>  > above mentioned also would have the same effect.
>
> Hmm, I'm not sure why a cortex-M toolchain wouldn't work on cortex-A, I
> thought the 'M' instruction set was a pure subset of the 'A'.
>
>  > And in buildroot, couldn't see Cortex R option in menuconfig, and
>  > selecting Cortex-A's excludes flat binary target & presents only with
>  > ELF.
>
> We indeed don't have cortex-R support. I'm not aware of any cortex-R
> Linux support.
>
> When you select a cortex-A variant, then we enable MMU support by
> default, but you can disable it under toolchain options (Enable MMU) and
> then the flat binary option is available.
>
