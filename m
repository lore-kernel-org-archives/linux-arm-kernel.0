From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Feb 2015 10:39:33 +0000
Subject: stand-alone kvmtool
Message-ID: <54DDD465.3050300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

as I found it increasingly inconvenient to use kvmtool[1] as part of a
Linux repository, I decided to give it a go and make it a stand-alone
project. So I filtered all the respective commits, adjusted the paths in
there (while keeping authorship and commit date, of course) and then
added the missing bits to let it compile without a kernel tree nearby.
The result is now available on:

git://linux-arm.org/kvmtool.git
http://linux-arm.org/kvmtool.git

You can simply check it out, type make and use "./lkvm run" for a quick
test. So far I briefly tested x86-64, arm and arm64, the later two were
also cross-compiled. For sure there are rough edges in there (for
instance copying a few non-uapi header files into), but I deem it worthy
enough to get some public comments.
For me that also fixed some nasty warnings about libfdt, which now are
gone due it using your system library version of it.
I also managed to get rid of the libc-i386-dev dependency when compiling
for x86-64, but that still needs to be cleaned up and thus is not in the
current HEAD.
I haven't got around to compile-test the other supported architectures,
but supporting them should be as easy as copying over the uapi kvm.h
header file (see the respective ARM commit). Contributions (and tests!)
are welcome.

Please give it a go and tell me what you think. I don't want to fork the
project, so I am happy if someone "official" picks it up.

Cheers,
Andre.

[1] https://github.com/penberg/linux-kvm/tree/master/tools/kvm
