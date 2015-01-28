From: riku.voipio@linaro.org (Riku Voipio)
Date: Wed, 28 Jan 2015 12:52:21 +0200
Subject: arm32 binaries work with CONFIG_COMPAT as root but not as user?
Message-ID: <CAAqcGHnS7P7=xzXoOPE61dcbbq_1kvmeB-V1GcDUxB1ND0-kZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Perhaps I'm missing here something, but seems I can only run 32bit arm
programs on arm64 system if I am root. So far even the simplest hello
world will be killed/segfaulted on startup. This is on mustang hw.

taking on 3.19-rc3 with arch=arm64 and make defconfig:

wget http://kos.to/hello-test/hello
# file hello
hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV),
statically linked, for GNU/Linux 2.6.32,
BuildID[sha1]=c37a3b366d645eee600963a535370fa0bad9b2c0, not stripped
# ./hello
hello world
# su - linaro
$ /root/hello
Segmentation fault
$ gdb /root/hello
(gdb) run
Starting program: /root/hello
During startup program terminated with signal SIGSEGV, Segmentation fault.

If you have a debian/ubuntu system, you can also reproduce it with multiarch:

dpkg --add-architecture armhf
apt-get update
apt-get install hello:armhf
# hello
Hello, world!
# su - ubuntu
$ hello
Segmentation fault
$
