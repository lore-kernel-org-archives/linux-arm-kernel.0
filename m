From: mickael.guene@st.com (mickael guene)
Date: Mon, 12 Dec 2016 10:44:45 +0100
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <584E6DA3.5070009@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc> <878trntrig.fsf@dell.be.48ers.dk>
 <20161211070104.GB3035@afzalpc> <87fulus094.fsf@dell.be.48ers.dk>
 <238a0185-db3a-fa43-cd7d-91baebdb82d4@st.com> <584E6DA3.5070009@arm.com>
Message-ID: <be4002b0-d4e8-bb3a-dff0-8050f680f5ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

  At the end of https://github.com/mickael-guene/fdpic_manifest you can
find a set of patch to apply for kernel fdpic support. Unfortunately
they are quite old ... But I have done some test on May for
stm32f469-disco platform and I have attached patches against more
recent kernel.

  I also remove Maxime address since he quit st few month ago and his
address is no more valid.

Regards
Mickael

On 12/12/2016 10:28 AM, Vladimir Murzin wrote:
> Hi,
>
> On 12/12/16 07:07, mickael guene wrote:
>> Hi all,
>>
>>  You can find an R toolchain here:
>> https://github.com/mickael-guene/fdpic_manifest/releases/download/v7-r-1.0.1/toolset-v7-r-1.0.1-0-gbdcc6a7c-armv7-r.tgz
>>
>>  It's an fdpic toolset for cortex-r cpu class. gcc version is
>> quite old (4.7).
>>
>>  Note also that generated code may crash on class A cpu due to
>> generation of udiv/sdiv which is optional for class A.
>> (cortex a15 is ok but not a9).
>>
>> Hope it helps
>
> Unfortunately, it doesn't help because it depends on FDPIC Linux patches
> which are out of tree and no link has been given.
>
> M-class toolchain should just work with A-class; you don't even need to
> disable MMU to try it out after d782e42 ("ARM: 8594/1: enable binfmt_flat on
> systems with an MMU").
>
> Cheers
> Vladimir
>
>>
>> Regards
>> Mickael
>>
>> On 12/11/2016 09:01 PM, Peter Korsgaard wrote:
>>>>>>>> "Afzal" == Afzal Mohammed <afzal.mohd.ma@gmail.com> writes:
>>>
>>> Hi,
>>>
>>>  >> You can build a toolchain and initramfs with Buildroot. Have a look at
>>>  >> the stm32f429 nommu config:
>>>  >>
>>>  >> https://git.buildroot.net/buildroot/tree/configs/stm32f429_disco_defconfig
>>>
>>>  > iiuc, it builds one for Cortex-M. i already had a file system w/
>>>  > busybox compiled using a Cortex-M toolchain (stolen from
>>>  > Pengutronix's OSELAS.Toolchain), which works on Cortex M4 (Vybrid
>>>  > VF610 M4 core). But it does not work here, i.e. on Cortex A, seems the
>>>  > above mentioned also would have the same effect.
>>>
>>> Hmm, I'm not sure why a cortex-M toolchain wouldn't work on cortex-A, I
>>> thought the 'M' instruction set was a pure subset of the 'A'.
>>>
>>>  > And in buildroot, couldn't see Cortex R option in menuconfig, and
>>>  > selecting Cortex-A's excludes flat binary target & presents only with
>>>  > ELF.
>>>
>>> We indeed don't have cortex-R support. I'm not aware of any cortex-R
>>> Linux support.
>>>
>>> When you select a cortex-A variant, then we enable MMU support by
>>> default, but you can disable it under toolchain options (Enable MMU) and
>>> then the flat binary option is available.
>>>
>>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-fdpic-Add-support-for-fdpic-binaries-loading.patch
Type: text/x-patch
Size: 10273 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/39f2c4af/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-fdpic-add-support-to-return-to-thumb2-code-from-sign.patch
Type: text/x-patch
Size: 2673 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/39f2c4af/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-fdpic-Add-get_tls-syscall.patch
Type: text/x-patch
Size: 1430 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/39f2c4af/attachment-0007.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-fdpic-Add-tls-support-for-cortex-m-cpu-family.patch
Type: text/x-patch
Size: 894 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/39f2c4af/attachment-0008.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0008-fdpic-Workaround-to-fix-futex-bug-on-mmu-less.patch
Type: text/x-patch
Size: 3635 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/39f2c4af/attachment-0009.bin>
