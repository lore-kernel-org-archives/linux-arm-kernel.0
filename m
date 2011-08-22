From: amwang@redhat.com (Cong Wang)
Date: Mon, 22 Aug 2011 16:42:48 +0800
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
Message-ID: <4E521688.1000701@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?08?20? 08:37, Arnaud Lacombe ??:
> Hi folks,
>
> The attached patch modify Kbuild to allow to directly re-use code in multiple
> directory without having to go through a copy. Technically, it changes Kbuild to
> use by default the VPATH feature of GNU make and provides accessors for Makefile
> to change it indirectly.
...
>
> With the attached patch, we would do:
>
> arch/foo/boot/Makefile:
> LDFLAGS_fancy.o := -DPANTS=30
> obj-y += fancy.o
> vpath-y += $(srctree)/arch/foo/lib
>
> and let GNU make do the job.

Just note that don't forget to update Documentation/kbuild/makefiles.txt. ;)

Thanks.
