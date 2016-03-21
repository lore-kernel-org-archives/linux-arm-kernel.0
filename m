From: harninder.rai@nxp.com (Harninder Rai)
Date: Mon, 21 Mar 2016 10:27:49 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
Message-ID: <DB5PR04MB1688B860F637096FC8D4A59CE68F0@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takahiro Akashi,

With latest kexec-tools, I have moved little further
Here?s what I get. Is this correct?

kexec -p /run/media/mmcblk0p1/vmlinux --initrd=/run/media/mmcblk0p1/fsl-image-ls2085ardb.ext2.gz
kexec version: 16.03.14.10.05-gef652df-dirty
arch_process_options:112: command_line: (null)
arch_process_options:114: initrd: /run/media/mmcblk0p1/fsl-image-ls2085ardb.ext2.gz
arch_process_options:115: dtb: (null)
arch_process_options:117: port: 0x0
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /run/media/mmcblk0p1/vmlinux of 65536 bytes failed
kernel: 0xffffa5dfa010 kernel_size: 0x88ece7e
read_1st_dtb: found /sys/firmware/fdt
get_memory_ranges_dt:860: node_13292 memory at 80000000
get_memory_ranges_dt:887:  RAM: 0000000080000000 - 0000000100000000
get_memory_ranges_dt:887:  RAM: 0000008080000000 - 00000083c0000000
get_memory_ranges_dt:901: /sys/firmware/fdt: Success
elf_arm64_load: PE format: yes
p_vaddr: ffff800000080000
dump_crash_ranges: kernel: 000000008c000000 - 000000008fffffff (64 MiB)
dump_crash_ranges: RAM:    0000000080000000 - 000000008bffffff (192 MiB)
dump_crash_ranges: RAM:    0000008080000000 - 00000083bfffffff (13312 MiB)
dump_crash_ranges: RAM:    0000000090000000 - 00000000ffffffff (1792 MiB)
get_crash_notes_per_cpu: crash_notes addr = 83ae9c9200, size = 424
Elf header: p_type = 4, p_offset = 0x83ae9c9200 p_paddr = 0x83ae9c9200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea12200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea12200 p_paddr = 0x83aea12200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea13200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea13200 p_paddr = 0x83aea13200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea14200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea14200 p_paddr = 0x83aea14200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea15200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea15200 p_paddr = 0x83aea15200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea16200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea16200 p_paddr = 0x83aea16200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea17200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea17200 p_paddr = 0x83aea17200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = 83aea18200, size = 424
Elf header: p_type = 4, p_offset = 0x83aea18200 p_paddr = 0x83aea18200 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
vmcoreinfo header: p_type = 4, p_offset = 0x80c0bb90 p_paddr = 0x80c0bb90 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
phys_to_virt: 0000000080000000 -> ffff800000000000
Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0xffff800000000000 p_filesz = 0xc000000 p_memsz = 0xc000000
phys_to_virt: 0000008080000000 -> ffff808000000000
Elf header: p_type = 1, p_offset = 0x8080000000 p_paddr = 0x8080000000 p_vaddr = 0xffff808000000000 p_filesz = 0x340000000 p_memsz = 0x340000000
phys_to_virt: 0000000090000000 -> ffff800010000000
Elf header: p_type = 1, p_offset = 0x90000000 p_paddr = 0x90000000 p_vaddr = 0xffff800010000000 p_filesz = 0x70000000 p_memsz = 0x70000000
add_segment_phys_virt: 000000000f82eb30 - 000000000f82ef30 (00000400) -> 000000008ffff000 - 0000000090000000 (00001000)
load_crashdump_segments: elfcorehdr 0x8ffff000-0x8ffff3ff
virt_to_phys: ffff80000c080000 -> 000000008c080000
add_segment_phys_virt: 0000ffffa5e0a010 - 0000ffffa6983810 (00b79800) -> 000000008c080000 - 000000008cc3b000 (00bbb000)
elf_arm64_load: text_offset: 0000000000080000
elf_arm64_load: image_size:  0000000000bc1000
elf_arm64_load: page_offset: ffff800000000000
elf_arm64_load: memstart:    0000000080000000
virt_to_phys: ffff80008c080000 -> 000000010c080000
elf_arm64_load: e_entry:     ffff80008c080000 -> 000000010c080000
elf_arm64_load: kernel_entry:000000008c080000
arm64_load_other_segments:665: purgatory sink: 0x0
read_1st_dtb: found /sys/firmware/fdt
dump_reservemap: dtb_1 {80000000, 10000}
dump_reservemap: dtb_1 {fff0e590, 578}
dump_reservemap: dtb_1 {9fff9000, 4000}
dump_reservemap: dtb_1 {a0515e2c, 1a64530}
read_cpu_info: dtb_1 cpu-0 (/cpus/cpu at 0): hwid-0, 'spin-table', cpu-release-addr fff0e590
read_cpu_info: dtb_1 cpu-1 (/cpus/cpu at 1): hwid-1, 'spin-table', cpu-release-addr fff0e5d0
read_cpu_info: dtb_1 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table', cpu-release-addr fff0e690
read_cpu_info: dtb_1 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table', cpu-release-addr fff0e6d0
read_cpu_info: dtb_1 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table', cpu-release-addr fff0e790
read_cpu_info: dtb_1 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table', cpu-release-addr fff0e7d0
read_cpu_info: dtb_1 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table', cpu-release-addr fff0e890
read_cpu_info: dtb_1 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table', cpu-release-addr fff0e8d0
read_cpu_info: dtb_1 cpu-0 (/cpus/cpu at 0): hwid-0, 'spin-table', cpu-release-addr fff0e590
read_cpu_info: dtb_1 cpu-1 (/cpus/cpu at 1): hwid-1, 'spin-table', cpu-release-addr fff0e5d0
read_cpu_info: dtb_1 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table', cpu-release-addr fff0e690
read_cpu_info: dtb_1 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table', cpu-release-addr fff0e6d0
read_cpu_info: dtb_1 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table', cpu-release-addr fff0e790
read_cpu_info: dtb_1 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table', cpu-release-addr fff0e7d0
read_cpu_info: dtb_1 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table', cpu-release-addr fff0e890
read_cpu_info: dtb_1 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table', cpu-release-addr fff0e8d0
check_cpu_properties: hwid-0: OK
check_cpu_properties: hwid-1: OK
check_cpu_properties: hwid-100: OK
check_cpu_properties: hwid-101: OK
check_cpu_properties: hwid-200: OK
check_cpu_properties: hwid-201: OK
check_cpu_properties: hwid-300: OK
check_cpu_properties: hwid-301: OK
add_segment_phys_virt: 0000ffffa429b010 - 0000ffffa5df9fe5 (01b5efd5) -> 000000008cc41000 - 000000008e7a0000 (01b5f000)
initrd: base 8cc41000, size 1b5efd5h (28700629)
dtb_set_initrd: start 2361659392, end 2390360021, size 28700629 (28027 KiB)
add_segment_phys_virt: 000000000f83b1e0 - 000000000f83f32c (0000414c) -> 000000008e7a0000 - 000000008e7a5000 (00005000)
dtb:    base 8e7a0000, size 414ch (16716)
add_segment_phys_virt: 000000000f83f6f0 - 000000000f842b50 (00003460) -> 000000008e7a5000 - 000000008e7a9000 (00004000)
sym: sha256_starts info: 12 other: 00 shndx: 1 value: f60 size: 6c
sym: sha256_starts value: 8e7a5f60 addr: 8e7a5018
machine_apply_elf_rel: CALL26 580006b394000000->580006b3940003d2
sym: sha256_update info: 12 other: 00 shndx: 1 value: 3064 size: c
sym: sha256_update value: 8e7a8064 addr: 8e7a5034
machine_apply_elf_rel: CALL26 eb15027f94000000->eb15027f94000c0c
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 3070 size: 1c8
sym: sha256_finish value: 8e7a8070 addr: 8e7a504c
machine_apply_elf_rel: CALL26 d280040294000000->d280040294000c09
sym:     memcmp info: 12 other: 00 shndx: 1 value: 64c size: 34
sym: memcmp value: 8e7a564c addr: 8e7a505c
machine_apply_elf_rel: CALL26 340003c094000000->340003c09400017c
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a506c
machine_apply_elf_rel: CALL26 5800048094000000->580004809400013a
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a5074
machine_apply_elf_rel: CALL26 5800049594000000->5800049594000138
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a508c
machine_apply_elf_rel: CALL26 f100827f94000000->f100827f94000132
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a50a4
machine_apply_elf_rel: CALL26 5800038094000000->580003809400012c
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a50ac
machine_apply_elf_rel: CALL26 910402c094000000->910402c09400012a
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a50c0
machine_apply_elf_rel: CALL26 f100829f94000000->f100829f94000125
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a50d0
machine_apply_elf_rel: CALL26 5280002094000000->5280002094000121
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8e7a82d8 addr: 8e7a50f0
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a82d8
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8240 addr: 8e7a50f8
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8240
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8260 addr: 8e7a5100
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8260
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8270 addr: 8e7a5108
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8270
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8276 addr: 8e7a5110
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8276
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8278 addr: 8e7a5118
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8278
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a512c
machine_apply_elf_rel: CALL26 9400000094000000->940000009400010a
sym: setup_arch info: 12 other: 00 shndx: 1 value: f10 size: 2c
sym: setup_arch value: 8e7a5f10 addr: 8e7a5130
machine_apply_elf_rel: CALL26 5800016094000000->5800016094000378
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: ec
sym: verify_sha256_digest value: 8e7a5000 addr: 8e7a5140
machine_apply_elf_rel: CALL26 3400004094000000->3400004097ffffb0
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: ee0 size: 20
sym: post_verification_setup_arch value: 8e7a5ee0 addr: 8e7a5150
machine_apply_elf_rel: JUMP26 d503201f14000000->d503201f14000364
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a8288 addr: 8e7a5158
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8288
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8e7a82d8 addr: 8e7a5160
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a82d8
sym:    putchar info: 12 other: 00 shndx: 1 value: ea0 size: 34
sym: putchar value: 8e7a5ea0 addr: 8e7a51c4
machine_apply_elf_rel: CALL26 140000b494000000->140000b494000337
sym:    putchar info: 12 other: 00 shndx: 1 value: ea0 size: 34
sym: putchar value: 8e7a5ea0 addr: 8e7a5234
machine_apply_elf_rel: CALL26 9100069494000000->910006949400031b
sym:    putchar info: 12 other: 00 shndx: 1 value: ea0 size: 34
sym: putchar value: 8e7a5ea0 addr: 8e7a5488
machine_apply_elf_rel: CALL26 9100071894000000->9100071894000286
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a829a addr: 8e7a54c8
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a829a
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 168 size: 35c
sym: vsprintf value: 8e7a5168 addr: 8e7a5548
machine_apply_elf_rel: CALL26 a8d07bfd94000000->a8d07bfd97ffff08
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 168 size: 35c
sym: vsprintf value: 8e7a5168 addr: 8e7a55d8
machine_apply_elf_rel: CALL26 a8d17bfd94000000->a8d17bfd97fffee4
sym:  purgatory info: 12 other: 00 shndx: 1 value: 120 size: 34
sym: purgatory value: 8e7a5120 addr: 8e7a5688
machine_apply_elf_rel: CALL26 d280030094000000->d280030097fffea6
sym: arm64_sink info: 10 other: 00 shndx: 4 value: 128 size: 8
sym: arm64_sink value: 8e7a8400 addr: 8e7a5ed8
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8400
sym: arm64_kernel_entry info: 10 other: 00 shndx: 4 value: 130 size: 8
sym: arm64_kernel_entry value: 8e7a8408 addr: 8e7a5f00
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8408
sym: arm64_dtb_addr info: 10 other: 00 shndx: 4 value: 138 size: 8
sym: arm64_dtb_addr value: 8e7a8410 addr: 8e7a5f08
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8410
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a5f24
machine_apply_elf_rel: CALL26 5800014094000000->5800014097fffd8c
sym:     printf info: 12 other: 00 shndx: 1 value: 554 size: 90
sym: printf value: 8e7a5554 addr: 8e7a5f38
machine_apply_elf_rel: JUMP26 d503201f14000000->d503201f17fffd87
sym: arm64_kernel_entry info: 10 other: 00 shndx: 4 value: 130 size: 8
sym: arm64_kernel_entry value: 8e7a8408 addr: 8e7a5f40
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8408
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a82ab addr: 8e7a5f48
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a82ab
sym: arm64_dtb_addr info: 10 other: 00 shndx: 4 value: 138 size: 8
sym: arm64_dtb_addr value: 8e7a8410 addr: 8e7a5f50
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8410
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 8e7a82c1 addr: 8e7a5f58
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a82c1
sym: sha256_process info: 12 other: 00 shndx: 1 value: fcc size: 1f94
sym: sha256_process value: 8e7a5fcc addr: 8e7a7fd8
machine_apply_elf_rel: CALL26 f100fe9f94000000->f100fe9f97fff7fd
sym:     memcpy info: 12 other: 00 shndx: 1 value: 62c size: 20
sym: memcpy value: 8e7a562c addr: 8e7a8028
machine_apply_elf_rel: CALL26 9100c2a194000000->9100c2a197fff581
sym: sha256_process info: 12 other: 00 shndx: 1 value: fcc size: 1f94
sym: sha256_process value: 8e7a5fcc addr: 8e7a8034
machine_apply_elf_rel: CALL26 17ffffe094000000->17ffffe097fff7e6
sym:     memcpy info: 12 other: 00 shndx: 1 value: 62c size: 20
sym: memcpy value: 8e7a562c addr: 8e7a8058
machine_apply_elf_rel: JUMP26 aa1603e214000000->aa1603e217fff575
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 8e7a8420 addr: 8e7a8238
machine_apply_elf_rel: ABS64 0000000000000000->000000008e7a8420
kexec_load: entry = 0x8e7a5680 flags = 0xb70001
nr_segments = 5
segment[0].buf   = 0xffffa5e0a010
segment[0].bufsz = 0xb79800
segment[0].mem   = 0x8c080000
segment[0].memsz = 0xbbb000
segment[1].buf   = 0xffffa429b010
segment[1].bufsz = 0x1b5efd5
segment[1].mem   = 0x8cc41000
segment[1].memsz = 0x1b5f000
segment[2].buf   = 0xf83b1e0
segment[2].bufsz = 0x414c
segment[2].mem   = 0x8e7a0000
segment[2].memsz = 0x5000
segment[3].buf   = 0xf83f6f0
segment[3].bufsz = 0x3460
segment[3].mem   = 0x8e7a5000
segment[3].memsz = 0x4000
segment[4].buf   = 0xf82eb30
segment[4].bufsz = 0x400
segment[4].mem   = 0x8ffff000
segment[4].memsz = 0x1000



And I do get a kernel panic when I try to dump the image of panicked kernel (using /proc/sysrq-trigger)


Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc6-00038-gae2804a-dirty (hrai at nmglablinux22) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC 4.8-2014.04) ) #2 SMP PREEMPT Fri Mar 11 14:45:30 IST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] Ignoring memory range 0x80000000 - 0x8c000000
[    0.000000] earlycon: Early serial console at MMIO 0x21c0600 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] crashkernel has wrong address or size
[    0.000000] Reserving 1KB of memory at 0x8ffff000 for elfcorehdr
[    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 0000000080000000, 0000000000010000
[    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 00000000fff0e590, 0000000000000578
[    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 000000009fff9000, 0000000000004000
[    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 00000000a0515e2c, 0000000001a64530
[    0.000000] cma: Reserved 16 MiB at 0x000000008ec00000
[    0.000000] Kernel panic - not syncing: memblock_virt_alloc_try_nid: Failed to allocate 2097152 bytes align=0x200000 nid=0 from=0x8c000000 max_addr=0x0
[    0.000000]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc6-00038-gae2804a-dirty #2
[    0.000000] Hardware name: Freescale Layerscape 2085a RDB Board (DT)
[    0.000000] Call trace:
[    0.000000] [<ffff800000089760>] dump_backtrace+0x0/0x1ac
[    0.000000] [<ffff800000089920>] show_stack+0x14/0x1c
[    0.000000] [<ffff80000032c1d4>] dump_stack+0x8c/0xb0
[    0.000000] [<ffff80000014c420>] panic+0x120/0x288
[    0.000000] [<ffff800000ab01a0>] memblock_virt_alloc_try

Thanks and Regards
Harry++
