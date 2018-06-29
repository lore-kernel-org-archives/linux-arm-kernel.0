From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 29 Jun 2018 17:20:42 +0200
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
In-Reply-To: <CAAeHK+x4jaN9w8O+hYJ0835Ln=rQ8VT1=ZrKLNsBOT92+iOwdQ@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+x4jaN9w8O+hYJ0835Ln=rQ8VT1=ZrKLNsBOT92+iOwdQ@mail.gmail.com>
Message-ID: <CAAeHK+yP=oS6EP4g0jqvLSp_=n_Go8WyhJDS-BegJFCWFbAUiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 5:19 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> a bunch of compat
> a bunch of ioctl that use ptr to stored ints
>
> ipc/shm.c:1355
> ipc/shm.c:1566
>
> mm/process_vm_access.c:178:20
> mm/process_vm_access.c:180:19
> substraction => harmless
>
> mm/process_vm_access.c:221:4
> ?
>
> mm/memory.c:4679:14
> should be __user pointer
>
> fs/fuse/file.c:1256:9
> ?
>
> kernel/kthread.c:73:9
> ?
>
> mm/migrate.c:1586:10
> mm/migrate.c:1660:24
>
> lib/iov_iter.c
> ???
>
> kernel/futex.c:502
> uses user addr as key
>
> kernel/futex.c:730
> gup, fixed
>
> lib/strncpy_from_user.c:110:13
> fixed?
>
> lib/strnlen_user.c:112
> fixed?
>
> fs/readdir.c:369
> ???

Started looking at the results and accidentally posted my notes.
Ignore this for now, will post when done.
