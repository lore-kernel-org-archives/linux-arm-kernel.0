From: drjones@redhat.com (Andrew Jones)
Date: Wed, 25 Mar 2015 10:44:42 +0100
Subject: ARM: KVM/XEN: how should we support virt-what?
Message-ID: <20150325094440.GB3163@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM virt maintainers,

I'd like to start a discussion about supporting virt-what[1]. virt-what
allows userspace to determine if the system it's running on is running
in a guest, and of what type (KVM, Xen, etc.). Despite it being a best
effort tool, see the Caveat emptor in [1], it has become quite a useful
tool, and is showing up in different places, such as OpenStack. If you
look at the code[2], specifically [3], then you'll see how it works on
x86, which is to use the dedicated hypervisor cpuid leaves. I'm
wondering what equivalent we have, or can develop, for arm.
Here are some thoughts;
0) there's already something we can use, and I just need to be told
   about it.
1) be as similar as possible to x86 by dedicating some currently
   undefined sysreg bits. This would take buy-in from lots of parties,
   so is not likely the way to go.
2) create a specific DT node that will get exposed through sysfs, or
   somewhere.
3) same as (2), but just use the nodes currently in mach-virt's DT
   as the indication we're a guest. This would just be a heuristic,
   i.e. "have virtio mmio" && psci.method == hvc, or something,
   and we'd still need a way to know if we're kvm vs. xen vs. ??.

Thanks,
drew 

[1] http://people.redhat.com/~rjones/virt-what/
[2] http://git.annexia.org/?p=virt-what.git;a=summary
[3] http://git.annexia.org/?p=virt-what.git;a=blob_plain;f=virt-what-cpuid-helper.c;hb=HEAD
