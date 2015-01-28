From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jan 2015 11:36:38 +0000
Subject: arm32 binaries work with CONFIG_COMPAT as root but not as user?
In-Reply-To: <20150128112249.GD6646@e104818-lin.cambridge.arm.com>
References: <CAAqcGHnS7P7=xzXoOPE61dcbbq_1kvmeB-V1GcDUxB1ND0-kZA@mail.gmail.com>
 <20150128112249.GD6646@e104818-lin.cambridge.arm.com>
Message-ID: <54C8C9C6.8060001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/15 11:22, Catalin Marinas wrote:
> On Wed, Jan 28, 2015 at 10:52:21AM +0000, Riku Voipio wrote:
>> Perhaps I'm missing here something, but seems I can only run 32bit arm
>> programs on arm64 system if I am root. So far even the simplest hello
>> world will be killed/segfaulted on startup. This is on mustang hw.
>>
>> taking on 3.19-rc3 with arch=arm64 and make defconfig:
> 
> It works for me with the arm64 for-next/core branch, I haven't tried
> vanilla 3.19-rc3 yet. Do you have other patches applied?

I'm running -rc5 on mustang, and this works perfectly fine:

maz at mystery-roach:~$ uname -a
Linux mystery-roach 3.19.0-rc5+ #3704 SMP Wed Jan 28 11:25:36 GMT 2015 aarch64 GNU/Linux
maz at mystery-roach:~$ file hello 
hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, for GNU/Linux 2.6.32, BuildID[sha1]=c37a3b366d645eee600963a535370fa0bad9b2c0, not stripped
maz at mystery-roach:~$ id
uid=1000(maz) gid=1000(maz) groups=1000(maz),27(sudo),110(kvm)
maz at mystery-roach:~$ ./hello 
hello world

Userspace is Debian arm64 unstable.

	M.
-- 
Jazz is not dead. It just smells funny...
